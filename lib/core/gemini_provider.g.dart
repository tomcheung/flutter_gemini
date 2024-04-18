// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getGeminiModelHash() => r'09232f66a519b273704269fea882d6ad7d39c230';

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

/// See also [getGeminiModel].
@ProviderFor(getGeminiModel)
const getGeminiModelProvider = GetGeminiModelFamily();

/// See also [getGeminiModel].
class GetGeminiModelFamily extends Family<GenerativeModel> {
  /// See also [getGeminiModel].
  const GetGeminiModelFamily();

  /// See also [getGeminiModel].
  GetGeminiModelProvider call(
    String model,
  ) {
    return GetGeminiModelProvider(
      model,
    );
  }

  @override
  GetGeminiModelProvider getProviderOverride(
    covariant GetGeminiModelProvider provider,
  ) {
    return call(
      provider.model,
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
  String? get name => r'getGeminiModelProvider';
}

/// See also [getGeminiModel].
class GetGeminiModelProvider extends Provider<GenerativeModel> {
  /// See also [getGeminiModel].
  GetGeminiModelProvider(
    String model,
  ) : this._internal(
          (ref) => getGeminiModel(
            ref as GetGeminiModelRef,
            model,
          ),
          from: getGeminiModelProvider,
          name: r'getGeminiModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getGeminiModelHash,
          dependencies: GetGeminiModelFamily._dependencies,
          allTransitiveDependencies:
              GetGeminiModelFamily._allTransitiveDependencies,
          model: model,
        );

  GetGeminiModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
  }) : super.internal();

  final String model;

  @override
  Override overrideWith(
    GenerativeModel Function(GetGeminiModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetGeminiModelProvider._internal(
        (ref) => create(ref as GetGeminiModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
      ),
    );
  }

  @override
  ProviderElement<GenerativeModel> createElement() {
    return _GetGeminiModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGeminiModelProvider && other.model == model;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetGeminiModelRef on ProviderRef<GenerativeModel> {
  /// The parameter `model` of this provider.
  String get model;
}

class _GetGeminiModelProviderElement extends ProviderElement<GenerativeModel>
    with GetGeminiModelRef {
  _GetGeminiModelProviderElement(super.provider);

  @override
  String get model => (origin as GetGeminiModelProvider).model;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
