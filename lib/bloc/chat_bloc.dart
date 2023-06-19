import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/api_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadConversationsEvent) {
      yield ChatLoadingState();
      try {
        final conversations = await ApiService.fetchConversations();
        yield ConversationsLoadedState(conversations);
      } catch (error) {
        yield ChatErrorState('Failed to load conversations');
      }
    } else if (event is LoadMessagesEvent) {
      yield ChatLoadingState();
      try {
        final messages = await ApiService.fetchMessages(event.conversationId);
        yield MessagesLoadedState(messages);
      } catch (error) {
        yield ChatErrorState('Failed to load messages');
      }
    } else if (event is PostMessageEvent) {
      try {
        final responseMessage = await ApiService.postMessage(event.conversationId, event.text);
        yield MessagesLoadedState([responseMessage]);
      } catch (error) {
        yield ChatErrorState('Failed to post message');
      }
    }
  }
}
