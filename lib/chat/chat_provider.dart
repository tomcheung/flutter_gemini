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
    /** TODO: Complete this function
     * 1. Read the existing state
     * 2. Check it contain image, switch to 'gemini-pro-vision'
     * 3. Sent content: TextPart, DataPart('image/jpeg') for image to gemini
     * 4. Update the state
     */
    return Future.value(null);
  }
}
