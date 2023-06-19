import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadConversationsEvent extends ChatEvent {}

class LoadMessagesEvent extends ChatEvent {
  final int conversationId;

  LoadMessagesEvent(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class PostMessageEvent extends ChatEvent {
  final int conversationId;
  final String text;

  PostMessageEvent(this.conversationId, this.text);

  @override
  List<Object?> get props => [conversationId, text];
}
