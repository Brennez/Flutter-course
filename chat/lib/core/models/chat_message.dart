class ChatMessage {
  String id;
  String text;
  DateTime createdAt;

  String userId;
  String userName;
  String userImageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });
}
