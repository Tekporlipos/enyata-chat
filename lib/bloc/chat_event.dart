import '../models/message.dart';

abstract class ChatEvent {}

class LoadConversationsEvent extends ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  final int chatId;

  LoadMessagesEvent(this.chatId);

  @override
  List<Object> get props => [chatId];
}

class PostMessageEvent extends ChatEvent {
  final Message message;

  PostMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
