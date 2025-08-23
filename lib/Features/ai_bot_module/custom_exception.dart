
// # =============================================================================
// # 2. EXCEPTION HANDLING - Error Management System
// # =============================================================================

// custom_exception.dart
/// Custom exception classes for better error handling
/// Used across the app for consistent error management
abstract class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => message;
}

/// Network-related errors (connection timeout, no internet)
class NetworkException extends CustomException {
  NetworkException(super.message);
}

/// Server-related errors (API errors, server down)
class ServerException extends CustomException {
  ServerException(super.message);
}

/// Medical AI specific errors (rate limit, model errors)
class AIException extends CustomException {
  AIException(super.message);
}