import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_gen_ai/mini_quiz_game/mini_quiz_game_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class MiniQuizGame extends ConsumerStatefulWidget {
  const MiniQuizGame({super.key});

  @override
  ConsumerState<MiniQuizGame> createState() => _MiniQuizGameState();
}

class _MiniQuizGameState extends ConsumerState<MiniQuizGame> {
  @override
  void initState() {
    ref.read(quizNotifierProvider.notifier).startQuiz();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizNotifierProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: const Text('Gemini mini quiz')),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () {
          ref.read(quizNotifierProvider.notifier).startQuiz();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: switch (quizState) {
          QuizLoadingState() => buildLoading(context),
          QuizInProgressState inProgressState =>
            buildQuestion(context, inProgressState),
          QuizFinishState finishResult => buildResult(context, finishResult),
        },
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildQuestion(BuildContext context, QuizInProgressState state) {
    final style = Theme.of(context).textTheme;

    final options = state.currentQuestion.options
        .map((o) => Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                )),
                onPressed: () {
                  ref.read(quizNotifierProvider.notifier).answerQuestion(o);
                },
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 100, minHeight: 80),
                  child: Center(child: Text(o)),
                ),
              ),
            ))
        .toList();

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.currentQuestion.question,
            style: style.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((e) => Padding(padding: EdgeInsets.symmetric(vertical: 8), child: e,)).toList(),
          )
        ],
      ),
    );
  }

  Widget buildResult(BuildContext context, QuizFinishState state) {
    final style = Theme.of(context).textTheme;

    final summary = state.getSummary().map((e) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Question: ${e.$1.question}'),
                Text('Correct answer: ${e.$1.answer}'),
                Text('Your answer: ${e.$2}  ${e.$3 ? '✅' : '❌'}'),
              ],
            ),
          ),
        ));

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Result', style: style.headlineMedium),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: summary.toList(),
            ),
          )
        ],
      ),
    );
  }
}
