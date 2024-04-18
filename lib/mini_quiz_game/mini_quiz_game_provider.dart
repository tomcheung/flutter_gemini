import 'dart:convert';
import 'dart:developer' as d;

import 'package:flutter_google_gen_ai/core/gemini_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mini_quiz_game_provider.g.dart';

const _promptBody =
"""
Create a english exam questions with 5 questions in multiple choice format, each question have four options and there should be only have 1 correct answer.
Response in json array annotate with code block, 
it should contain 3 attributes `question`, `options` and `answer`,
the `answer` should be one of the value inside `options` array, please do not start with keyword `json`
""";

const _promptBody2 =
"""
Create english class exam questions with the following specifications:

Number of questions: 5
Format: Multiple choice
Options per question: 4
Correct answers: 1 per question
Difficulty: High school student who are preparing IELTS exam.
Output format: JSON array code block, each question object should contain:
    `question`: The question text
    `options`: An array of 4 possible answer choices 
    `answer`: The correct answer from the "options" array, in string
    
Do not start with keyword `json`
""";


class Question {
  int id;
  List<String> options;
  String question;
  String answer;

  Question({required this.id, required this.question, required this.answer, required this.options});

  factory Question.fromJson(int id, Map<String, dynamic> json) {
    final options = (json['options'] as List<dynamic>).cast<String>();
    return Question(id: id, question: json['question'], answer: json['answer'], options: options);
  }
}

@Riverpod(keepAlive: true)
Future<List<Question>> getQuizQuestions(GetQuizQuestionsRef ref) async {
  final model = ref.read(getGeminiModelProvider('gemini-1.0-pro'));

  final prompt = [Content.text(_promptBody2)];
  final response = await model.generateContent(prompt);
  final responseText = response.text?.replaceAll('```', '');
  if (responseText == null) {
    return [];
  }

  d.log(responseText);

  List<dynamic> json = jsonDecode(responseText);
  return json.indexed.map((e) => Question.fromJson(e.$1, e.$2)).toList();
}

sealed class QuizState {}

class QuizLoadingState extends QuizState {}

class QuizInProgressState extends QuizState {
  final List<String> answers;
  final Question currentQuestion;
  QuizInProgressState({required this.currentQuestion, required this.answers});
}

class QuizFinishState extends QuizState {
  final List<String> answers;
  final List<Question> questions;
  QuizFinishState({required this.answers, required this.questions});

  List<(Question, String, bool)> getSummary() {
    return questions.indexed.map((e) => (e.$2, answers[e.$1], answers[e.$1] == e.$2.answer)).toList();
  }
}


@Riverpod(keepAlive: true)
class QuizNotifier extends _$QuizNotifier {
  @override
  QuizState build() {
    return QuizLoadingState();
  }

  void startQuiz() async {
    ref.invalidate(getQuizQuestionsProvider);
    final questions = await ref.watch(getQuizQuestionsProvider.future);
    state = QuizInProgressState(currentQuestion: questions.first, answers: []);
  }

  void answerQuestion(String answer) {
    final answerState = state as QuizInProgressState;
    final newAnswer = List.of(answerState.answers);

    if (!answerState.currentQuestion.options.contains(answer)) {
      d.log('answer did not found in options');
    }
    newAnswer.add(answer);

    final questions = ref.read(getQuizQuestionsProvider).value ?? [];
    final index = questions.indexOf(answerState.currentQuestion);

    if (index + 1 < questions.length) {
      state = QuizInProgressState(currentQuestion: questions[index + 1], answers: newAnswer);
    } else {
      state = QuizFinishState(answers: newAnswer, questions: questions);
    }
  }
}