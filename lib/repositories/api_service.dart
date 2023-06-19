import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/conversation.dart';
import '../models/message.dart';

class ApiService {
  static const baseUrl = 'https://flutter-test-9vcb.onrender.com/api/v1';

  static Future<List<Conversation>> fetchConversations() async {
    final response = await http.get(Uri.parse('$baseUrl/chat_room'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Conversation>.from(jsonData.map((c) => Conversation(id: c['id'], title: c['title'])));
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  static Future<List<Message>> fetchMessages(int conversationId) async {
    final response = await http.get(Uri.parse('$baseUrl/chat_room/$conversationId'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Message>.from(jsonData.map((m) => Message(id: m['id'], conversationId: m['conversationId'], text: m['text'])));
    } else {
      throw Exception('Failed to load messages');
    }
  }

  static Future<Message> postMessage(int conversationId, String text) async {
    // Simulating a delayed response
    await Future.delayed(Duration(seconds: 2));

    // Returning a dummy response message
    return Message(id: 100, conversationId: conversationId, text: 'This is a response message');
  }
}
