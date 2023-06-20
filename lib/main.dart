import 'package:enyata_chat/repositories/api_service.dart';
import 'package:enyata_chat/screens/home_page.dart';
import 'package:enyata_chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/chat_bloc.dart';
import 'bloc/chat_state.dart';
import 'screens/details_page.dart';
import 'models/conversation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      home: BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(apiService: ApiService()),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return SplashScreen();
          },
        ),
      ),
      routes: {
        '/home': (context) => BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(apiService: ApiService()),
          child: Builder(
            builder: (BuildContext context) {
             return const HomePage();
            },
          ),
        ),
        '/details': (context) => BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(apiService: ApiService()),
          child: Builder(
            builder: (BuildContext context) {
              final Conversation conversation = ModalRoute.of(context)!.settings.arguments as Conversation;
              return DetailsPage(conversation: conversation);
            },
          ),
        ),
      },
    );
  }
}

