import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/conversation.dart';
import '../models/message.dart';

class DetailsPage extends StatefulWidget {
  final Conversation conversation;

  const DetailsPage({Key? key, required this.conversation}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController textController = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(LoadMessagesEvent(widget.conversation.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conversation.topic ?? 'No Topic')),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is MessagesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesLoadedState) {
            messages = state.messages.cast<Message>(); // Explicitly cast the messages
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message.sender),
                  subtitle: Text(message.message),
                );
              },
            );
          } else if (state is ChatErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Type a message...'),
              ),
            ),
            const SizedBox(width: 8.0),
            ElevatedButton(
              onPressed: () {
                final newMessage = Message(
                  chatId: widget.conversation.id,
                  sender: 'User',
                  message: textController.text,
                  modifiedAt: DateTime.now().millisecondsSinceEpoch,
                );
                setState(() {
                  messages.add(newMessage);
                });
                textController.clear();
                // Simulate receiving an answer after a short delay
                Future.delayed(const Duration(seconds: 2), () {
                  final answerMessage = Message(
                    chatId: widget.conversation.id,
                    sender: 'Bot',
                    message: 'Received your message!',
                    modifiedAt: DateTime.now().millisecondsSinceEpoch,
                  );
                  setState(() {
                    messages.add(answerMessage);
                  });
                });
              },
              // ignore: prefer_const_constructors
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
