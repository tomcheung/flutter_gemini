import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_gen_ai/chat/camera.dart';
import 'package:flutter_google_gen_ai/chat/chat_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final TextEditingController _editingController = TextEditingController();
  XFile? imageFile;

  Widget _buildImagePreview() {
    if (imageFile case var imageFile?) {
      return Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
              height: 96,
              width: 96,
              child: Image.file(
                File(imageFile.path),
                fit: BoxFit.contain,
              )),
          IconButton(
            style: IconButton.styleFrom(backgroundColor: Colors.black38),
            color: Colors.white,
            iconSize: 16,
            padding: const EdgeInsets.all(4),
            onPressed: () {
              setState(() {
                this.imageFile = null;
              });
            },
            icon: const Icon(Icons.close),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildMessageList(BuildContext context) {
    final chat = ref.watch(chatNotifierProvider);
    final children =
        chat.contents.map((c) => _buildMessage(context, c)).toList();

    return ListView(children: children);
  }

  Widget _buildMessage(BuildContext context, Message message) {
    Widget content;
    final image = message.image;
    if (image != null) {
      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: message.fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100, child: Image.file(File(image.path))),
          Text(message.text ?? '')
        ],
      );
    } else {
      content = Text(message.text ?? '');
    }

    return Padding(
      padding: message.fromUser
          ? const EdgeInsets.only(left: 64.0)
          : const EdgeInsets.only(right: 64.0),
      child: Align(
        alignment: message.fromUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: content,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter Gemini Demo'),
        actions: [
          IconButton(
              onPressed: () {
                ref.watch(chatNotifierProvider.notifier).reset();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildMessageList(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildImagePreview(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _editingController,
                    maxLines: 10,
                    minLines: 1,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles(type: FileType.image);
                    final file = result?.files.firstOrNull?.xFile;
                    setState(() {
                      imageFile = file;
                    });
                  },
                  icon: const Icon(Icons.image),
                ),
                IconButton(
                  onPressed: () async {
                    final image = await Navigator.push(
                        context,
                        MaterialPageRoute<XFile>(
                            builder: (c) => const CameraView()));

                    if (!context.mounted) {
                      return;
                    }

                    setState(() {
                      imageFile = image;
                    });
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final message = _editingController.text;
                    final error = await ref
                        .read(chatNotifierProvider.notifier)
                        .sendMessage(message, image: imageFile);

                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Request fail: ${error.toString()}')));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
