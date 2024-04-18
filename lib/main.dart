import 'package:flutter/material.dart';
import 'package:flutter_google_gen_ai/chat/chat.dart';
import 'package:flutter_google_gen_ai/mini_quiz_game/mini_quiz_game.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProviderScope(child: AppRoot()),
    );
  }
}

enum Section { chat, quiz }

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: Section.values
            .map((s) => ListTile(
                  title: Text(s.name),
                  onTap: () {
                    context.dispatchNotification(DrawerNotification(s));
                    Navigator.pop(context);
                  },
                ))
            .toList(),
      ),
    );
  }
}

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  Section selectedSection = Section.chat;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DrawerNotification>(
      child: buildContent(context),
      onNotification: (notification) {
        setState(() {
          selectedSection = notification.selectedSection;
        });
        return true;
      },
    );
  }

  Widget buildContent(BuildContext context) {
    return switch (selectedSection) {
      Section.chat => const ChatView(),
      Section.quiz => const MiniQuizGame(),
    };
  }
}

class DrawerNotification extends Notification {
  final Section selectedSection;

  DrawerNotification(this.selectedSection);
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
