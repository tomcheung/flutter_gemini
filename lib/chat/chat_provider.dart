import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_google_gen_ai/core/gemini_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:developer' as d;

part 'chat_provider.g.dart';

class Message {
  final String? text;
  final XFile? image;
  bool fromUser;

  Message({this.text, this.image, required this.fromUser});
}

class ChatState {
  final bool haveImage;
  ChatSession session;
  List<Message> contents;

  ChatState({
    required this.session,
    required this.contents,
    this.haveImage = false,
  });
}

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build() {
    final model = ref.read(getGeminiModelProvider('gemini-pro'));
    return ChatState(
        session: model.startChat(), contents: [], haveImage: false);
  }

  void reset() {
    state = build();
  }

  Future<Exception?> sendMessage(String message, {XFile? image}) async {
    final newContent = List.of(state.contents);
    newContent.add(Message(fromUser: true, text: message, image: image));

    final switchToVision = image != null && !state.haveImage;

    if (switchToVision) {
      final model = ref.read(getGeminiModelProvider('gemini-pro-vision'));
      final history = state.session.history.toList();
      state = ChatState(
          session: model.startChat(history: history), contents: newContent);
    } else {
      state = ChatState(session: state.session, contents: newContent);
    }

    Content prompt;
    if (image != null) {
      final path = File(image.path);
      final bytes = await path.readAsBytes();
      // available data part
      // https://ai.google.dev/api/rest/v1/Content?_gl=1*17y64re*_up*MQ..*_ga*NjYzNTQyMjYxLjE3MTE4MTU2MDQ.*_ga_P1DBVKWT6V*MTcxMTgxNTYwNC4xLjAuMTcxMTgxNzM0NS4wLjAuMA..#part
      prompt =
          Content.multi([TextPart(message), DataPart('image/jpeg', bytes)]);
    } else {
      prompt = Content.text(message);
    }

    try {
      final response = await state.session.sendMessage(prompt);
      newContent.add(Message(fromUser: false, text: response.text));

      state = ChatState(session: state.session, contents: newContent);
      return null;
    } on GenerativeAIException catch (ex) {
      d.log(ex.toString(), error: ex);
      return ex;
    }
  }
}
