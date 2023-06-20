import 'package:enyata_chat/utils/formaters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load conversations
    BlocProvider.of<ChatBloc>(context).add(LoadConversationsEvent());
  }

  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                height: 45,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: 'Search message...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Handle search query changes
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white,
                  ),
                  height: 45,
                  child: const Icon(Icons.edit_location_alt_outlined, color: Colors.black54),
                ),
              ),
            )
          ],
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ConversationsLoadedState) {
            final conversations = state.conversations;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return Container(
                  padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Card(
                    margin: const EdgeInsets.all(4),
                    child: SizedBox(
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: const BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.all(Radius.circular(35)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80"),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 40,
                              child: Container(
                                width: 10,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                                height: 10,
                              ),
                            ),
                          ],
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(conversation.topic ?? 'No Topic'),
                            Text(
                              Converter.formatTimestampToTimeAgo(conversation.modifiedAt),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        subtitle: Text(conversation.lastMessage),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: conversation,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ChatErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }
}
