
//! chat_message.dart
//! Individual chat message model
//! Represents user and AI messages in conversation
class ChatMessage {
  final String id; // Unique message identifier
  final String content; // Message text content
  final bool isUser; // True if user message, false if AI
  final DateTime timestamp; // When message was sent
  final String? imagePath; // Optional image attachment path

  ChatMessage({
    required this.content,
    required this.isUser,
    String? id,
    DateTime? timestamp,
    this.imagePath,
  })  : id = id ?? _generateId(),
        timestamp = timestamp ?? DateTime.now();

  static String _generateId() =>
      DateTime.now().millisecondsSinceEpoch.toString();
}