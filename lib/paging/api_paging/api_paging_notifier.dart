// ignore_for_file: avoid_public_notifier_properties
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mono_kit/utils/logger.dart';

part 'api_paging_notifier.freezed.dart';

// from件目からsize件取得イメージ
typedef PagingFetcher<T> = Future<List<T>> Function({
  required int from,
  required int size,
});

class ApiPagingNotifier<T> extends AutoDisposeAsyncNotifier<PagingState<T>> {
  ApiPagingNotifier({
    required this.fetcher,
    this.defaultPagingSize = 10,
    this.initialSize = 20,
  });
  @override
  FutureOr<PagingState<T>> build() => _fetchNext(pagingSize: initialSize);

  final int initialSize;
  final PagingFetcher<T> fetcher;
  final int defaultPagingSize;
  var _isLoadingMore = false;

  Future<PagingState<T>> _fetchNext({required int pagingSize}) async {
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
  }

  Future<void> loadMoreIfNeeded({int? pagingSize}) async {
    // `!state.snapshots.isRefreshing` でチェックで済ませたかったが、
    // addPostFrameCallbackする故に連続で呼ばれた時に弾けない
    if (_isLoadingMore || !(state.value?.hasMore ?? true)) {
      return;
    }
    try {
      _isLoadingMore = true;
      logger.info('loaded more');
      await update(
        (_) => _fetchNext(
          pagingSize: pagingSize ?? defaultPagingSize,
        ),
      );
    } on Exception catch (e) {
      logger.warning('state is error: $e');
    } finally {
      _isLoadingMore = false;
    }
  }
}

@freezed
class PagingState<T> with _$PagingState<T> {
  factory PagingState({
    required bool hasMore,
    required List<T> items,
  }) = _PagingState;
  PagingState._();

  late final itemLoadingCount = items.length + (hasMore ? 1 : 0);

  bool isLoadingIndex(int index) => hasMore && (index + 1) == itemLoadingCount;
}
