class SupportChatMessage {
  final String text;
  final bool isUser;
  final DateTime createdAt;

  const SupportChatMessage({
    required this.text,
    required this.isUser,
    required this.createdAt,
  });
}
