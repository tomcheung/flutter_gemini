// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_price_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPriceQueryHash() => r'055a882d168fa5ce429353929002399850863a9c';

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

/// See also [getPriceQuery].
@ProviderFor(getPriceQuery)
const getPriceQueryProvider = GetPriceQueryFamily();

/// See also [getPriceQuery].
class GetPriceQueryFamily extends Family<AsyncValue<String>> {
  /// See also [getPriceQuery].
  const GetPriceQueryFamily();

  /// See also [getPriceQuery].
  GetPriceQueryProvider call(
    String question,
  ) {
    return GetPriceQueryProvider(
      question,
    );
  }

  @override
  GetPriceQueryProvider getProviderOverride(
    covariant GetPriceQueryProvider provider,
  ) {
    return call(
      provider.question,
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
  String? get name => r'getPriceQueryProvider';
}

/// See also [getPriceQuery].
class GetPriceQueryProvider extends AutoDisposeFutureProvider<String> {
  /// See also [getPriceQuery].
  GetPriceQueryProvider(
    String question,
  ) : this._internal(
          (ref) => getPriceQuery(
            ref as GetPriceQueryRef,
            question,
          ),
          from: getPriceQueryProvider,
          name: r'getPriceQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPriceQueryHash,
          dependencies: GetPriceQueryFamily._dependencies,
          allTransitiveDependencies:
              GetPriceQueryFamily._allTransitiveDependencies,
          question: question,
        );

  GetPriceQueryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.question,
  }) : super.internal();

  final String question;

  @override
  Override overrideWith(
    FutureOr<String> Function(GetPriceQueryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPriceQueryProvider._internal(
        (ref) => create(ref as GetPriceQueryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        question: question,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _GetPriceQueryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPriceQueryProvider && other.question == question;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, question.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPriceQueryRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `question` of this provider.
  String get question;
}

class _GetPriceQueryProviderElement
    extends AutoDisposeFutureProviderElement<String> with GetPriceQueryRef {
  _GetPriceQueryProviderElement(super.provider);

  @override
  String get question => (origin as GetPriceQueryProvider).question;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
