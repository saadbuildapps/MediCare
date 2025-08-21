// !# =============================================================================
//! # 4. API CLIENT - Network Communication Layer
//! # =============================================================================

//! api_client.dart

import 'package:dio/dio.dart';
import 'package:laza/Features/ai_bot_module/custom_exception.dart';

//! HTTP client wrapper for API communications 
//! Handles network requests with proper error handling
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    // Configure Dio with timeout and headers
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  /// GET request handler
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// POST request handler
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Convert Dio errors to custom exceptions
  CustomException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('⚠️ Connection timeout. Check your internet.');
      case DioExceptionType.badResponse:
        return ServerException('❌ Server error: ${error.response?.statusCode}');
      default:
        return NetworkException('🌐 Network error: ${error.message}');
    }
  }
}
