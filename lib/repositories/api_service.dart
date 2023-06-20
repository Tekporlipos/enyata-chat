import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/conversation.dart';
import '../models/message.dart';

class ApiService {
  static const String baseUrl = 'https://flutter-test-9vcb.onrender.com/api/v1';

  Future<List<Conversation>> fetchConversations() async {
    final response = await http.get(Uri.parse('$baseUrl/chat_room'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final List<dynamic> conversationData = jsonResponse['data'];

      final conversations = conversationData
          .map((data) => Conversation(
        id: data['id'],
        lastMessage: data['last_message'],
        members: List<String>.from(data['members']),
        topic: data['topic'],
        modifiedAt: data['modified_at'],
      ))
          .toList();

      return conversations;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  Future<List<Message>> fetchMessages(int chatId) async {
    final response = await http.get(Uri.parse('$baseUrl/chat_room/$chatId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final dynamic messageData = jsonResponse['data'];

      final message = Message(
        chatId: messageData['chat_id'],
        sender: messageData['sender'],
        message: messageData['message'],
        modifiedAt: messageData['modified_at'],
      );

      return [message];
    } else {
      throw Exception('Failed to fetch messages');
    }
  }

  Future<Conversation> fetchConversationById(int conversationId) async {
    final response = await http.get(Uri.parse('$baseUrl/chat_room/$conversationId'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final dynamic conversationData = jsonResponse['data'];

      final conversation = Conversation(
        id: conversationData['id'],
        lastMessage: conversationData['last_message'],
        members: List<String>.from(conversationData['members']),
        topic: conversationData['topic'],
        modifiedAt: conversationData['modified_at'],
      );

      return conversation;
    } else {
      throw Exception('Failed to fetch conversation');
    }
  }

  static Future<Message> postMessage(int conversationId, String text) async {
    // Simulating a delayed response
    await Future.delayed(const Duration(seconds: 2));
    // Creating a Message object with the specified properties
    Message message = Message(chatId: 1,
        sender: 'Joe',
        message: text,
        modifiedAt: 1);
    // Returning the created message
    return message;
  }
}
