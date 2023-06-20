import 'package:enyata_chat/components/receiver_card.dart';
import 'package:enyata_chat/components/sender_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../utils/formaters.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.video_call_outlined,size: 32,),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0,right: 16),
            child: Icon(Icons.call,size: 32,),
          )
        ],
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        title: ListTile(
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
          title: Text(widget.conversation.topic ?? 'No Topic'),
          subtitle: Text(Converter.formatTimestampToTimeAgo(widget.conversation.modifiedAt),),
        ),),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is MessagesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MessagesLoadedState) {
            messages = state.messages.cast<Message>(); // Explicitly cast the messages
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  if(messages[index].sender == "User"){
                    return SenderCard(message: messages[index]);
                  }else{
                    return ReceiverCard(message: messages[index]);
                  }
                },
              ),
            );
          } else if (state is ChatErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[50]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Search message...',
                        border: InputBorder.none,
                      ),
                      maxLines: 4, // Allow multiple lines
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                    onTap: ()=>{
                 if(textController.text.isNotEmpty){
                   setState(() {
                     messages.add(Message(
                       chatId: widget.conversation.id,
                       sender: 'User',
                       message: textController.text,
                       modifiedAt: DateTime.now().millisecondsSinceEpoch,
                     ));
                   }),
                   textController.clear(),
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
                   }),
                }

   },
  child: const Icon(Icons.send,color:  Colors.deepPurple,)),
],
            ),
          ),
        ),
      ),
    );
  }
}
