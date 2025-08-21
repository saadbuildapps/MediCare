// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'ai_repo.dart';
// import 'chat_message.dart';

// class AIChatController extends ChangeNotifier {
//   final AIRepository _aiRepository;
//   final List<ChatMessage> _messages = [];
//   String _streamedText = '';
//   bool _isStreaming = false;
//   String _errorMessage = '';
//   final TextEditingController textController = TextEditingController();
//   final ScrollController scrollController = ScrollController();

//   AIChatController({AIRepository? aiRepository})
//       : _aiRepository = aiRepository ?? AIRepository() {
//     _aiRepository.initializeModel();
//   }

//   List<ChatMessage> get messages => _messages;
//   String get streamedText => _streamedText;
//   bool get isStreaming => _isStreaming;
//   String get errorMessage => _errorMessage;

//   void sendMessage(String userMessage) async {
//     try {
//       _messages.add(ChatMessage(content: userMessage, isUser: true));
//       _scrollToBottom();
//       _isStreaming = true;
//       _streamedText = '';
//       notifyListeners();

//       await for (final response in _aiRepository.generateTextStream(userMessage)) {
//         _streamedText = response.text;
//         _scrollToBottom();
//         notifyListeners();
//       }

//       if (_streamedText.isNotEmpty) {
//         _messages.add(ChatMessage(content: _streamedText, isUser: false));
//       }
//     } catch (e) {
//       _errorMessage = 'Error: $e';
//     } finally {
//       _isStreaming = false;
//       _streamedText = '';
//       _scrollToBottom();
//       notifyListeners();
//     }
//   }

//   Future<void> pickImage() async {
//     try {
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final response = await _aiRepository.analyzeImage(pickedFile.path, 'Describe this image');
//         _messages.add(ChatMessage(content: response.text, isUser: false));
//         _scrollToBottom();
//         notifyListeners();
//       }
//     } catch (e) {
//       _errorMessage = 'Error: $e';
//       notifyListeners();
//     }
//   }

//   void clearError() {
//     _errorMessage = '';
//     notifyListeners();
//   }

//   void _scrollToBottom() {
//     if (scrollController.hasClients) {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   void dispose() {
//     textController.dispose();
//     scrollController.dispose();
//     super.dispose();
//   }
// }

import 'package:image_picker/image_picker.dart';
import 'package:laza/Features/ai_bot_module/ai_repo.dart';
import 'package:laza/Features/ai_bot_module/chat_message.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:uuid/uuid.dart';

class AIChatController extends ChangeNotifier {
  final EnhancedAIRepository _aiRepository;
  final List<ChatMessage> _messages = []; // All chat messages
  String _streamedText = ''; // Current streaming text
  bool _isStreaming = false; // Is AI currently responding
  String _errorMessage = ''; // Error message to display
  String _currentChatId = ''; // Active chat session ID
  String _userId = ''; // Current user ID

  // UI Controllers
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  /// Initialize controller with AI repository
  AIChatController({EnhancedAIRepository? aiRepository})
      : _aiRepository = aiRepository ?? EnhancedAIRepository() {
    _initializeController();
  }

  // Getters for UI to access state
  List<ChatMessage> get messages => _messages;
  String get streamedText => _streamedText;
  bool get isStreaming => _isStreaming;
  String get errorMessage => _errorMessage;

  /// Initialize controller and create new chat session
  Future<void> _initializeController() async {
    await _aiRepository.initializeModel();
    _userId = const Uuid().v4();
    _currentChatId =
        await _aiRepository.createNewChat(_userId, 'Medical Consultation');
  }

  /// Send user message and get AI response
  /// Main method called when user sends a message
  Future<void> sendMessage(String userMessage) async {
    try {
      // Add user message to chat
      _messages.add(ChatMessage(content: userMessage, isUser: true));
      _scrollToBottom();

      // Start streaming response
      _isStreaming = true;
      _streamedText = '';
      _errorMessage = '';
      notifyListeners();

      // Get AI response stream
      await for (final response in _aiRepository.generateAdvancedTextStream(
          userMessage, _userId, _currentChatId)) {
        if (response.isError) {
          _errorMessage = response.text;
        } else {
          _streamedText += response.text;
        }
        _scrollToBottom();
        notifyListeners();
      }

      // Add complete AI response to messages
      if (_streamedText.isNotEmpty) {
        _messages.add(ChatMessage(content: _streamedText, isUser: false));
      }
    } catch (e) {
      _errorMessage = 'Connection error: $e';
    } finally {
      _isStreaming = false;
      _streamedText = '';
      _scrollToBottom();
      notifyListeners();
    }
  }

  /// Pick and analyze medical image
  Future<void> pickAndAnalyzeImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _isStreaming = true;
        notifyListeners();

        // Analyze medical image
        await for (final response in _aiRepository.generateAdvancedTextStream(
          'Please analyze this medical image and provide professional assessment.',
          _userId,
          _currentChatId,
          imagePath: pickedFile.path,
        )) {
          if (!response.isError) {
            _streamedText += response.text;
            notifyListeners();
          }
        }

        if (_streamedText.isNotEmpty) {
          _messages.add(ChatMessage(
            content: _streamedText,
            isUser: false,
            imagePath: pickedFile.path,
          ));
        }

        _isStreaming = false;
        _streamedText = '';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Image analysis failed: $e';
      _isStreaming = false;
      notifyListeners();
    }
  }

  /// Start new chat conversation
  Future<void> startNewChat() async {
    _messages.clear();
    _currentChatId =
        await _aiRepository.createNewChat(_userId, 'New Consultation');
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  /// Auto-scroll to bottom of chat
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    _aiRepository.dispose();
    super.dispose();
  }
}
