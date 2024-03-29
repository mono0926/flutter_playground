// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'main_riverpod_generator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helloWorldHash() => r'a45c9ef071dcfe251a00c73da58374aed6345624';

/// See also [_helloWorld].
@ProviderFor(_helloWorld)
final _helloWorldProvider = AutoDisposeProvider<String>.internal(
  _helloWorld,
  name: r'_helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helloWorldHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _HelloWorldRef = AutoDisposeProviderRef<String>;
String _$monoProviderHash() => r'8c286691ce8a8b966b648b129835e7492f6738e9';

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

/// See also [_monoProvider].
@ProviderFor(_monoProvider)
const _monoProviderProvider = _MonoProviderFamily();

/// See also [_monoProvider].
class _MonoProviderFamily extends Family<AsyncValue<String>> {
  /// See also [_monoProvider].
  const _MonoProviderFamily();

  /// See also [_monoProvider].
  _MonoProviderProvider call(
    String arg,
  ) {
    return _MonoProviderProvider(
      arg,
    );
  }

  @override
  _MonoProviderProvider getProviderOverride(
    covariant _MonoProviderProvider provider,
  ) {
    return call(
      provider.arg,
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
  String? get name => r'_monoProviderProvider';
}

/// See also [_monoProvider].
class _MonoProviderProvider extends AutoDisposeFutureProvider<String> {
  /// See also [_monoProvider].
  _MonoProviderProvider(
    String arg,
  ) : this._internal(
          (ref) => _monoProvider(
            ref as _MonoProviderRef,
            arg,
          ),
          from: _monoProviderProvider,
          name: r'_monoProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monoProviderHash,
          dependencies: _MonoProviderFamily._dependencies,
          allTransitiveDependencies:
              _MonoProviderFamily._allTransitiveDependencies,
          arg: arg,
        );

  _MonoProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final String arg;

  @override
  Override overrideWith(
    FutureOr<String> Function(_MonoProviderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _MonoProviderProvider._internal(
        (ref) => create(ref as _MonoProviderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _MonoProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _MonoProviderProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _MonoProviderRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `arg` of this provider.
  String get arg;
}

class _MonoProviderProviderElement
    extends AutoDisposeFutureProviderElement<String> with _MonoProviderRef {
  _MonoProviderProviderElement(super.provider);

  @override
  String get arg => (origin as _MonoProviderProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
