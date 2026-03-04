enum MessageRole { user, ai }

class ChatMessage {
  final String text;
  final MessageRole role;
  final DateTime time;
  final bool isLoading;

  const ChatMessage({
    required this.text,
    required this.role,
    required this.time,
    this.isLoading = false,
  });
}