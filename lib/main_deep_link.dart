import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/firestore_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mono_kit/mono_kit.dart';

import 'firebase_options.dart';

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
      // child: RootRestorationScope(
      //   restorationId: 'root',
      child: App(),
    ),
    // ),
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
final userProviders =
    StreamProvider.family.autoDispose<Document<User?>, String>(
  (ref, id) {
    // ユーザー一覧で取得済みだったら個別に監視せずに済むように(READコスト節約)
    final users = ref.watch(usersProvider).value ?? [];
    final user = users.firstWhereOrNull((user) => user.id == id);
    return user != null
        ? Stream.value(user)
        : ref
            .watch(usersRefProvider)
            .doc(id)
            .snapshots()
            .map((snap) => Document(id, snap.data()));
  },
);

// user id の scoped provider
// リストの要素・詳細ページなどを `ProviderScope(overrides:)`にて
// 特定のuser id指定しながら囲むと、その配下のWidgetツリーで watch/read できるようになる。
// override漏れがあると実行時エラーになるので注意。
// これ使わずにバケツリレーでも良いが、
// これを使うとその手間がなくなることに加えてconst Widgetで区切れるメリットもある。
final userIdProvider = Provider<String>((ref) => throw UnimplementedError());

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    // restorationScopeId: 'router',
    routes: $appRoutes,
    // 右下にパス表示・指定できる独自ボタン配置
    navigatorBuilder: goRouteLocationButtonNavigationBuilder,
  ),
);

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: lightTheme(),
      darkTheme: darkTheme(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      // restorationScopeId: 'app',
    );
  }
}

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<UsersRoute>(
      path: 'users',
      routes: [
        TypedGoRoute<UserRoute>(path: ':userId'),
      ],
    ),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext context) => const HomePage();
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoRouter・Riverpod Example'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('users'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => const UsersRoute().go(context),
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
                foregroundColor: Theme.of(context).colorScheme.error,
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

class UsersRoute extends GoRouteData {
  const UsersRoute();
  @override
  Widget build(BuildContext context) => const UsersPage();
}

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FirestoreはSDK内部で諸々ケアされているため、
    // 誤用・セキュリティルールミス以外では基本エラー起こらないので、
    // その分岐表示は不要で、未取得時にクルクル出るようにする(空画面でも良い)だけで充分
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
                final userId = users[index].id;
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
  const _UserTile();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    final username = ref.watch(
      userProviders(userId).select((user) => user.value?.entity!.name ?? ''),
    );
    return ListTile(
      title: Text(username),
      subtitle: Text(userId),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => UserRoute(userId).go(context),
    );
  }
}

class UserRoute extends GoRouteData {
  const UserRoute(this.userId);
  final String userId;
  @override
  Widget build(BuildContext context) => ProviderScope(
        overrides: [userIdProvider.overrideWithValue(userId)],
        child: const UserPage(),
      );
}

class UserPage extends ConsumerWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return Scaffold(
      appBar: AppBar(title: Text(userId)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 一覧からの遷移ならローカルにデータがあるので初回表示から `data:`に分岐される。
            // Firestoreを使わない時も同様の挙動になるようなケアが必要。
            // (single source of truth的なデータソースからの取得にするイメージ)
            // ディープリンク・URLでの遷移だと初回は基本 `loading:` になる
            // (Firestoreキャッシュされてたらその直後に一瞬で取得される)
            ref
                .watch(
                  userProviders(userId).select(
                    (v) => v.whenData((v) => v.entity?.name ?? 'Not Found!!'),
                  ),
                )
                .when(
                  loading: () => centeredCircularProgressIndicator,
                  error: (e, _) => throw AssertionError(e),
                  data: (username) {
                    return Center(child: Text(username));
                  },
                ),
            const Gap(8),
            ElevatedButton(
              onPressed: () {
                showModal<void>(
                  context: context,
                  builder: (modalContext) => ProviderScope(
                    // `modalContext`はダイアログ用の別Widgetツリーなので
                    // それを使うと動かないので注意
                    parent: ProviderScope.containerOf(context),
                    child: const _Dialog(),
                  ),
                );
              },
              child: const Text('Show Dialog'),
            )
          ],
        ),
      ),
    );
  }
}

class _Dialog extends ConsumerWidget {
  const _Dialog();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    return AlertDialog(
      title: const Text('ID'),
      content: Text(userId),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
        ),
      ],
    );
  }
}

const centeredCircularProgressIndicator = Center(
  child: CircularProgressIndicator.adaptive(),
);
