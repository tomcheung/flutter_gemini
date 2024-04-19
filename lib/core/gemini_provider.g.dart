// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getGeminiModelHash() => r'7643cb26dbcbfc54408b0711263ac87126c353b3';

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
    String model, {
    List<Tool>? tools,
  }) {
    return GetGeminiModelProvider(
      model,
      tools: tools,
    );
  }

  @override
  GetGeminiModelProvider getProviderOverride(
    covariant GetGeminiModelProvider provider,
  ) {
    return call(
      provider.model,
      tools: provider.tools,
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
    String model, {
    List<Tool>? tools,
  }) : this._internal(
          (ref) => getGeminiModel(
            ref as GetGeminiModelRef,
            model,
            tools: tools,
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
          tools: tools,
        );

  GetGeminiModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
    required this.tools,
  }) : super.internal();

  final String model;
  final List<Tool>? tools;

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
        tools: tools,
      ),
    );
  }

  @override
  ProviderElement<GenerativeModel> createElement() {
    return _GetGeminiModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetGeminiModelProvider &&
        other.model == model &&
        other.tools == tools;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);
    hash = _SystemHash.combine(hash, tools.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetGeminiModelRef on ProviderRef<GenerativeModel> {
  /// The parameter `model` of this provider.
  String get model;

  /// The parameter `tools` of this provider.
  List<Tool>? get tools;
}

class _GetGeminiModelProviderElement extends ProviderElement<GenerativeModel>
    with GetGeminiModelRef {
  _GetGeminiModelProviderElement(super.provider);

  @override
  String get model => (origin as GetGeminiModelProvider).model;
  @override
  List<Tool>? get tools => (origin as GetGeminiModelProvider).tools;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
