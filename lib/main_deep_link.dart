import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/firestore_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/extensions/theme_data.dart';

import 'firebase_options.dart';
import 'main_router_location.dart';

part 'main_deep_link.freezed.dart';
part 'main_deep_link.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // `flutterfire configure`で自動生成されたコードで初期化(接続設定ファイル要らず)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // URLから `#` を除去
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

@freezed
class User with _$User {
  const factory User({
    required String name,
  }) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  const User._();
}

@freezed
class Document<E> with _$Document<E> {
  const factory Document(String id, E entity) = _Document;
  const Document._();
}

final usersRefProvider = Provider(
  (ref) => FirebaseFirestore.instance.collection('sampleUsers').withConverter(
        fromFirestore: (snap, _) => User.fromJson(snap.data()!),
        toFirestore: (user, _) => user.toJson(),
      ),
);

// 上位20件のusersのStream
final usersProvider = StreamProvider(
  (ref) => ref.watch(usersRefProvider).limit(20).snapshots().map(
        (snap) => snap.docs
            .map(
              (snap) => Document(
                snap.id,
                snap.data(),
              ),
            )
            .toList(),
      ),
);

// user個別のStream
// 個別に監視し続けるのはダメなのでautoDisposeにしてリスナーがゼロになったら解除されるように。
final userProviders = StreamProvider.family.autoDispose(
  (ref, String id) {
    return ref
        .watch(usersRefProvider)
        .doc(id)
        .snapshots()
        .map((snap) => Document(id, snap.data()!));
  },
);

// user id の scoped provider
// リストの要素・詳細ページなどを `ProviderScope(overrides:)`にて
// 特定のuser id指定しながら囲むと、その配下のWidgetツリーで watch/read できるようになる。
// override漏れがあると実行時エラーになるので注意。
// これ使わずにバケツリレーでも良いが、
// これを使うとその手間がなくなることに加えてconst Widgetで区切れるメリットもある。
final userIdProvider = Provider<String>((ref) => throw UnimplementedError());

// 実際にはProviderで囲むと便利
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
      routes: [
        GoRoute(
          path: 'users',
          builder: (_, __) => const UsersPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, state) => ProviderScope(
                overrides: [
                  userIdProvider.overrideWithValue(state.params['id']!)
                ],
                child: const UserPage(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  // 右下にパス表示・指定できる独自ボタン配置
  navigatorBuilder: (_, __, child) => GoRouterLocationButton(
    child: child,
  ),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme(),
      darkTheme: darkTheme(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('/users'),
          ),
          const Divider(height: 0),
          const Gap(8),
          Center(
            child: ElevatedButton(
              onPressed: () {
                final person = Faker().person;
                final usersRef = ref.read(usersRefProvider);
                for (var i = 0; i < 100; i++) {
                  usersRef.add(User(name: person.name()));
                }
              },
              child: const Text('Generate Fake 100 Users'),
            ),
          ),
          const Gap(8),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // キャッシュを消せるようにしたかったのだけど、エラー出る🤔
                // [cloud_firestore/failed-precondition] Operation was rejected because the system is not in a state required for the operation's execution
                FirebaseFirestore.instance.clearPersistence();
              },
              child: const Text('Clear Cache'),
            ),
          ),
          const Gap(8),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.error,
              ),
              onPressed: () {
                deleteAllDocuments(query: ref.read(usersRefProvider));
              },
              child: const Text('Delete All Users'),
            ),
          ),
        ],
      ),
    );
  }
}

class UsersPage extends ConsumerWidget {
  const UsersPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FirestoreはSDK内部で誤用・セキュリティルールミス以外では
    // 基本エラー起こらないので、その分岐表示は不要で、
    // 未取得時にクルクル出るようにする(空画面でも良い)だけで充分
    final users = ref.watch(usersProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users (limit: 20)'),
      ),
      body: users == null
          ? centeredCircularProgressIndicator
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final userId = user.id;
                return ProviderScope(
                  key: ValueKey(userId),
                  overrides: [
                    userIdProvider.overrideWithValue(userId),
                  ],
                  child: const _UserTile(),
                );
              },
            ),
    );
  }
}

class _UserTile extends ConsumerWidget {
  const _UserTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final username = ref.watch(
      userProviders(userId).select((user) => user.value?.entity.name ?? ''),
    );
    return ListTile(
      title: Text(username),
      subtitle: Text(userId),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.go('/users/$userId'),
    );
  }
}

class UserPage extends ConsumerWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    // 一覧からの遷移ならローカルにデータがあるので初回表示から名前が取得できる。
    // Firestoreを使わない時も同様の挙動になるようなケアが必要。
    // (single source of truth的なデータソースからの取得にするイメージ)
    // ディープリンク・URLでの遷移だと初回は基本nullになる(Firestoreキャッシュされてたらその直後に一瞬で取得される)
    final username = ref.watch(
      userProviders(userId).select((user) => user.value?.entity.name),
    );
    return Scaffold(
      appBar: AppBar(title: Text(userId)),
      body: username == null
          ? centeredCircularProgressIndicator
          : Center(child: Text(username)),
    );
  }
}

const centeredCircularProgressIndicator = Center(
  child: CircularProgressIndicator.adaptive(),
);
