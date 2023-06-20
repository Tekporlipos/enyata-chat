class Conversation {
  final int id;
  final String lastMessage;
  final List<String> members;
  final String? topic;
  final int modifiedAt;

  Conversation({
    required this.id,
    required this.lastMessage,
    required this.members,
    this.topic,
    required this.modifiedAt,
  });
}
