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

class ApiPagingNotifier<T> extends StateNotifier<AsyncValue<PagingState<T>>> {
  ApiPagingNotifier({
    required this.fetcher,
    this.defaultPagingSize = 10,
    int initialSize = 20,
  }) : super(const AsyncLoading()) {
    _loadMoreIfNeeded(pagingSize: initialSize);
  }

  final PagingFetcher<T> fetcher;
  final int defaultPagingSize;
  var _isLoadingMore = false;

  Future<void> _loadMoreIfNeeded({required int pagingSize}) async {
    // `!state.snapshots.isRefreshing` でチェックで済ませたかったが、
    // addPostFrameCallbackする故に連続で呼ばれた時に弾けない
    if ((state.value?.hasMore ?? true) && !_isLoadingMore) {
      _isLoadingMore = true;
      logger.info('loaded more');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = AsyncLoading<PagingState<T>>().copyWithPrevious(
          state,
        );
      });
      state = (await AsyncValue.guard(() async {
        final fetchedItems = await fetcher(
          from: state.value?.items.length ?? 0,
          size: pagingSize + 1,
        );
        return PagingState(
          items: <T>[
            ...state.value?.items ?? [],
            ...fetchedItems.take(pagingSize),
          ],
          hasMore: fetchedItems.length > pagingSize,
        );
      }))
          .copyWithPrevious(state);
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
    required List<T> items,
  }) = _PagingState;
  PagingState._();

  late final itemLoadingCount = items.length + (hasMore ? 1 : 0);

  bool isLoadingIndex(int index) => hasMore && (index + 1) == itemLoadingCount;
}
