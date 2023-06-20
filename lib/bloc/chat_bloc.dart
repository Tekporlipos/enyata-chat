

import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/api_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService;

  ChatBloc({required this.apiService}) : super(ChatInitial());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is LoadConversationsEvent) {
      yield* _mapLoadConversationsEventToState();
    } else if (event is LoadMessagesEvent) {
      yield* _mapLoadMessagesEventToState(event.chatId);
    }
  }

  Stream<ChatState> _mapLoadConversationsEventToState() async* {
    yield ChatLoadingState();

    try {
      final conversations = await apiService.fetchConversations();
      yield ConversationsLoadedState(conversations: conversations);
    } catch (error) {
      yield ChatErrorState(error: error.toString());
    }
  }

  Stream<ChatState> _mapLoadMessagesEventToState(int chatId) async* {
    yield MessagesLoadingState();

    try {
      final messages = await apiService.fetchMessages(chatId);
      yield MessagesLoadedState(messages: messages);
    } catch (error) {
      yield ChatErrorState(error: error.toString());
    }
  }
}
