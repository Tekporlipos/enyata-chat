import 'package:equatable/equatable.dart';
import '../models/conversation.dart';
import '../models/message.dart';


abstract class ChatState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatErrorState extends ChatState {
  final String error;

  ChatErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class ConversationsLoadedState extends ChatState {
  final List<Conversation> conversations;

  ConversationsLoadedState(this.conversations);

  @override
  List<Object?> get props => [conversations];
}

class MessagesLoadedState extends ChatState {
  final List<Message> messages;

  MessagesLoadedState(this.messages);

  @override
  List<Object?> get props => [messages];
}
