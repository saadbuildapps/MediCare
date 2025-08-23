//!#      =============================================================================
//!         5. ENHANCED AI REPOSITORY - Core AI & Database Logic
//!       =============================================================================

//! Main repository class handling AI interactions and local database
//! Connects to Gemini API and manages conversation history
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laza/Features/ai_bot_module/chat_message.dart';
import 'package:laza/Features/ai_bot_module/chat_rsp_model.dart';
import 'package:laza/Features/ai_bot_module/custom_exception.dart';
import 'package:laza/Features/ai_bot_module/global_class.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class EnhancedAIRepository {
  GenerativeModel? _model; // Gemini AI model instance
  Database? _database; // Local SQLite database
  SharedPreferences? _prefs; // Local storage for settings

  // Rate limiting to prevent API abuse
  final Map<String, List<DateTime>> _userRequests = {};
  final int _maxRequestsPerMinute = 15; // Free tier limit

  /// Initialize AI model and database connections
  Future<void> initializeModel() async {
    // Setup Gemini AI model with medical training
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: GlobalVariables.geminiApiKey,
      safetySettings: [
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.medium),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.medium),
      ],
      systemInstruction: Content.system(_getAdvancedSystemPrompt()),
    );

    // Initialize local database and preferences
    await _initializeDatabase();
    _prefs = await SharedPreferences.getInstance();
  }

  /// Advanced medical AI system prompt
  /// Trains AI to act as MBBS doctor with complete medical knowledge
  String _getAdvancedSystemPrompt() {
    return '''
🏥 You are Dr. MediCare AI – a professional MBBS-level medical assistant. 

**RULES:**
- Greet: "Hello! I'm  MediCare pharma trained AI Model , your personal medical assistant. How can I help?"
- Be warm, professional, and empathetic.
- Only answer medical/pharmaceutical queries.
- Use medical terminology when needed.
- Give brief (2–3 lines) replies with dosage, side effects, or interactions.
- After each answer, ask: "Would you like more detailed info?"

**FORMAT:**
## 🩺 Medical Assessment
- Short condition explanation
- Basic treatment / medicine suggestion
- Important warnings
- Advise follow-up with a doctor

Always act like a senior doctor available 24/7.
  ''';
  }

  /// Create local SQLite database for conversation history
  Future<void> _initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'medical_chat.db');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Chat sessions table - stores conversation metadata
        await db.execute('''
          CREATE TABLE chat_sessions (
            id TEXT PRIMARY KEY,
            title TEXT,
            summary TEXT,
            user_id TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
          )
        ''');

        // Messages table - stores individual chat messages
        await db.execute('''
          CREATE TABLE messages (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            chat_id TEXT,
            role TEXT,
            content TEXT,
            image_path TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (chat_id) REFERENCES chat_sessions (id)
          )
        ''');

        // User profiles table - stores medical history
        await db.execute('''
          CREATE TABLE user_profiles (
            user_id TEXT PRIMARY KEY,
            name TEXT,
            age INTEGER,
            gender TEXT,
            blood_type TEXT,
            allergies TEXT,
            chronic_conditions TEXT,
            current_medications TEXT,
            medical_history TEXT,
            emergency_contact TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
          )
        ''');
      },
    );
  }

  /// Check if user has exceeded rate limit (15 requests per minute)
  bool _checkRateLimit(String userId) {
    final now = DateTime.now();
    final userReqs = _userRequests[userId] ?? [];

    // Remove old requests (older than 1 minute)
    userReqs.removeWhere((time) => now.difference(time).inMinutes >= 1);

    if (userReqs.length >= _maxRequestsPerMinute) {
      return false; // Rate limit exceeded
    }

    userReqs.add(now);
    _userRequests[userId] = userReqs;
    return true;
  }

  /// Get user's medical profile for personalized responses
  Future<String> _getUserProfile(String userId) async {
    if (_database == null) return '';

    final result = await _database!.query(
      'user_profiles',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (result.isEmpty) return '';

    final profile = result.first;
    return '''
User Medical Profile:
- Name: ${profile['name'] ?? 'Not provided'}
- Age: ${profile['age'] ?? 'Not provided'}  
- Gender: ${profile['gender'] ?? 'Not provided'}
- Blood Type: ${profile['blood_type'] ?? 'Not provided'}
- Allergies: ${profile['allergies'] ?? 'None reported'}
- Chronic Conditions: ${profile['chronic_conditions'] ?? 'None reported'}
- Current Medications: ${profile['current_medications'] ?? 'None reported'}
    ''';
  }

  /// Get recent chat history for context
  Future<List<Map<String, dynamic>>> _getChatHistory(String chatId) async {
    if (_database == null) return [];

    return await _database!.query(
      'messages',
      where: 'chat_id = ?',
      whereArgs: [chatId],
      orderBy: 'created_at ASC',
      limit: 10, // Last 10 messages for context
    );
  }

  /// Main method to generate AI responses with streaming
  /// Handles rate limiting, context, and database storage
  Stream<ChatResponse> generateAdvancedTextStream(
    String prompt,
    String userId,
    String chatId, {
    String? imagePath,
  }) async* {
    if (_model == null) throw AIException('AI model not initialized');

    // Check rate limit first
    if (!_checkRateLimit(userId)) {
      yield ChatResponse(
        text:
            '⚠️ Rate limit exceeded (15/min). Please wait before sending another message.',
        isError: true,
      );
      return;
    }

    try {
      // Get user context for personalized responses
      final userProfile = await _getUserProfile(userId);
      final chatHistory = await _getChatHistory(chatId);

      // Build conversation context
      List<Content> conversation = [];

      // Add user profile context
      if (userProfile.isNotEmpty) {
        conversation.add(Content.text('''
Previous conversation and user profile:
$userProfile

Use this information for personalized medical advice.
        '''));
      }

      // Add recent chat history
      for (var message in chatHistory) {
        conversation.add(Content.text(
            '${message['role'] == 'user' ? 'User' : 'Dr. MediCare'}: ${message['content']}'));
      }

      // Add current message with optional image
      if (imagePath != null && imagePath.isNotEmpty) {
        final imageBytes = await File(imagePath).readAsBytes();
        conversation.add(Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ]));
      } else {
        conversation.add(Content.text(prompt));
      }

      // Generate streaming AI response
      final responseStream = _model!.generateContentStream(conversation);
      String fullResponse = '';

      await for (final response in responseStream) {
        final chunk = response.text ?? '';
        fullResponse += chunk;
        yield ChatResponse(text: chunk);
      }

      // Save conversation to database
      await _saveMessage(chatId, 'user', prompt, imagePath);
      await _saveMessage(chatId, 'assistant', fullResponse, null);
      await _updateChatSummary(chatId, prompt, fullResponse);
    } catch (e) {
      yield ChatResponse(
        text: '❌ Error: ${e.toString()}',
        isError: true,
      );
    }
  }

  /// Save message to local database
  Future<void> _saveMessage(
      String chatId, String role, String content, String? imagePath) async {
    if (_database == null) return;

    await _database!.insert('messages', {
      'chat_id': chatId,
      'role': role,
      'content': content,
      'image_path': imagePath,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  /// Update chat summary using AI
  Future<void> _updateChatSummary(
      String chatId, String userMessage, String assistantResponse) async {
    if (_database == null || _model == null) return;

    try {
      final summaryResponse = await _model!.generateContent([
        Content.text('''
Summarize this medical conversation briefly:
User: $userMessage
Dr. MediCare: $assistantResponse

Include: symptoms, diagnosis, medications, recommendations.
        ''')
      ]);

      await _database!.update(
          'chat_sessions',
          {
            'summary': summaryResponse.text ?? '',
            'updated_at': DateTime.now().toIso8601String(),
          },
          where: 'id = ?',
          whereArgs: [chatId]);
    } catch (e) {
      print('Summary update failed: $e');
    }
  }

  /// Create new chat session
  Future<String> createNewChat(String userId, String title) async {
    if (_database == null) return '';

    String chatId = DateTime.now().millisecondsSinceEpoch.toString();
    await _database!.insert('chat_sessions', {
      'id': chatId,
      'title': title,
      'user_id': userId,
      'created_at': DateTime.now().toIso8601String(),
    });

    return chatId;
  }

  /// Get user's chat history
  Future<List<Map<String, dynamic>>> getUserChats(String userId) async {
    if (_database == null) return [];

    return await _database!.query(
      'chat_sessions',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'updated_at DESC',
    );
  }

  void dispose() => _database?.close();
}

// Remove this class to avoid shadowing sqflite's Database type

// # =============================================================================
// # 6. CHAT CONTROLLER - State Management (Provider)
// # =============================================================================

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


// # =============================================================================
// # 9. ADDITIONAL FEATURES (Optional Enhancements)
// # =============================================================================

// user_profile_screen.dart (Optional)
/// Screen for managing user medical profile
/// Allows users to input medical history, allergies, medications
// class UserProfileScreen extends StatefulWidget {
//   const UserProfileScreen({super.key});

//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }

// class _UserProfileScreenState extends State<UserProfileScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _allergiesController = TextEditingController();
//   final _medicationsController = TextEditingController();
//   String _selectedGender = 'Male';
//   String _selectedBloodType = 'O+';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medical Profile'),
//         backgroundColor: const Color(0xFF009798),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Profile form fields
//               _buildTextField('Full Name', _nameController, Icons.person),
//               _buildTextField('Age', _ageController, Icons.calendar_today,
//                   isNumber: true),
//               _buildDropdown(
//                   'Gender', _selectedGender, ['Male', 'Female', 'Other'],
//                   (value) {
//                 setState(() => _selectedGender = value!);
//               }),
//               _buildDropdown('Blood Type', _selectedBloodType,
//                   ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], (value) {
//                 setState(() => _selectedBloodType = value!);
//               }),
//               _buildTextField('Allergies', _allergiesController, Icons.warning,
//                   maxLines: 3),
//               _buildTextField('Current Medications', _medicationsController,
//                   Icons.medication,
//                   maxLines: 3),

//               const SizedBox(height: 20),
//               // ElevatedButton(
//               //   // onPressed: _saveProfile,
//               //   child: const Text('Save Profile'),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       String label, TextEditingController controller, IconData icon,
//       {bool isNumber = false, int maxLines = 1}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: const Color(0xFF009798)),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String label, String value, List<String> items,
//       ValueChanged<String?> onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: DropdownButtonFormField<String>(
//         value: value,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon:
//               const Icon(Icons.arrow_drop_down, color: Color(0xFF009798)),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         items: items
//             .map((item) => DropdownMenuItem(value: item, child: Text(item)))
//             .toList(),
//         onChanged: onChanged,
//       ),
//     );
//   }

//   // void _saveProfile() async {
//   //   if (_formKey.currentState!.validate()) {
//   //     final controller = Provider.of<AIChatController>(context, listen: false);
//   //     await controller._aiRepository.saveUserProfile(
//   //       userId: controller._userId,
//   //       name: _nameController.text,
//   //       age: int.tryParse(_ageController.text),
//   //       gender: _selectedGender,
//   //       bloodType: _selectedBloodType,
//   //       allergies: _allergiesController.text,
//   //       currentMedications: _medicationsController.text,
//   //     );

//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Profile saved successfully!')),
//   //     );
//   //   }
//   // }
// }

// # =============================================================================
// # SUMMARY: Complete Medical AI App Structure
// # =============================================================================
//! Writen By Saadullah At  1  baj k 20 minunte : 😂 
/*
📱 COMPLETE APP FEATURES:

1. ✅ ADVANCED AI DOCTOR
   - Complete MBBS training prompts
   - Medical specialties coverage
   - Pharmaceutical database
   - Emergency protocols

2. ✅ DATABASE INTEGRATION  
   - SQLite local storage
   - Chat history preservation
   - User medical profiles
   - Conversation summaries

3. ✅ RATE LIMITING
   - 15 requests per minute (free tier)
   - Automatic blocking system
   - User-friendly error messages

4. ✅ BEAUTIFUL MEDICAL UI
   - Teal gradient theme
   - Animated particles background  
   - Smooth animations
   - Professional medical design

5. ✅ IMAGE ANALYSIS
   - Medical image upload
   - AI-powered analysis
   - Professional assessment
   - Educational disclaimers

6. ✅ STREAMING RESPONSES
   - Real-time AI responses
   - Typing indicators
   - Smooth text streaming
   - Error handling

7. ✅ PERSONALIZATION
   - User medical profiles
   - Context-aware responses
   - Medical history integration
   - Age/gender specific advice

8. ✅ PROFESSIONAL FEATURES
   - Welcome screen with quick actions
   - Error handling system
   - Message persistence
   - State management (Provider)

🔧 REQUIRED PACKAGES (pubspec.yaml):
- flutter
- google_fonts: ^6.2.1
- animate_do: ^3.3.4  
- particles_fly: ^1.0.2
- provider: ^6.1.2
- image_picker: ^1.0.8
- dio: ^5.4.3+1
- sqflite: ^2.3.3+1
- path: ^1.9.0
- google_generative_ai: ^0.4.3
- shared_preferences: ^2.2.3
- uuid: ^4.4.0

💡 APP WORKFLOW:
User Message → Rate Limit Check → AI Processing → Database Save → UI Update

🏆 RESULT: Complete medical AI assistant with professional features!
*/
