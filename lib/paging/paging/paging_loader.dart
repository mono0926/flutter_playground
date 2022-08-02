import 'package:flutter/material.dart';
import 'package:flutter_playground/main_deep_link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paging_notifier.dart';

class PagingLoader<T> extends StatelessWidget {
  const PagingLoader({
    super.key,
    required this.notifier,
    required this.stateAsync,
    required this.child,
  });

  final PagingNotifier<T> notifier;
  final AsyncValue<PagingState<T>> stateAsync;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final state = stateAsync.value;
    return state == null
        ? centeredCircularProgressIndicator
        : NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (state.hasMore && notification.metrics.extentAfter == 0) {
                notifier.loadMoreIfNeeded();
              }
              return false;
            },
            child: Column(
              children: [
                Expanded(
                  child: child,
                ),
                if (stateAsync.isRefreshing) centeredCircularProgressIndicator,
              ],
            ),
          );
  }
}
