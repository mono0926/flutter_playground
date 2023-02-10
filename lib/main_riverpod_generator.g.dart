// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type

part of 'main_riverpod_generator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$_helloWorldHash() => r'a45c9ef071dcfe251a00c73da58374aed6345624';

/// See also [_helloWorld].
final _helloWorldProvider = AutoDisposeProvider<String>(
  _helloWorld,
  name: r'_helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$_helloWorldHash,
);
typedef _HelloWorldRef = AutoDisposeProviderRef<String>;
String _$_monoProviderHash() => r'ce687169279511a7fd843564a4f57a4f23b9fcf9';

/// See also [_monoProvider].
class _MonoProviderProvider extends AutoDisposeFutureProvider<String> {
  _MonoProviderProvider(
    this.arg,
  ) : super(
          (ref) => _monoProvider(
            ref,
            arg,
          ),
          from: _monoProviderProvider,
          name: r'_monoProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$_monoProviderHash,
        );

  final String arg;

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

typedef _MonoProviderRef = AutoDisposeFutureProviderRef<String>;

/// See also [_monoProvider].
final _monoProviderProvider = _MonoProviderFamily();

class _MonoProviderFamily extends Family<AsyncValue<String>> {
  _MonoProviderFamily();

  _MonoProviderProvider call(
    String arg,
  ) {
    return _MonoProviderProvider(
      arg,
    );
  }

  @override
  AutoDisposeFutureProvider<String> getProviderOverride(
    covariant _MonoProviderProvider provider,
  ) {
    return call(
      provider.arg,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'_monoProviderProvider';
}
