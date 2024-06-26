// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'main_deep_link.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeRoute,
    ];

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'users',
          factory: $UsersRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: ':userId',
              factory: $UserRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UsersRouteExtension on UsersRoute {
  static UsersRoute _fromState(GoRouterState state) => const UsersRoute();

  String get location => GoRouteData.$location(
        '/users',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserRouteExtension on UserRoute {
  static UserRoute _fromState(GoRouterState state) => UserRoute(
        state.pathParameters['userId']!,
      );

  String get location => GoRouteData.$location(
        '/users/${Uri.encodeComponent(userId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map json) => _$UserImpl(
      name: json['name'] as String,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usersRefHash() => r'8c6fc2c1918fbb72a79f9fd35ad188311fa559c1';

/// See also [usersRef].
@ProviderFor(usersRef)
final usersRefProvider =
    AutoDisposeProvider<CollectionReference<User>>.internal(
  usersRef,
  name: r'usersRefProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersRefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRefRef = AutoDisposeProviderRef<CollectionReference<User>>;
String _$usersHash() => r'd55458484505edf2804923f9744f22a7b1233afa';

/// See also [users].
@ProviderFor(users)
final usersProvider = AutoDisposeStreamProvider<List<Document<User>>>.internal(
  users,
  name: r'usersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsersRef = AutoDisposeStreamProviderRef<List<Document<User>>>;
String _$userFamilyHash() => r'be4c541f016984965a3647aca8509fb79e6fc007';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userFamily].
@ProviderFor(userFamily)
const userFamilyProvider = UserFamilyFamily();

/// See also [userFamily].
class UserFamilyFamily extends Family<AsyncValue<Document<User?>>> {
  /// See also [userFamily].
  const UserFamilyFamily();

  /// See also [userFamily].
  UserFamilyProvider call(
    String id,
  ) {
    return UserFamilyProvider(
      id,
    );
  }

  @override
  UserFamilyProvider getProviderOverride(
    covariant UserFamilyProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userFamilyProvider';
}

/// See also [userFamily].
class UserFamilyProvider extends AutoDisposeStreamProvider<Document<User?>> {
  /// See also [userFamily].
  UserFamilyProvider(
    String id,
  ) : this._internal(
          (ref) => userFamily(
            ref as UserFamilyRef,
            id,
          ),
          from: userFamilyProvider,
          name: r'userFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userFamilyHash,
          dependencies: UserFamilyFamily._dependencies,
          allTransitiveDependencies:
              UserFamilyFamily._allTransitiveDependencies,
          id: id,
        );

  UserFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Document<User?>> Function(UserFamilyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserFamilyProvider._internal(
        (ref) => create(ref as UserFamilyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Document<User?>> createElement() {
    return _UserFamilyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserFamilyProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserFamilyRef on AutoDisposeStreamProviderRef<Document<User?>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UserFamilyProviderElement
    extends AutoDisposeStreamProviderElement<Document<User?>>
    with UserFamilyRef {
  _UserFamilyProviderElement(super.provider);

  @override
  String get id => (origin as UserFamilyProvider).id;
}

String _$userIdScopedHash() => r'e5a7ad86e0c0452da08cf4c9b4b618430d871407';

/// See also [userIdScoped].
@ProviderFor(userIdScoped)
final userIdScopedProvider = AutoDisposeProvider<String>.internal(
  (_) => throw UnsupportedError(
    'The provider "userIdScopedProvider" is expected to get overridden/scoped, '
    'but was accessed without an override.',
  ),
  name: r'userIdScopedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userIdScopedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserIdScopedRef = AutoDisposeProviderRef<String>;
String _$routerHash() => r'a32adf7b20299c28242590f4a6554237b500e01b';

/// See also [router].
@ProviderFor(router)
final routerProvider = AutoDisposeProvider<Raw<GoRouter>>.internal(
  router,
  name: r'routerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouterRef = AutoDisposeProviderRef<Raw<GoRouter>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
