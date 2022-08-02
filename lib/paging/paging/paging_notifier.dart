import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mono_kit/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'paging_notifier.freezed.dart';

class PagingNotifier<T> extends StateNotifier<AsyncValue<PagingState<T>>> {
  PagingNotifier({
    required Query<T> query,
    this.defaultPagingSize = 10,
    int initialSize = 20,
  })  : _limitController = BehaviorSubject.seeded(initialSize),
        super(const AsyncLoading()) {
    _querySubscription = _limitController.stream
        .switchMap((limit) => query.limit(limit + 1).snapshots())
        // クルクルをじっくりみたい時
        // .debounceTime(const Duration(seconds: 1))
        .listen((snapshot) {
      final snapshots = snapshot.docs;
      final limit = _limitController.value;
      final snapshotsSize = snapshots.length;
      state = AsyncData(
        PagingState(
          snapshots: snapshots.take(min(snapshotsSize, limit)).toList(),
          hasMore: snapshotsSize > limit,
        ),
      );
    });
  }

  late final StreamSubscription<void> _querySubscription;
  final int defaultPagingSize;
  final BehaviorSubject<int> _limitController;
  bool loadMoreIfNeeded({int? pagingSize}) {
    final hasMore = state.value?.hasMore == true && !state.isRefreshing;
    if (hasMore) {
      logger.info('loaded more');
      state = AsyncLoading<PagingState<T>>().copyWithPrevious(
        state,
      );
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
    required bool hasMore,
    required List<QueryDocumentSnapshot<T>> snapshots,
  }) = _PagingState;
  PagingState._();
}
