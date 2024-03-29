import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/main_deep_link.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_paging/api_paging_notifier.dart';

part 'api_users_page.freezed.dart';
part 'api_users_page.g.dart';

class ApiUsersPage extends ConsumerWidget {
  const ApiUsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final pagingAsync = ref.watch(usersPagingController);
    final paging = pagingAsync.value;
    final pagingNotifier = ref.watch(usersPagingController.notifier);
    final users = paging?.items ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: paging == null
          ? centeredCircularProgressIndicator
          : ListView.builder(
              itemCount: paging.itemLoadingCount,
              itemBuilder: (context, index) {
                if (paging.isLoadingIndex(index)) {
                  pagingNotifier.loadMoreIfNeeded();
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      centeredCircularProgressIndicator,
                      if (pagingAsync.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'エラー',
                            style: TextStyle(
                              color: colorScheme.error,
                            ),
                          ),
                        ),
                    ],
                  );
                }
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                );
              },
            ),
    );
  }
}

final usersRefProvider = Provider(
  (ref) => FirebaseFirestore.instance.collection('sampleUsers').withConverter(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      ),
);

@freezed
class User with _$User {
  const factory User({
    required String name,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  const User._();
}

// 例外再現
bool _throwError = true;

// 各ページでそれぞれ必要な実装
final usersPagingController = AsyncNotifierProvider.autoDispose<
    ApiPagingNotifier<User>, PagingState<User>>(
  () => ApiPagingNotifier(
    fetcher: ({required from, required size}) async {
      // 実際にはここで Web API リクエスト
      await Future<void>.delayed(const Duration(seconds: 1));
      // 例外再現
      if (_throwError && from == 30) {
        _throwError = false;
        throw Exception('dummy error');
      }
      return List.generate(
        // 43件しか無いと仮定
        from >= 40 ? 3 : size,
        (index) => User(name: 'User ${from + index}'),
      );
    },
  ),
);
