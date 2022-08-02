import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mono_kit/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'paging_notifier.freezed.dart';

class PagingNotifier<T> extends StateNotifier<PagingState<T>> {
  PagingNotifier({
    required Query<T> query,
    this.defaultPagingSize = 10,
    int initialSize = 20,
  })  : _limitController = BehaviorSubject.seeded(initialSize),
        super(PagingState(snapshots: const AsyncLoading())) {
    _querySubscription = _limitController.stream
        .switchMap((limit) => query.limit(limit + 1).snapshots())
        // クルクルをじっくりみたい時
        .debounceTime(const Duration(seconds: 1))
        .listen((snapshot) {
      _isLoadingMore = false;
      final snapshots = snapshot.docs;
      final limit = _limitController.value;
      final snapshotsSize = snapshots.length;
      final size = min(snapshotsSize, limit);
      state = state.copyWith(
        snapshots: AsyncValue.data(snapshots.take(size).toList()),
        hasMore: snapshotsSize > limit,
      );
    });
  }

  late final StreamSubscription<void> _querySubscription;
  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  var _isLoadingMore = false;

  bool loadMoreIfNeeded({int? pagingSize}) {
    // `!state.snapshots.isRefreshing` でチェックで済ませたかったが、
    // addPostFrameCallbackする故に連続で呼ばれた時に弾けない
    final hasMore = state.hasMore && !_isLoadingMore;
    if (hasMore) {
      _isLoadingMore = true;
      logger.info('loaded more');
      // Firestore取得がキャッシュ経由などで高速過ぎるとこのsetが取得より後になってLoadingで落ち着いてしまう問題あり
      // debounceTimeなどで一瞬遅らせればとりあえず回避可能
      WidgetsBinding.instance.addPostFrameCallback((_) {
        state = state.copyWith(
          snapshots:
              AsyncLoading<List<QueryDocumentSnapshot<T>>>().copyWithPrevious(
            state.snapshots,
          ),
        );
      });
      _limitController.add(
        _limitController.value + (pagingSize ?? defaultPagingSize),
      );
    }
    return hasMore;
  }

  @override
  void dispose() {
    _limitController.close();
    _querySubscription.cancel();
    super.dispose();
  }
}

@freezed
class PagingState<T> with _$PagingState<T> {
  factory PagingState({
    @Default(true) bool hasMore,
    required AsyncValue<List<QueryDocumentSnapshot<T>>> snapshots,
  }) = _PagingState;
  PagingState._();
}
