class Message {
  final int chatId;
  final String sender;
  final String message;
  final int modifiedAt;

  Message({
    required this.chatId,
    required this.sender,
    required this.message,
    required this.modifiedAt,
  });
}
