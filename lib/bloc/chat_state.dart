

import '../models/conversation.dart';
import '../models/message.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoadingState extends ChatState {}

class ConversationsLoadedState extends ChatState {
  final List<Conversation> conversations;

  ConversationsLoadedState({required this.conversations});
}

class MessagesLoadingState extends ChatState {}

class MessagesLoadedState extends ChatState {
  final List<Message> messages;

  MessagesLoadedState({required this.messages});
}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState({required this.error});
}
