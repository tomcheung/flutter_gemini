// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_quiz_game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getQuizQuestionsHash() => r'db7e5008182c5350f28e71cfec82ed0597653c88';

/// See also [getQuizQuestions].
@ProviderFor(getQuizQuestions)
final getQuizQuestionsProvider = FutureProvider<List<Question>>.internal(
  getQuizQuestions,
  name: r'getQuizQuestionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getQuizQuestionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetQuizQuestionsRef = FutureProviderRef<List<Question>>;
String _$quizNotifierHash() => r'9a4a38a61bf6e48e3234b8416095b1646f6a6a4d';

/// See also [QuizNotifier].
@ProviderFor(QuizNotifier)
final quizNotifierProvider = NotifierProvider<QuizNotifier, QuizState>.internal(
  QuizNotifier.new,
  name: r'quizNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$quizNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$QuizNotifier = Notifier<QuizState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
