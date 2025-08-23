

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/ai_bot_module/ai_repo.dart';
import 'package:laza/Features/ai_bot_module/chat_message.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:particles_fly/particles_fly.dart';
import 'package:provider/provider.dart';

/// Main chat interface with medical theme
/// Beautiful UI with teal gradient and smooth animations
class AIChatView extends StatelessWidget {
  const AIChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF009798), // Primary teal
              Colors.white, // Clean white center
              Color(0xFFF5F6F5), // Light background
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none, // Ensure particles aren't clipped
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      _buildMedicalHeader(context, constraints),
                      Expanded(child: _buildChatArea(context, constraints)),
                      _buildInputArea(context, constraints),
                    ],
                  ),
                ),
                // Animated background particles for medical feel
                //! Pehla: ParticlesFly Positioned ma tha lekin z-index issue ki wajah se shayad peeche chhup raha tha
                //! Ab: ParticlesFly ko Stack k pehle child banaya aur clipBehavior: Clip.none set kia taake wo clearly visible ho
                //! Faida: Particles ab UI k ooper render honge, hidden hone ka chance khatam ho gaya
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: constraints.maxHeight *
                      0.5, // Increased height for visibility
                  child: ParticlesFly(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth,
                    //! Pehla: numberOfParticles 10 tha aur particleColor opacity 0.1 thi, jo bohat faint thi
                    //! Ab: numberOfParticles 20 kia aur opacity 0.5 ki taake animation zyada clear dikhe
                    //! Faida: Particles zyada visible honge, lekin performance abhi bhi stable rahegi
                    numberOfParticles: 20,
                    speedOfParticles: 0.60,
                    connectDots: false,
                    particleColor: const Color(0xFF009798).withOpacity(0.5),
                    onTapAnimation: false,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Professional medical header with status indicator
  Widget _buildMedicalHeader(BuildContext context, BoxConstraints constraints) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. MediCare AI',
                  style: GoogleFonts.poppins(
                    fontSize: constraints.maxWidth * 0.065,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF009798),
                  ),
                ),
                Text(
                  'Your Personal Medical Assistant',
                  style: GoogleFonts.poppins(
                    fontSize: constraints.maxWidth * 0.032,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Consumer<AIChatController>(
              builder: (context, controller, _) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.04,
                  vertical: constraints.maxHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: controller.isStreaming
                      ? LinearGradient(
                          colors: [Colors.red, Colors.redAccent.shade100])
                      : LinearGradient(
                          colors: [Colors.teal, Colors.tealAccent.shade200]),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.isStreaming
                          ? Icons.psychology
                          : Icons.medical_services,
                      color: Colors.white,
                      size: constraints.maxWidth * 0.04,
                    ),
                    SizedBox(width: constraints.maxWidth * 0.02),
                    Text(
                      controller.isStreaming ? 'Analyzing...' : 'Ready',
                      style: GoogleFonts.poppins(
                        fontSize: constraints.maxWidth * 0.034,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Main chat area with medical-themed styling
  Widget _buildChatArea(BuildContext context, BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF009798).withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Consumer<AIChatController>(
          builder: (context, controller, _) {
            // Scroll to bottom when new messages or streaming text changes
            //! Pehla: ListView auto-scroll nahi kar raha tha, naye messages shayad screen se bahar reh jate thay
            //! Ab: scrollToBottom method add kia taake naye messages hamesha visible hon
            //! Faida: User ko latest response dekhne ke liye manually scroll nahi karna parhega
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (controller.scrollController.hasClients) {
                controller.scrollController.animateTo(
                  controller.scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              }
            });

            if (controller.messages.isEmpty && !controller.isStreaming) {
              return _buildWelcomeScreen(context, constraints);
            }

            return Container(
              //! Pehla: Chat area ka koi debug border nahi tha
              //! Ab: Temporary green border add kia taake chat area ka position aur size confirm ho
              //! Faida: Debugging ma madad milti hai, confirm hota hai ke chat area sahi jagah render ho raha hai
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.green.withOpacity(0.5)), // Debug border
              ),
              child: ListView.builder(
                controller: controller.scrollController,
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                itemCount: controller.messages.length +
                    (controller.isStreaming ? 1 : 0) +
                    (controller.errorMessage.isNotEmpty ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show error message
                  if (controller.errorMessage.isNotEmpty && index == 0) {
                    //! Ye error message show karta hai agar koi issue ho (e.g., API error)
                    return _buildErrorBubble(
                        context, constraints, controller.errorMessage);
                  }

                  // Adjust index for error message
                  int messageIndex =
                      controller.errorMessage.isNotEmpty ? index - 1 : index;

                  // Show streaming response
                  if (messageIndex == controller.messages.length &&
                      controller.isStreaming) {
                    //! Ye streaming response show karta hai jab AI jawab generate kar raha hota hai
                    return _buildStreamingBubble(
                        context, constraints, controller.streamedText);
                  }

                  // Show regular message
                  if (messageIndex < controller.messages.length) {
                    final msg = controller.messages[messageIndex];
                    //! Ye regular messages (user aur AI ke) show karta hai
                    return _buildMessageBubble(
                        context, constraints, msg, messageIndex);
                  }

                  return const SizedBox.shrink();
                },
              ),
            );
          },
        ),
      ),
    );
  }

  /// Welcome screen for new users
  Widget _buildWelcomeScreen(BuildContext context, BoxConstraints constraints) {
    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: SingleChildScrollView(
        //! Pehla: Column direct use ho raha tha, overflow error aa raha tha (51 pixels bottom se)
        //! Ab: Column ko SingleChildScrollView ma wrap kia
        //! Faida: Content jo screen se bahar ja raha tha ab scrollable ho gaya, overflow error fix ho gaya
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              backgroundColor: Colors.teal.withOpacity(.6),
              radius: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    PngImages.doctor,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.03),
            Text(
              'Welcome to Dr. MediCare AI',
              style: GoogleFonts.poppins(
                fontSize: constraints.maxWidth * 0.055,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF009798),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08),
              child: Text(
                'I\'m your personal medical assistant with complete MBBS training. Ask me about symptoms, medications, treatments, or upload medical images for analysis.',
                style: GoogleFonts.poppins(
                  fontSize: constraints.maxWidth * 0.038,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04),
            _buildQuickActionButtons(context, constraints),
          ],
        ),
      ),
    );
  }

  /// Quick action buttons for common medical queries
  Widget _buildQuickActionButtons(
      BuildContext context, BoxConstraints constraints) {
    final quickActions = [
      {
        'icon': Icons.coronavirus,
        'text': 'Symptoms Check',
        'query': 'I have some symptoms I want to discuss'
      },
      {
        'icon': Icons.medical_information_outlined,
        //! Pehla: Icon tha Icons.medication
        //! Ab: Icons.medical_information_outlined use kia
        //! Faida: Naya icon medical information ke context ko zyada suit karta hai, UI clarity barhti hai
        'text': 'Medicine Info',
        'query': 'Tell me about a medication'
      },
      {
        'icon': Icons.camera_alt,
        'text': 'Image Analysis',
        'query': 'analyze_image'
      },
    ];

    return Wrap(
      spacing: constraints.maxWidth * 0.02,
      runSpacing: constraints.maxHeight * 0.015,
      children: quickActions.map((action) {
        return GestureDetector(
          onTap: () {
            final controller =
                Provider.of<AIChatController>(context, listen: false);
            if (action['query'] == 'analyze_image') {
              controller.pickAndAnalyzeImage();
            } else {
              controller.sendMessage(action['query'] as String);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.04,
              vertical: constraints.maxHeight * 0.015,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF009798).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF009798).withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  action['icon'] as IconData,
                  color: const Color(0xFF009798),
                  size: constraints.maxWidth * 0.06,
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  action['text'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: constraints.maxWidth * 0.03,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF009798),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Individual message bubble with medical styling
  Widget _buildMessageBubble(BuildContext context, BoxConstraints constraints,
      ChatMessage msg, int index) {
    return FadeInUp(
      duration: Duration(milliseconds: 300 + (index * 50)),
      child: Align(
        alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment:
              msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show avatar only for AI messages
            if (!msg.isUser)
              //! Pehla: CircleAvatar ka radius constraints.maxWidth * 0.08 tha, jo bada tha
              //! Ab: Radius ko constraints.maxWidth * 0.05 kia taake avatar chota ho
              //! Faida: UI zyada compact aur balanced dikhega
              Padding(
                padding: EdgeInsets.only(right: constraints.maxWidth * 0.02),
                child: CircleAvatar(
                  radius: constraints.maxWidth * 0.05, // Smaller avatar
                  backgroundImage: const AssetImage(PngImages.doctor),
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF009798),
                        width: 1.5, // Reduced border width for smaller avatar
                      ),
                    ),
                  ),
                ),
              ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.008),
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth *
                        0.75), // Adjusted for smaller avatar
                decoration: BoxDecoration(
                  color: msg.isUser
                      ? const Color(0xFF009798).withOpacity(0.15)
                      : Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: msg.isUser
                        ? const Radius.circular(20)
                        : const Radius.circular(5),
                    bottomRight: msg.isUser
                        ? const Radius.circular(5)
                        : const Radius.circular(20),
                  ),
                  border: Border.all(
                    color: msg.isUser
                        ? const Color(0xFF009798).withOpacity(0.3)
                        : Colors.grey.withOpacity(0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (msg.imagePath != null)
                      //! Pehla: Image upload ke baad AI response ek dafa dikhta tha phir gayab ho jata tha, white container reh jata tha
                      //! Ab: Image rendering ko Builder se wrap kia aur error handling add kia, AIChatController ma notifyListeners ensure kia
                      //! Faida: Image upload ke baad message stable rahega, hang nahi hoga
                      Builder(
                        builder: (context) {
                          try {
                            return Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: constraints.maxHeight * 0.01),
                                  height: constraints.maxHeight * 0.15,
                                  width: constraints.maxWidth *
                                      0.6, // Reduced width to prevent overflow
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(File(msg.imagePath!)),
                                      fit: BoxFit.cover,
                                      onError: (exception, stackTrace) {
                                        print('Image load error: $exception');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } catch (e) {
                            return Container(
                              padding:
                                  EdgeInsets.all(constraints.maxWidth * 0.02),
                              color: Colors.red.withOpacity(0.1),
                              child: Text(
                                'Failed to load image: $e',
                                style: GoogleFonts.poppins(
                                  color: Colors.red[700],
                                  fontSize: constraints.maxWidth * 0.034,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    SelectableText(
                      msg.content,
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: constraints.maxWidth * 0.036,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.005),
                    Text(
                      msg.isUser ? 'You' : 'Dr. MediCare AI',
                      style: GoogleFonts.poppins(
                        fontSize: constraints.maxWidth * 0.028,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Streaming response bubble with typing animation
  Widget _buildStreamingBubble(
      BuildContext context, BoxConstraints constraints, String streamedText) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show avatar for streaming AI response
            //! Pehla: CircleAvatar ka radius constraints.maxWidth * 0.08 tha, jo bada tha
            //! Ab: Radius ko constraints.maxWidth * 0.05 kia taake avatar chota ho
            //! Faida: UI zyada compact aur balanced dikhega
            Padding(
              padding: EdgeInsets.only(right: constraints.maxWidth * 0.02),
              child: CircleAvatar(
                radius: constraints.maxWidth * 0.05, // Smaller avatar
                backgroundImage: const AssetImage(PngImages.doctor),
                backgroundColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF009798),
                      width: 1.5, // Reduced border width for smaller avatar
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                margin: EdgeInsets.symmetric(
                    vertical: constraints.maxHeight * 0.008),
                constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth *
                        0.75), // Adjusted for smaller avatar
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(5),
                  ),
                  border: Border.all(
                      color: const Color(0xFF009798).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (streamedText.isNotEmpty)
                      SelectableText(
                        streamedText,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: constraints.maxWidth * 0.036,
                          height: 1.5,
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _typingDot(constraints),
                        _typingDot(constraints, delay: 200),
                        _typingDot(constraints, delay: 400),
                        SizedBox(width: constraints.maxWidth * 0.02),
                        Text(
                          'Dr. MediCare is typing...',
                          style: GoogleFonts.poppins(
                            fontSize: constraints.maxWidth * 0.028,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Error message bubble
  Widget _buildErrorBubble(
      BuildContext context, BoxConstraints constraints, String error) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
        padding: EdgeInsets.all(constraints.maxWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.error,
                color: Colors.red, size: constraints.maxWidth * 0.05),
            SizedBox(width: constraints.maxWidth * 0.03),
            Expanded(
              child: Text(
                error,
                style: GoogleFonts.poppins(
                  color: Colors.red[700],
                  fontSize: constraints.maxWidth * 0.034,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Provider.of<AIChatController>(context, listen: false)
                  .clearError(),
              child: Icon(Icons.close,
                  color: Colors.red, size: constraints.maxWidth * 0.04),
            ),
          ],
        ),
      ),
    );
  }

  /// Animated typing dot
  Widget _typingDot(BoxConstraints constraints, {int delay = 0}) {
    return Bounce(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.005),
        width: constraints.maxWidth * 0.015,
        height: constraints.maxWidth * 0.015,
        decoration: const BoxDecoration(
          color: Color(0xFF009798),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// Enhanced input area with medical features
  Widget _buildInputArea(BuildContext context, BoxConstraints constraints) {
    return Container(
      margin: EdgeInsets.all(constraints.maxWidth * 0.03),
      padding: EdgeInsets.symmetric(
        horizontal: constraints.maxWidth * 0.02,
        vertical: constraints.maxHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF009798).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Consumer<AIChatController>(
        builder: (context, controller, _) => Row(
          children: [
            // Image picker button
            GestureDetector(
              onTap: controller.isStreaming
                  ? null
                  : () => controller.pickAndAnalyzeImage(),
              child: Container(
                padding: EdgeInsets.all(constraints.maxWidth * 0.025),
                decoration: BoxDecoration(
                  color: controller.isStreaming
                      ? Colors.grey.withOpacity(0.3)
                      : const Color(0xFF009798).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: controller.isStreaming
                      ? Colors.grey
                      : const Color(0xFF009798),
                  size: constraints.maxWidth * 0.05,
                ),
              ),
            ),
            SizedBox(width: constraints.maxWidth * 0.03),

            // Text input field
            Expanded(
              child: TextField(
                controller: controller.textController,
                style:
                    GoogleFonts.poppins(fontSize: constraints.maxWidth * 0.036),
                decoration: InputDecoration(
                  hintText: controller.isStreaming
                      ? 'Dr. MediCare is responding...'
                      : 'Describe your symptoms or ask about medications...',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.grey[500],
                    fontSize: constraints.maxWidth * 0.034,
                  ),
                  border: InputBorder.none,
                ),
                enabled: !controller.isStreaming,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (text) => _sendMessage(context, text),
              ),
            ),

            // Send button
            GestureDetector(
              onTap: controller.isStreaming
                  ? null
                  : () => _sendMessage(context, controller.textController.text),
              child: Container(
                padding: EdgeInsets.all(constraints.maxWidth * 0.025),
                decoration: BoxDecoration(
                  color: controller.isStreaming
                      ? Colors.grey
                      : const Color(0xFF009798),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: (controller.isStreaming
                              ? Colors.grey
                              : const Color(0xFF009798))
                          .withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  controller.isStreaming ? Icons.hourglass_empty : Icons.send,
                  color: Colors.white,
                  size: constraints.maxWidth * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Send message handler
  void _sendMessage(BuildContext context, String text) {
    final message = text.trim();
    final controller = Provider.of<AIChatController>(context, listen: false);
    if (message.isNotEmpty && !controller.isStreaming) {
      controller.sendMessage(message);
      controller.textController.clear();
    }
  }
}
