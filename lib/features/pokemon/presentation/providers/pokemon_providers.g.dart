// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioClientHash() => r'9443fc07422441f6ebb921ab62a65d61ffedc98b';

/// See also [dioClient].
@ProviderFor(dioClient)
final dioClientProvider = AutoDisposeProvider<DioClient>.internal(
  dioClient,
  name: r'dioClientProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dioClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioClientRef = AutoDisposeProviderRef<DioClient>;
String _$pokemonRemoteDataSourceHash() =>
    r'65ad4ea6764f6c09fe6398a2def1ea196a8f360e';

/// See also [pokemonRemoteDataSource].
@ProviderFor(pokemonRemoteDataSource)
final pokemonRemoteDataSourceProvider =
    AutoDisposeProvider<PokemonRemoteDataSource>.internal(
      pokemonRemoteDataSource,
      name: r'pokemonRemoteDataSourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pokemonRemoteDataSourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PokemonRemoteDataSourceRef =
    AutoDisposeProviderRef<PokemonRemoteDataSource>;
String _$pokemonRepositoryHash() => r'665939f158473f17b2abd6bdc91178191a532811';

/// See also [pokemonRepository].
@ProviderFor(pokemonRepository)
final pokemonRepositoryProvider =
    AutoDisposeProvider<PokemonRepository>.internal(
      pokemonRepository,
      name: r'pokemonRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pokemonRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PokemonRepositoryRef = AutoDisposeProviderRef<PokemonRepository>;
String _$getPokemonListHash() => r'087ab637289f0b0d7e44752a92c2f98c02804ebc';

/// See also [getPokemonList].
@ProviderFor(getPokemonList)
final getPokemonListProvider = AutoDisposeProvider<GetPokemonList>.internal(
  getPokemonList,
  name: r'getPokemonListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPokemonListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPokemonListRef = AutoDisposeProviderRef<GetPokemonList>;
String _$pokemonListHash() => r'f5f31c31de6ddf45f2eae3ecbfbca695ebfd3118';

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

/// See also [pokemonList].
@ProviderFor(pokemonList)
const pokemonListProvider = PokemonListFamily();

/// See also [pokemonList].
class PokemonListFamily extends Family<AsyncValue<List<Pokemon>>> {
  /// See also [pokemonList].
  const PokemonListFamily();

  /// See also [pokemonList].
  PokemonListProvider call({int limit = 20, int offset = 0}) {
    return PokemonListProvider(limit: limit, offset: offset);
  }

  @override
  PokemonListProvider getProviderOverride(
    covariant PokemonListProvider provider,
  ) {
    return call(limit: provider.limit, offset: provider.offset);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pokemonListProvider';
}

/// See also [pokemonList].
class PokemonListProvider extends AutoDisposeFutureProvider<List<Pokemon>> {
  /// See also [pokemonList].
  PokemonListProvider({int limit = 20, int offset = 0})
    : this._internal(
        (ref) =>
            pokemonList(ref as PokemonListRef, limit: limit, offset: offset),
        from: pokemonListProvider,
        name: r'pokemonListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$pokemonListHash,
        dependencies: PokemonListFamily._dependencies,
        allTransitiveDependencies: PokemonListFamily._allTransitiveDependencies,
        limit: limit,
        offset: offset,
      );

  PokemonListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final int limit;
  final int offset;

  @override
  Override overrideWith(
    FutureOr<List<Pokemon>> Function(PokemonListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PokemonListProvider._internal(
        (ref) => create(ref as PokemonListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Pokemon>> createElement() {
    return _PokemonListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonListProvider &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PokemonListRef on AutoDisposeFutureProviderRef<List<Pokemon>> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _PokemonListProviderElement
    extends AutoDisposeFutureProviderElement<List<Pokemon>>
    with PokemonListRef {
  _PokemonListProviderElement(super.provider);

  @override
  int get limit => (origin as PokemonListProvider).limit;
  @override
  int get offset => (origin as PokemonListProvider).offset;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
