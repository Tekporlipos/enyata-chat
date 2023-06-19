import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/conversation.dart';

class DetailsPage extends StatefulWidget {
  final Conversation conversation;

  DetailsPage({required this.conversation});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(LoadMessagesEvent(widget.conversation.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conversation.title)),
      body: Column(
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoadingState) {
                return const Expanded(child: Center(child: CircularProgressIndicator()));
              } else if (state is ChatErrorState) {
                return Expanded(child: Center(child: Text('Error: ${state.error}')));
              } else if (state is MessagesLoadedState) {
                final messages = state.messages;
                return Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.text),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = textController.text.trim();
                    if (text.isNotEmpty) {
                      BlocProvider.of<ChatBloc>(context).add(PostMessageEvent(widget.conversation.id, text));
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
