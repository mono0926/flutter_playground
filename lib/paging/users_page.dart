import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'paging/paging_loader.dart';
import 'paging/paging_notifier.dart';

part 'users_page.freezed.dart';
part 'users_page.g.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paging = ref.watch(usersPagingController);
    final pagingNotifier = ref.watch(usersPagingController.notifier);
    final users = paging.snapshots.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: PagingLoader(
        notifier: pagingNotifier,
        state: paging,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index].data();
            return ListTile(
              title: Text(user.name),
            );
          },
        ),
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

final usersPagingController =
    StateNotifierProvider.autoDispose<PagingNotifier<User>, PagingState<User>>(
  (ref) => PagingNotifier(
    query: ref.watch(usersRefProvider),
  ),
);
