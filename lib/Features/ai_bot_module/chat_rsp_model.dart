




//! # =============================================================================
//! # 3. DATA MODELS - Message and Response Models
//! # =============================================================================

//! chat_rsp_model.dart
//! Response model from AI API calls
//! Contains AI response text and metadata
class ChatResponse {
  final String text; // AI generated response text
  final bool isError; // Whether response is an error
  final Map<String, dynamic>? metadata; // Additional response data

  ChatResponse({
    required this.text,
    this.isError = false,
    this.metadata,
  });
}
