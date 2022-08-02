import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mono_kit/utils/logger.dart';

part 'api_paging_notifier.freezed.dart';

// from件目からsize件取得イメージ
typedef PagingFetcher<T> = Future<List<T>> Function({
  required int from,
  required int size,
});

class ApiPagingNotifier<T> extends StateNotifier<PagingState<T>> {
  ApiPagingNotifier({
    required this.fetcher,
    this.defaultPagingSize = 10,
    int initialSize = 20,
  }) : super(PagingState(items: const AsyncLoading())) {
    _loadMoreIfNeeded(pagingSize: initialSize);
  }

  final PagingFetcher<T> fetcher;
  final int defaultPagingSize;
  var _isLoadingMore = false;

  Future<void> _loadMoreIfNeeded({required int pagingSize}) async {
    // `!state.snapshots.isRefreshing` でチェックで済ませたかったが、
    // addPostFrameCallbackする故に連続で呼ばれた時に弾けない
    if (state.hasMore && !_isLoadingMore) {
      _isLoadingMore = true;
      logger.info('loaded more');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(
          items: AsyncLoading<List<T>>().copyWithPrevious(
            state.items,
          ),
        );
      });
      // guard内でエラーが発生した時になってほしい値は、再操作でリトライできるようにtrueのはず
      var hasMore = true;
      final items = await AsyncValue.guard(() async {
        final items = await fetcher(
          from: state.items.value?.length ?? 0,
          size: pagingSize + 1,
        );
        hasMore = items.length > pagingSize;
        return <T>[
          ...state.items.value ?? [],
          ...items.take(pagingSize),
        ];
      });
      state = state.copyWith(
        items: items,
        hasMore: hasMore,
      );
      _isLoadingMore = false;
    }
  }

  void loadMoreIfNeeded({int? pagingSize}) =>
      _loadMoreIfNeeded(pagingSize: pagingSize ?? defaultPagingSize);
}

@freezed
class PagingState<T> with _$PagingState<T> {
  factory PagingState({
    @Default(true) bool hasMore,
    required AsyncValue<List<T>> items,
  }) = _PagingState;
  PagingState._();

  late final itemLoadingCount = (items.value?.length ?? 0) + (hasMore ? 1 : 0);

  bool isLoadingIndex(int index) => hasMore && (index + 1) == itemLoadingCount;
}
