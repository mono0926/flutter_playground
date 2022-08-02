import 'package:flutter/material.dart';
import 'package:flutter_playground/main_deep_link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'paging_notifier.dart';

class PagingLoader<T> extends StatelessWidget {
  const PagingLoader({
    super.key,
    required this.notifier,
    required this.state,
    required this.child,
  });

  final PagingNotifier<T> notifier;
  final PagingState<T> state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final snapshots = state.snapshots;
    return snapshots.value == null
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
                if (snapshots.isRefreshing) centeredCircularProgressIndicator,
              ],
            ),
          );
  }
}
