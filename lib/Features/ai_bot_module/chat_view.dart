// // import 'dart:io';

// // import 'package:animate_do/animate_do.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:laza/Features/ai_bot_module/ai_repo.dart';
// // import 'package:laza/Features/ai_bot_module/chat_message.dart';
// // import 'package:laza/Resources/Paths/imports.dart';
// // import 'package:particles_fly/particles_fly.dart';
// // import 'package:provider/provider.dart';

// // /// Main chat interface with medical theme
// // /// Beautiful UI with teal gradient and smooth animations
// // class AIChatView extends StatelessWidget {
// //   const AIChatView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Color(0xFF009798), // Primary teal
// //               Colors.white, // Clean white center
// //               Color(0xFFF5F6F5), // Light background
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: LayoutBuilder(
// //           builder: (context, constraints) {
// //             return Stack(
// //               children: [
// //                 // Animated background particles for medical feel
// //                 //! Pehla: ParticlesFly simple Stack ma tha, koi specific positioning nahi thi
// //                 //! Ab: Positioned widget ma wrap kia top: 0 k sath taake animation screen k oper clearly nazar ay
// //                 //! Faida: Particle animation top ma prominent hoti ha, UI ko zyada engaging aur medical-themed banata ha
// //                 Positioned(
// //                   top: 0,
// //                   left: 0,
// //                   right: 0,
// //                   height: constraints.maxHeight *
// //                       0.3, // Limited height to top portion
// //                   child: ParticlesFly(
// //                     height: constraints.maxHeight * 0.3,
// //                     width: constraints.maxWidth,
// //                     //! Pehla: numberOfParticles 25 tha aur onTapAnimation true tha
// //                     //! Ab: numberOfParticles 10 kia aur onTapAnimation false kia
// //                     //! Faida: Kam particles aur disabled tap animation se GPU load kam hota ha, performance behtar hoti ha
// //                     numberOfParticles: 10,
// //                     speedOfParticles: 0.12,
// //                     connectDots: false,
// //                     particleColor: const Color(0xFF009798).withOpacity(0.1),
// //                     onTapAnimation: false,
// //                   ),
// //                 ),
// //                 SafeArea(
// //                   child: Column(
// //                     children: [
// //                       _buildMedicalHeader(context, constraints),
// //                       Expanded(child: _buildChatArea(context, constraints)),
// //                       _buildInputArea(context, constraints),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   /// Professional medical header with status indicator
// //   Widget _buildMedicalHeader(BuildContext context, BoxConstraints constraints) {
// //     return FadeInDown(
// //       duration: const Duration(milliseconds: 600),
// //       child: Container(
// //         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Dr. MediCare AI',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: constraints.maxWidth * 0.065,
// //                     fontWeight: FontWeight.w700,
// //                     color: const Color(0xFF009798),
// //                   ),
// //                 ),
// //                 Text(
// //                   'Your Personal Medical Assistant',
// //                   style: GoogleFonts.poppins(
// //                     fontSize: constraints.maxWidth * 0.032,
// //                     color: Colors.grey[600],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Consumer<AIChatController>(
// //               builder: (context, controller, _) => Container(
// //                 padding: EdgeInsets.symmetric(
// //                   horizontal: constraints.maxWidth * 0.04,
// //                   vertical: constraints.maxHeight * 0.01,
// //                 ),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(20),
// //                   gradient: controller.isStreaming
// //                       ? LinearGradient(
// //                           colors: [Colors.red, Colors.redAccent.shade100])
// //                       : LinearGradient(
// //                           colors: [Colors.teal, Colors.tealAccent.shade200]),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: Colors.black.withOpacity(0.1),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Row(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Icon(
// //                       controller.isStreaming
// //                           ? Icons.psychology
// //                           : Icons.medical_services,
// //                       color: Colors.white,
// //                       size: constraints.maxWidth * 0.04,
// //                     ),
// //                     SizedBox(width: constraints.maxWidth * 0.02),
// //                     Text(
// //                       controller.isStreaming ? 'Analyzing...' : 'Ready',
// //                       style: GoogleFonts.poppins(
// //                         fontSize: constraints.maxWidth * 0.034,
// //                         color: Colors.white,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// Main chat area with medical-themed styling
// //   Widget _buildChatArea(BuildContext context, BoxConstraints constraints) {
// //     return Container(
// //       margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withOpacity(0.95),
// //         borderRadius: BorderRadius.circular(25),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.08),
// //             blurRadius: 15,
// //             offset: const Offset(0, 5),
// //           ),
// //         ],
// //         border: Border.all(
// //           color: const Color(0xFF009798).withOpacity(0.15),
// //           width: 1.5,
// //         ),
// //       ),
// //       child: ClipRRect(
// //         borderRadius: BorderRadius.circular(25),
// //         child: Consumer<AIChatController>(
// //           builder: (context, controller, _) {
// //             if (controller.messages.isEmpty && !controller.isStreaming) {
// //               return _buildWelcomeScreen(context, constraints);
// //             }

// //             return ListView.builder(
// //               controller: controller.scrollController,
// //               padding: EdgeInsets.all(constraints.maxWidth * 0.04),
// //               itemCount: controller.messages.length +
// //                   (controller.isStreaming ? 1 : 0) +
// //                   (controller.errorMessage.isNotEmpty ? 1 : 0),
// //               itemBuilder: (context, index) {
// //                 // Show error message
// //                 if (controller.errorMessage.isNotEmpty && index == 0) {
// //                   return _buildErrorBubble(
// //                       context, constraints, controller.errorMessage);
// //                 }

// //                 // Adjust index for error message
// //                 int messageIndex =
// //                     controller.errorMessage.isNotEmpty ? index - 1 : index;

// //                 // Show streaming response
// //                 if (messageIndex == controller.messages.length &&
// //                     controller.isStreaming) {
// //                   return _buildStreamingBubble(
// //                       context, constraints, controller.streamedText);
// //                 }

// //                 // Show regular message
// //                 if (messageIndex < controller.messages.length) {
// //                   final msg = controller.messages[messageIndex];
// //                   return _buildMessageBubble(
// //                       context, constraints, msg, messageIndex);
// //                 }

// //                 return const SizedBox.shrink();
// //               },
// //             );
// //           },
// //         ),
// //       ),
// //     );
// //   }

// //   /// Welcome screen for new users
// //   Widget _buildWelcomeScreen(BuildContext context, BoxConstraints constraints) {
// //     return FadeIn(
// //       duration: const Duration(milliseconds: 800),
// //       child: SingleChildScrollView(
// //         //! Pehla: Column direct use ho raha tha, overflow error aa raha tha (51 pixels bottom se)
// //         //! Ab: Column ko SingleChildScrollView ma wrap kia
// //         //! Faida: Content jo screen se bahar ja raha tha ab scrollable ho gaya, overflow error fix ho gaya
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.medical_services_rounded,
// //               size: constraints.maxWidth * 0.2,
// //               color: const Color(0xFF009798).withOpacity(0.7),
// //             ),
// //             SizedBox(height: constraints.maxHeight * 0.03),
// //             Text(
// //               'Welcome to Dr. MediCare AI',
// //               style: GoogleFonts.poppins(
// //                 fontSize: constraints.maxWidth * 0.055,
// //                 fontWeight: FontWeight.w600,
// //                 color: const Color(0xFF009798),
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             SizedBox(height: constraints.maxHeight * 0.02),
// //             Padding(
// //               padding:
// //                   EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08),
// //               child: Text(
// //                 'I\'m your personal medical assistant with complete MBBS training. Ask me about symptoms, medications, treatments, or upload medical images for analysis.',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: constraints.maxWidth * 0.038,
// //                   color: Colors.grey[600],
// //                   height: 1.5,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ),
// //             SizedBox(height: constraints.maxHeight * 0.04),
// //             _buildQuickActionButtons(context, constraints),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// Quick action buttons for common medical queries
// //   Widget _buildQuickActionButtons(
// //       BuildContext context, BoxConstraints constraints) {
// //     final quickActions = [
// //       {
// //         'icon': Icons.coronavirus,
// //         'text': 'Symptoms Check',
// //         'query': 'I have some symptoms I want to discuss'
// //       },
// //       {
// //         'icon': Icons.medication,
// //         'text': 'Medicine Info',
// //         'query': 'Tell me about a medication'
// //       },
// //       {
// //         'icon': Icons.camera_alt,
// //         'text': 'Image Analysis',
// //         'query': 'analyze_image'
// //       },
// //     ];

// //     return Wrap(
// //       spacing: constraints.maxWidth * 0.02,
// //       runSpacing: constraints.maxHeight * 0.015,
// //       children: quickActions.map((action) {
// //         return GestureDetector(
// //           onTap: () {
// //             final controller =
// //                 Provider.of<AIChatController>(context, listen: false);
// //             if (action['query'] == 'analyze_image') {
// //               controller.pickAndAnalyzeImage();
// //             } else {
// //               controller.sendMessage(action['query'] as String);
// //             }
// //           },
// //           child: Container(
// //             padding: EdgeInsets.symmetric(
// //               horizontal: constraints.maxWidth * 0.04,
// //               vertical: constraints.maxHeight * 0.015,
// //             ),
// //             decoration: BoxDecoration(
// //               color: const Color(0xFF009798).withOpacity(0.1),
// //               borderRadius: BorderRadius.circular(15),
// //               border: Border.all(
// //                 color: const Color(0xFF009798).withOpacity(0.3),
// //               ),
// //             ),
// //             child: Column(
// //               children: [
// //                 Icon(
// //                   action['icon'] as IconData,
// //                   color: const Color(0xFF009798),
// //                   size: constraints.maxWidth * 0.06,
// //                 ),
// //                 SizedBox(height: constraints.maxHeight * 0.01),
// //                 Text(
// //                   action['text'] as String,
// //                   style: GoogleFonts.poppins(
// //                     fontSize: constraints.maxWidth * 0.03,
// //                     fontWeight: FontWeight.w500,
// //                     color: const Color(0xFF009798),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       }).toList(),
// //     );
// //   }

// //   /// Individual message bubble with medical styling
// //   Widget _buildMessageBubble(BuildContext context, BoxConstraints constraints,
// //       ChatMessage msg, int index) {
// //     return FadeInUp(
// //       duration: Duration(milliseconds: 300 + (index * 50)),
// //       child: Align(
// //         alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
// //         child: Container(
// //           margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.008),
// //           padding: EdgeInsets.all(constraints.maxWidth * 0.04),
// //           constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
// //           decoration: BoxDecoration(
// //             color: msg.isUser
// //                 ? const Color(0xFF009798).withOpacity(0.15)
// //                 : Colors.grey.shade50,
// //             borderRadius: BorderRadius.only(
// //               topLeft: const Radius.circular(20),
// //               topRight: const Radius.circular(20),
// //               bottomLeft: msg.isUser
// //                   ? const Radius.circular(20)
// //                   : const Radius.circular(5),
// //               bottomRight: msg.isUser
// //                   ? const Radius.circular(5)
// //                   : const Radius.circular(20),
// //             ),
// //             border: Border.all(
// //               color: msg.isUser
// //                   ? const Color(0xFF009798).withOpacity(0.3)
// //                   : Colors.grey.withOpacity(0.2),
// //             ),
// //             boxShadow: [
// //               BoxShadow(
// //                 color: Colors.black.withOpacity(0.05),
// //                 blurRadius: 5,
// //                 offset: const Offset(0, 2),
// //               ),
// //             ],
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               if (msg.imagePath != null)
// //                 Container(
// //                   margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
// //                   height: constraints.maxHeight * 0.15,
// //                   width: double.infinity,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(10),
// //                     image: DecorationImage(
// //                       image: FileImage(File(msg.imagePath!)),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //               SelectableText(
// //                 msg.content,
// //                 style: GoogleFonts.poppins(
// //                   color: Colors.black87,
// //                   fontSize: constraints.maxWidth * 0.036,
// //                   height: 1.5,
// //                 ),
// //               ),
// //               SizedBox(height: constraints.maxHeight * 0.005),
// //               Text(
// //                 msg.isUser ? 'You' : 'Dr. MediCare AI',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: constraints.maxWidth * 0.028,
// //                   color: Colors.grey[500],
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// Streaming response bubble with typing animation
// //   Widget _buildStreamingBubble(
// //       BuildContext context, BoxConstraints constraints, String streamedText) {
// //     return FadeInUp(
// //       duration: const Duration(milliseconds: 300),
// //       child: Align(
// //         alignment: Alignment.centerLeft,
// //         child: Container(
// //           padding: EdgeInsets.all(constraints.maxWidth * 0.04),
// //           margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.008),
// //           constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
// //           decoration: BoxDecoration(
// //             color: Colors.grey.shade50,
// //             borderRadius: const BorderRadius.only(
// //               topLeft: Radius.circular(20),
// //               topRight: Radius.circular(20),
// //               bottomRight: Radius.circular(20),
// //               bottomLeft: Radius.circular(5),
// //             ),
// //             border: Border.all(color: const Color(0xFF009798).withOpacity(0.2)),
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               if (streamedText.isNotEmpty)
// //                 SelectableText(
// //                   streamedText,
// //                   style: GoogleFonts.poppins(
// //                     color: Colors.black87,
// //                     fontSize: constraints.maxWidth * 0.036,
// //                     height: 1.5,
// //                   ),
// //                 ),
// //               Row(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   _typingDot(constraints),
// //                   _typingDot(constraints, delay: 200),
// //                   _typingDot(constraints, delay: 400),
// //                   SizedBox(width: constraints.maxWidth * 0.02),
// //                   Text(
// //                     'Dr. MediCare is typing...',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: constraints.maxWidth * 0.028,
// //                       color: Colors.grey[500],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   /// Error message bubble
// //   Widget _buildErrorBubble(
// //       BuildContext context, BoxConstraints constraints, String error) {
// //     return FadeInUp(
// //       duration: const Duration(milliseconds: 300),
// //       child: Container(
// //         margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
// //         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
// //         decoration: BoxDecoration(
// //           color: Colors.red.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(15),
// //           border: Border.all(color: Colors.red.withOpacity(0.3)),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(Icons.error,
// //                 color: Colors.red, size: constraints.maxWidth * 0.05),
// //             SizedBox(width: constraints.maxWidth * 0.03),
// //             Expanded(
// //               child: Text(
// //                 error,
// //                 style: GoogleFonts.poppins(
// //                   color: Colors.red[700],
// //                   fontSize: constraints.maxWidth * 0.034,
// //                 ),
// //               ),
// //             ),
// //             GestureDetector(
// //               onTap: () => Provider.of<AIChatController>(context, listen: false)
// //                   .clearError(),
// //               child: Icon(Icons.close,
// //                   color: Colors.red, size: constraints.maxWidth * 0.04),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// Animated typing dot
// //   Widget _typingDot(BoxConstraints constraints, {int delay = 0}) {
// //     return Bounce(
// //       duration: const Duration(milliseconds: 600),
// //       delay: Duration(milliseconds: delay),
// //       child: Container(
// //         margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.005),
// //         width: constraints.maxWidth * 0.015,
// //         height: constraints.maxWidth * 0.015,
// //         decoration: const BoxDecoration(
// //           color: Color(0xFF009798),
// //           shape: BoxShape.circle,
// //         ),
// //       ),
// //     );
// //   }

// //   /// Enhanced input area with medical features
// //   Widget _buildInputArea(BuildContext context, BoxConstraints constraints) {
// //     return Container(
// //       margin: EdgeInsets.all(constraints.maxWidth * 0.03),
// //       padding: EdgeInsets.symmetric(
// //         horizontal: constraints.maxWidth * 0.02,
// //         vertical: constraints.maxHeight * 0.008,
// //       ),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(25),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 10,
// //             offset: const Offset(0, -2),
// //           ),
// //         ],
// //         border: Border.all(
// //           color: const Color(0xFF009798).withOpacity(0.2),
// //           width: 1.5,
// //         ),
// //       ),
// //       child: Consumer<AIChatController>(
// //         builder: (context, controller, _) => Row(
// //           children: [
// //             // Image picker button
// //             GestureDetector(
// //               onTap: controller.isStreaming
// //                   ? null
// //                   : () => controller.pickAndAnalyzeImage(),
// //               child: Container(
// //                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
// //                 decoration: BoxDecoration(
// //                   color: controller.isStreaming
// //                       ? Colors.grey.withOpacity(0.3)
// //                       : const Color(0xFF009798).withOpacity(0.1),
// //                   borderRadius: BorderRadius.circular(15),
// //                 ),
// //                 child: Icon(
// //                   Icons.camera_alt,
// //                   color: controller.isStreaming
// //                       ? Colors.grey
// //                       : const Color(0xFF009798),
// //                   size: constraints.maxWidth * 0.05,
// //                 ),
// //               ),
// //             ),
// //             SizedBox(width: constraints.maxWidth * 0.03),

// //             // Text input field
// //             Expanded(
// //               child: TextField(
// //                 controller: controller.textController,
// //                 style:
// //                     GoogleFonts.poppins(fontSize: constraints.maxWidth * 0.036),
// //                 decoration: InputDecoration(
// //                   hintText: controller.isStreaming
// //                       ? 'Dr. MediCare is responding...'
// //                       : 'Describe your symptoms or ask about medications...',
// //                   hintStyle: GoogleFonts.poppins(
// //                     color: Colors.grey[500],
// //                     fontSize: constraints.maxWidth * 0.034,
// //                   ),
// //                   border: InputBorder.none,
// //                 ),
// //                 enabled: !controller.isStreaming,
// //                 maxLines: null,
// //                 textCapitalization: TextCapitalization.sentences,
// //                 onSubmitted: (text) => _sendMessage(context, text),
// //               ),
// //             ),

// //             // Send button
// //             GestureDetector(
// //               onTap: controller.isStreaming
// //                   ? null
// //                   : () => _sendMessage(context, controller.textController.text),
// //               child: Container(
// //                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
// //                 decoration: BoxDecoration(
// //                   color: controller.isStreaming
// //                       ? Colors.grey
// //                       : const Color(0xFF009798),
// //                   borderRadius: BorderRadius.circular(15),
// //                   boxShadow: [
// //                     BoxShadow(
// //                       color: (controller.isStreaming
// //                               ? Colors.grey
// //                               : const Color(0xFF009798))
// //                           .withOpacity(0.3),
// //                       blurRadius: 8,
// //                       offset: const Offset(0, 2),
// //                     ),
// //                   ],
// //                 ),
// //                 child: Icon(
// //                   controller.isStreaming ? Icons.hourglass_empty : Icons.send,
// //                   color: Colors.white,
// //                   size: constraints.maxWidth * 0.05,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// Send message handler
// //   void _sendMessage(BuildContext context, String text) {
// //     final message = text.trim();
// //     final controller = Provider.of<AIChatController>(context, listen: false);
// //     if (message.isNotEmpty && !controller.isStreaming) {
// //       controller.sendMessage(message);
// //       controller.textController.clear();
// //     }
// //   }
// // }

// import 'dart:io';

// import 'package:animate_do/animate_do.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:laza/Features/ai_bot_module/ai_repo.dart';
// import 'package:laza/Features/ai_bot_module/chat_message.dart';
// import 'package:laza/Resources/Paths/imports.dart';
// import 'package:particles_fly/particles_fly.dart';
// import 'package:provider/provider.dart';

// /// Main chat interface with medical theme
// /// Beautiful UI with teal gradient and smooth animations
// class AIChatView extends StatelessWidget {
//   const AIChatView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF009798), // Primary teal
//               Colors.white, // Clean white center
//               Color(0xFFF5F6F5), // Light background
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return Stack(
//               clipBehavior: Clip.none, // Ensure particles aren't clipped
//               children: [
//                 SafeArea(
//                   child: Column(
//                     children: [
//                       _buildMedicalHeader(context, constraints),
//                       Expanded(child: _buildChatArea(context, constraints)),
//                       _buildInputArea(context, constraints),
//                     ],
//                   ),
//                 ),
//                 // Animated background particles for medical feel
//                 //! Pehla: ParticlesFly Positioned ma tha lekin z-index issue ki wajah se shayad peeche chhup raha tha
//                 //! Ab: ParticlesFly ko Stack k pehle child banaya aur clipBehavior: Clip.none set kia taake wo clearly visible ho
//                 //! Faida: Particles ab UI k ooper render honge, hidden hone ka chance khatam ho gaya
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   height: constraints.maxHeight *
//                       0.5, // Increased height for visibility
//                   child: ParticlesFly(
//                     height: constraints.maxHeight * 0.5,
//                     width: constraints.maxWidth,
//                     //! Pehla: numberOfParticles 10 tha aur particleColor opacity 0.1 thi, jo bohat faint thi
//                     //! Ab: numberOfParticles 15 kia aur opacity 0.5 ki taake animation zyada clear dikhe
//                     //! Faida: Particles zyada visible honge, lekin performance abhi bhi stable rahegi
//                     numberOfParticles: 20,
//                     speedOfParticles: 0.40,
//                     connectDots: false,
//                     particleColor: const Color(0xFF009798).withOpacity(0.5),
//                     onTapAnimation: false,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Professional medical header with status indicator
//   Widget _buildMedicalHeader(BuildContext context, BoxConstraints constraints) {
//     return FadeInDown(
//       duration: const Duration(milliseconds: 600),
//       child: Container(
//         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Dr. MediCare AI',
//                     style: GoogleFonts.poppins(
//                       fontSize: constraints.maxWidth * 0.065,
//                       fontWeight: FontWeight.w700,
//                       color: const Color(0xFF009798),
//                     )),
//                 Text(
//                   'Your Personal Medical Assistant',
//                   style: GoogleFonts.poppins(
//                     fontSize: constraints.maxWidth * 0.032,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//             Consumer<AIChatController>(
//               builder: (context, controller, _) => Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: constraints.maxWidth * 0.04,
//                   vertical: constraints.maxHeight * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: controller.isStreaming
//                       ? LinearGradient(
//                           colors: [Colors.red, Colors.redAccent.shade100])
//                       : LinearGradient(
//                           colors: [Colors.teal, Colors.tealAccent.shade200]),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       controller.isStreaming
//                           ? Icons.psychology
//                           : Icons.medical_services,
//                       color: Colors.white,
//                       size: constraints.maxWidth * 0.04,
//                     ),
//                     SizedBox(width: constraints.maxWidth * 0.02),
//                     Text(
//                       controller.isStreaming ? 'Analyzing...' : 'Ready',
//                       style: GoogleFonts.poppins(
//                         fontSize: constraints.maxWidth * 0.034,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Main chat area with medical-themed styling
//   Widget _buildChatArea(BuildContext context, BoxConstraints constraints) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFF009798).withOpacity(0.15),
//           width: 1.5,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: Consumer<AIChatController>(
//           builder: (context, controller, _) {
//             if (controller.messages.isEmpty && !controller.isStreaming) {
//               return _buildWelcomeScreen(context, constraints);
//             }

//             return ListView.builder(
//               controller: controller.scrollController,
//               padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//               itemCount: controller.messages.length +
//                   (controller.isStreaming ? 1 : 0) +
//                   (controller.errorMessage.isNotEmpty ? 1 : 0),
//               itemBuilder: (context, index) {
//                 // Show error message
//                 if (controller.errorMessage.isNotEmpty && index == 0) {
//                   return _buildErrorBubble(
//                       context, constraints, controller.errorMessage);
//                 }

//                 // Adjust index for error message
//                 int messageIndex =
//                     controller.errorMessage.isNotEmpty ? index - 1 : index;

//                 // Show streaming response
//                 if (messageIndex == controller.messages.length &&
//                     controller.isStreaming) {
//                   return _buildStreamingBubble(
//                       context, constraints, controller.streamedText);
//                 }

//                 // Show regular message
//                 if (messageIndex < controller.messages.length) {
//                   final msg = controller.messages[messageIndex];
//                   return _buildMessageBubble(
//                       context, constraints, msg, messageIndex);
//                 }

//                 return const SizedBox.shrink();
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Welcome screen for new users
//   Widget _buildWelcomeScreen(BuildContext context, BoxConstraints constraints) {
//     return FadeIn(
//       duration: const Duration(milliseconds: 800),
//       child: SingleChildScrollView(
//         //! Pehla: Column direct use ho raha tha, overflow error aa raha tha (51 pixels bottom se)
//         //! Ab: Column ko SingleChildScrollView ma wrap kia
//         //! Faida: Content jo screen se bahar ja raha tha ab scrollable ho gaya, overflow error fix ho gaya
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.medical_services_rounded,
//               size: constraints.maxWidth * 0.2,
//               color: const Color(0xFF009798).withOpacity(0.7),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.03),
//             Text(
//               'Welcome to Dr. MediCare AI',
//               style: GoogleFonts.poppins(
//                 fontSize: constraints.maxWidth * 0.055,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF009798),
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: constraints.maxHeight * 0.02),
//             Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08),
//               child: Text(
//                 'I\'m your personal medical assistant with complete MBBS training. Ask me about symptoms, medications, treatments, or upload medical images for analysis.',
//                 style: GoogleFonts.poppins(
//                   fontSize: constraints.maxWidth * 0.038,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.04),
//             _buildQuickActionButtons(context, constraints),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Quick action buttons for common medical queries
//   Widget _buildQuickActionButtons(
//       BuildContext context, BoxConstraints constraints) {
//     final quickActions = [
//       {
//         'icon': Icons.coronavirus,
//         'text': 'Symptoms Check',
//         'query': 'I have some symptoms I want to discuss'
//       },
//       {
//         'icon': Icons.medical_information_outlined,

//         ///!
//         //!  reminder :  have to change dekhni ha konsi zayda achi lagti ha  koi mila gi to lgani  ha warna oky ha
//         'text': 'Medicine Info',
//         'query': 'Tell me about a medication'
//       },
//       {
//         'icon': Icons.camera_alt,
//         'text': 'Image Analysis',
//         'query': 'analyze_image'
//       },
//     ];

//     return Wrap(
//       spacing: constraints.maxWidth * 0.02,
//       runSpacing: constraints.maxHeight * 0.015,
//       children: quickActions.map((action) {
//         return GestureDetector(
//           onTap: () {
//             final controller =
//                 Provider.of<AIChatController>(context, listen: false);
//             if (action['query'] == 'analyze_image') {
//               controller.pickAndAnalyzeImage();
//             } else {
//               controller.sendMessage(action['query'] as String);
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: constraints.maxWidth * 0.04,
//               vertical: constraints.maxHeight * 0.015,
//             ),
//             decoration: BoxDecoration(
//               color: const Color(0xFF009798).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                 color: const Color(0xFF009798).withOpacity(0.3),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   action['icon'] as IconData,
//                   color: const Color(0xFF009798),
//                   size: constraints.maxWidth * 0.06,
//                 ),
//                 SizedBox(height: constraints.maxHeight * 0.01),
//                 Text(
//                   action['text'] as String,
//                   style: GoogleFonts.poppins(
//                     fontSize: constraints.maxWidth * 0.03,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFF009798),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   /// Individual message bubble with medical styling
//   Widget _buildMessageBubble(BuildContext context, BoxConstraints constraints,
//       ChatMessage msg, int index) {
//     return FadeInUp(
//       duration: Duration(milliseconds: 300 + (index * 50)),
//       child: Align(
//         alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
//         child: Container(
//           margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.008),
//           padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//           constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
//           decoration: BoxDecoration(
//             color: msg.isUser
//                 ? const Color(0xFF009798).withOpacity(0.15)
//                 : Colors.grey.shade50,
//             borderRadius: BorderRadius.only(
//               topLeft: const Radius.circular(20),
//               topRight: const Radius.circular(20),
//               bottomLeft: msg.isUser
//                   ? const Radius.circular(20)
//                   : const Radius.circular(5),
//               bottomRight: msg.isUser
//                   ? const Radius.circular(5)
//                   : const Radius.circular(20),
//             ),
//             border: Border.all(
//               color: msg.isUser
//                   ? const Color(0xFF009798).withOpacity(0.3)
//                   : Colors.grey.withOpacity(0.2),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (msg.imagePath != null)
//                 Row(
//                   children: [
//                     Container(
//                       margin:
//                           EdgeInsets.only(bottom: constraints.maxHeight * 0.01),
//                       height: constraints.maxHeight * 0.15,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: FileImage(File(msg.imagePath!)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               SelectableText(
//                 msg.content,
//                 style: GoogleFonts.poppins(
//                   color: Colors.black87,
//                   fontSize: constraints.maxWidth * 0.036,
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: constraints.maxHeight * 0.005),
//               Text(
//                 msg.isUser ? 'You' : 'Dr. MediCare AI',
//                 style: GoogleFonts.poppins(
//                   fontSize: constraints.maxWidth * 0.028,
//                   color: Colors.grey[500],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Streaming response bubble with typing animation
//   Widget _buildStreamingBubble(
//       BuildContext context, BoxConstraints constraints, String streamedText) {
//     return FadeInUp(
//       duration: const Duration(milliseconds: 300),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Container(
//           padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//           margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.008),
//           constraints: BoxConstraints(maxWidth: constraints.maxWidth * 0.8),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//               bottomRight: Radius.circular(20),
//               bottomLeft: Radius.circular(5),
//             ),
//             border: Border.all(color: const Color(0xFF009798).withOpacity(0.2)),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (streamedText.isNotEmpty)
//                 SelectableText(
//                   streamedText,
//                   style: GoogleFonts.poppins(
//                     color: Colors.black87,
//                     fontSize: constraints.maxWidth * 0.036,
//                     height: 1.5,
//                   ),
//                 ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _typingDot(constraints),
//                   _typingDot(constraints, delay: 200),
//                   _typingDot(constraints, delay: 400),
//                   SizedBox(width: constraints.maxWidth * 0.02),
//                   Text(
//                     'Dr. MediCare is typing...',
//                     style: GoogleFonts.poppins(
//                       fontSize: constraints.maxWidth * 0.028,
//                       color: Colors.grey[500],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Error message bubble
//   Widget _buildErrorBubble(
//       BuildContext context, BoxConstraints constraints, String error) {
//     return FadeInUp(
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
//         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.red.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.red.withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.error,
//                 color: Colors.red, size: constraints.maxWidth * 0.05),
//             SizedBox(width: constraints.maxWidth * 0.03),
//             Expanded(
//               child: Text(
//                 error,
//                 style: GoogleFonts.poppins(
//                   color: Colors.red[700],
//                   fontSize: constraints.maxWidth * 0.034,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Provider.of<AIChatController>(context, listen: false)
//                   .clearError(),
//               child: Icon(Icons.close,
//                   color: Colors.red, size: constraints.maxWidth * 0.04),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Animated typing dot
//   Widget _typingDot(BoxConstraints constraints, {int delay = 0}) {
//     return Bounce(
//       duration: const Duration(milliseconds: 600),
//       delay: Duration(milliseconds: delay),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.005),
//         width: constraints.maxWidth * 0.015,
//         height: constraints.maxWidth * 0.015,
//         decoration: const BoxDecoration(
//           color: Color(0xFF009798),
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }

//   /// Enhanced input area with medical features
//   Widget _buildInputArea(BuildContext context, BoxConstraints constraints) {
//     return Container(
//       margin: EdgeInsets.all(constraints.maxWidth * 0.03),
//       padding: EdgeInsets.symmetric(
//         horizontal: constraints.maxWidth * 0.02,
//         vertical: constraints.maxHeight * 0.008,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFF009798).withOpacity(0.2),
//           width: 1.5,
//         ),
//       ),
//       child: Consumer<AIChatController>(
//         builder: (context, controller, _) => Row(
//           children: [
//             // Image picker button
//             GestureDetector(
//               onTap: controller.isStreaming
//                   ? null
//                   : () => controller.pickAndAnalyzeImage(),
//               child: Container(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
//                 decoration: BoxDecoration(
//                   color: controller.isStreaming
//                       ? Colors.grey.withOpacity(0.3)
//                       : const Color(0xFF009798).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: controller.isStreaming
//                       ? Colors.grey
//                       : const Color(0xFF009798),
//                   size: constraints.maxWidth * 0.05,
//                 ),
//               ),
//             ),
//             SizedBox(width: constraints.maxWidth * 0.03),

//             // Text input field
//             Expanded(
//               child: TextField(
//                 controller: controller.textController,
//                 style:
//                     GoogleFonts.poppins(fontSize: constraints.maxWidth * 0.036),
//                 decoration: InputDecoration(
//                   hintText: controller.isStreaming
//                       ? 'Dr. MediCare is responding...'
//                       : 'Describe your symptoms or ask about medications...',
//                   hintStyle: GoogleFonts.poppins(
//                     color: Colors.grey[500],
//                     fontSize: constraints.maxWidth * 0.034,
//                   ),
//                   border: InputBorder.none,
//                 ),
//                 enabled: !controller.isStreaming,
//                 maxLines: null,
//                 textCapitalization: TextCapitalization.sentences,
//                 onSubmitted: (text) => _sendMessage(context, text),
//               ),
//             ),

//             // Send button
//             GestureDetector(
//               onTap: controller.isStreaming
//                   ? null
//                   : () => _sendMessage(context, controller.textController.text),
//               child: Container(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
//                 decoration: BoxDecoration(
//                   color: controller.isStreaming
//                       ? Colors.grey
//                       : const Color(0xFF009798),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: (controller.isStreaming
//                               ? Colors.grey
//                               : const Color(0xFF009798))
//                           .withOpacity(0.3),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   controller.isStreaming ? Icons.hourglass_empty : Icons.send,
//                   color: Colors.white,
//                   size: constraints.maxWidth * 0.05,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Send message handler
//   void _sendMessage(BuildContext context, String text) {
//     final message = text.trim();
//     final controller = Provider.of<AIChatController>(context, listen: false);
//     if (message.isNotEmpty && !controller.isStreaming) {
//       controller.sendMessage(message);
//       controller.textController.clear();
//     }
//   }
// }

// import 'dart:io';

// import 'package:animate_do/animate_do.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:laza/Features/ai_bot_module/ai_repo.dart';
// import 'package:laza/Features/ai_bot_module/chat_message.dart';
// import 'package:laza/Resources/Paths/AssetsPath.dart';
// import 'package:laza/Resources/Paths/imports.dart';
// import 'package:particles_fly/particles_fly.dart';
// import 'package:provider/provider.dart';

// /// Main chat interface with medical theme
// /// Beautiful UI with teal gradient and smooth animations
// class AIChatView extends StatelessWidget {
//   const AIChatView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF009798), // Primary teal
//               Colors.white, // Clean white center
//               Color(0xFFF5F6F5), // Light background
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return Stack(
//               clipBehavior: Clip.none, // Ensure particles aren't clipped
//               children: [
//                 SafeArea(
//                   child: Column(
//                     children: [
//                       _buildMedicalHeader(context, constraints),
//                       Expanded(child: _buildChatArea(context, constraints)),
//                       _buildInputArea(context, constraints),
//                     ],
//                   ),
//                 ),
//                 // Animated background particles for medical feel
//                 //! Pehla: ParticlesFly Positioned ma tha lekin z-index issue ki wajah se shayad peeche chhup raha tha
//                 //! Ab: ParticlesFly ko Stack k pehle child banaya aur clipBehavior: Clip.none set kia taake wo clearly visible ho
//                 //! Faida: Particles ab UI k ooper render honge, hidden hone ka chance khatam ho gaya
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   height: constraints.maxHeight *
//                       0.5, // Increased height for visibility
//                   child: ParticlesFly(
//                     height: constraints.maxHeight * 0.5,
//                     width: constraints.maxWidth,
//                     //! Pehla: numberOfParticles 10 tha aur particleColor opacity 0.1 thi, jo bohat faint thi
//                     //! Ab: numberOfParticles 20 kia aur opacity 0.5 ki taake animation zyada clear dikhe
//                     //! Faida: Particles zyada visible honge, lekin performance abhi bhi stable rahegi
//                     numberOfParticles: 20,
//                     speedOfParticles: 0.60,
//                     connectDots: false,
//                     particleColor: const Color(0xFF009798).withOpacity(0.5),
//                     onTapAnimation: false,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Professional medical header with status indicator
//   Widget _buildMedicalHeader(BuildContext context, BoxConstraints constraints) {
//     return FadeInDown(
//       duration: const Duration(milliseconds: 600),
//       child: Container(
//         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Dr. MediCare AI',
//                   style: GoogleFonts.poppins(
//                     fontSize: constraints.maxWidth * 0.065,
//                     fontWeight: FontWeight.w700,
//                     color: const Color(0xFF009798),
//                   ),
//                 ),
//                 Text(
//                   'Your Personal Medical Assistant',
//                   style: GoogleFonts.poppins(
//                     fontSize: constraints.maxWidth * 0.032,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//               ],
//             ),
//             Consumer<AIChatController>(
//               builder: (context, controller, _) => Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: constraints.maxWidth * 0.04,
//                   vertical: constraints.maxHeight * 0.01,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: controller.isStreaming
//                       ? LinearGradient(
//                           colors: [Colors.red, Colors.redAccent.shade100])
//                       : LinearGradient(
//                           colors: [Colors.teal, Colors.tealAccent.shade200]),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       controller.isStreaming
//                           ? Icons.psychology
//                           : Icons.medical_services,
//                       color: Colors.white,
//                       size: constraints.maxWidth * 0.04,
//                     ),
//                     SizedBox(width: constraints.maxWidth * 0.02),
//                     Text(
//                       controller.isStreaming ? 'Analyzing...' : 'Ready',
//                       style: GoogleFonts.poppins(
//                         fontSize: constraints.maxWidth * 0.034,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Main chat area with medical-themed styling
//   Widget _buildChatArea(BuildContext context, BoxConstraints constraints) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.95),
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 15,
//             offset: const Offset(0, 5),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFF009798).withOpacity(0.15),
//           width: 1.5,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: Consumer<AIChatController>(
//           builder: (context, controller, _) {
//             // Scroll to bottom when new messages or streaming text changes
//             //! Pehla: ListView auto-scroll nahi kar raha tha, naye messages shayad screen se bahar reh jate thay
//             //! Ab: scrollToBottom method add kia taake naye messages hamesha visible hon
//             //! Faida: User ko latest response dekhne ke liye manually scroll nahi karna parhega
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               if (controller.scrollController.hasClients) {
//                 controller.scrollController.animateTo(
//                   controller.scrollController.position.maxScrollExtent,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeOut,
//                 );
//               }
//             });

//             if (controller.messages.isEmpty && !controller.isStreaming) {
//               return _buildWelcomeScreen(context, constraints);
//             }

//             return Container(
//               //! Pehla: Chat area ka koi debug border nahi tha
//               //! Ab: Temporary green border add kia taake chat area ka position aur size confirm ho
//               //! Faida: Debugging ma madad milti hai, confirm hota hai ke chat area sahi jagah render ho raha hai
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     color: Colors.green.withOpacity(0.5)), // Debug border
//               ),
//               child: ListView.builder(
//                 controller: controller.scrollController,
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//                 itemCount: controller.messages.length +
//                     (controller.isStreaming ? 1 : 0) +
//                     (controller.errorMessage.isNotEmpty ? 1 : 0),
//                 itemBuilder: (context, index) {
//                   // Show error message
//                   if (controller.errorMessage.isNotEmpty && index == 0) {
//                     //! Ye error message show karta hai agar koi issue ho (e.g., API error)
//                     return _buildErrorBubble(
//                         context, constraints, controller.errorMessage);
//                   }

//                   // Adjust index for error message
//                   int messageIndex =
//                       controller.errorMessage.isNotEmpty ? index - 1 : index;

//                   // Show streaming response
//                   if (messageIndex == controller.messages.length &&
//                       controller.isStreaming) {
//                     //! Ye streaming response show karta hai jab AI jawab generate kar raha hota hai
//                     return _buildStreamingBubble(
//                         context, constraints, controller.streamedText);
//                   }

//                   // Show regular message
//                   if (messageIndex < controller.messages.length) {
//                     final msg = controller.messages[messageIndex];
//                     //! Ye regular messages (user aur AI ke) show karta hai
//                     return _buildMessageBubble(
//                         context, constraints, msg, messageIndex);
//                   }

//                   return const SizedBox.shrink();
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// Welcome screen for new users
//   Widget _buildWelcomeScreen(BuildContext context, BoxConstraints constraints) {
//     return FadeIn(
//       duration: const Duration(milliseconds: 800),
//       child: SingleChildScrollView(
//         //! Pehla: Column direct use ho raha tha, overflow error aa raha tha (51 pixels bottom se)
//         //! Ab: Column ko SingleChildScrollView ma wrap kia
//         //! Faida: Content jo screen se bahar ja raha tha ab scrollable ho gaya, overflow error fix ho gaya
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 10),
//             CircleAvatar(
//               backgroundColor: Colors.teal.withOpacity(.6),
//               radius: 60,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: Image.asset(
//                     PngImages.doctor,
//                     filterQuality: FilterQuality.high,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.03),
//             Text(
//               'Welcome to Dr. MediCare AI',
//               style: GoogleFonts.poppins(
//                 fontSize: constraints.maxWidth * 0.055,
//                 fontWeight: FontWeight.w600,
//                 color: const Color(0xFF009798),
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: constraints.maxHeight * 0.02),
//             Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.08),
//               child: Text(
//                 'I\'m your personal medical assistant with complete MBBS training. Ask me about symptoms, medications, treatments, or upload medical images for analysis.',
//                 style: GoogleFonts.poppins(
//                   fontSize: constraints.maxWidth * 0.038,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: constraints.maxHeight * 0.04),
//             _buildQuickActionButtons(context, constraints),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Quick action buttons for common medical queries
//   Widget _buildQuickActionButtons(
//       BuildContext context, BoxConstraints constraints) {
//     final quickActions = [
//       {
//         'icon': Icons.coronavirus,
//         'text': 'Symptoms Check',
//         'query': 'I have some symptoms I want to discuss'
//       },
//       {
//         'icon': Icons.medical_information_outlined,
//         //! Pehla: Icon tha Icons.medication
//         //! Ab: Icons.medical_information_outlined use kia
//         //! Faida: Naya icon medical information ke context ko zyada suit karta hai, UI clarity barhti hai
//         'text': 'Medicine Info',
//         'query': 'Tell me about a medication'
//       },
//       {
//         'icon': Icons.camera_alt,
//         'text': 'Image Analysis',
//         'query': 'analyze_image'
//       },
//     ];

//     return Wrap(
//       spacing: constraints.maxWidth * 0.02,
//       runSpacing: constraints.maxHeight * 0.015,
//       children: quickActions.map((action) {
//         return GestureDetector(
//           onTap: () {
//             final controller =
//                 Provider.of<AIChatController>(context, listen: false);
//             if (action['query'] == 'analyze_image') {
//               controller.pickAndAnalyzeImage();
//             } else {
//               controller.sendMessage(action['query'] as String);
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: constraints.maxWidth * 0.04,
//               vertical: constraints.maxHeight * 0.015,
//             ),
//             decoration: BoxDecoration(
//               color: const Color(0xFF009798).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(
//                 color: const Color(0xFF009798).withOpacity(0.3),
//               ),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   action['icon'] as IconData,
//                   color: const Color(0xFF009798),
//                   size: constraints.maxWidth * 0.06,
//                 ),
//                 SizedBox(height: constraints.maxHeight * 0.01),
//                 Text(
//                   action['text'] as String,
//                   style: GoogleFonts.poppins(
//                     fontSize: constraints.maxWidth * 0.03,
//                     fontWeight: FontWeight.w500,
//                     color: const Color(0xFF009798),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   /// Individual message bubble with medical styling
//   Widget _buildMessageBubble(BuildContext context, BoxConstraints constraints,
//       ChatMessage msg, int index) {
//     return FadeInUp(
//       duration: Duration(milliseconds: 300 + (index * 50)),
//       child: Align(
//         alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
//         child: Row(
//           mainAxisAlignment:
//               msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Show avatar only for AI messages
//             if (!msg.isUser)
//               //! Pehla: CircleAvatar ka radius constraints.maxWidth * 0.08 tha, jo bada tha
//               //! Ab: Radius ko constraints.maxWidth * 0.05 kia taake avatar chota ho
//               //! Faida: UI zyada compact aur balanced dikhega
//               Padding(
//                 padding: EdgeInsets.only(right: constraints.maxWidth * 0.02),
//                 child: CircleAvatar(
//                   radius: constraints.maxWidth * 0.05, // Smaller avatar
//                   backgroundImage: const AssetImage(PngImages.doctor),
//                   backgroundColor: Colors.white,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: const Color(0xFF009798),
//                         width: 1.5, // Reduced border width for smaller avatar
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             Flexible(
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                     vertical: constraints.maxHeight * 0.008),
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//                 constraints: BoxConstraints(
//                     maxWidth: constraints.maxWidth *
//                         0.75), // Adjusted for smaller avatar
//                 decoration: BoxDecoration(
//                   color: msg.isUser
//                       ? const Color(0xFF009798).withOpacity(0.15)
//                       : Colors.grey.shade50,
//                   borderRadius: BorderRadius.only(
//                     topLeft: const Radius.circular(20),
//                     topRight: const Radius.circular(20),
//                     bottomLeft: msg.isUser
//                         ? const Radius.circular(20)
//                         : const Radius.circular(5),
//                     bottomRight: msg.isUser
//                         ? const Radius.circular(5)
//                         : const Radius.circular(20),
//                   ),
//                   border: Border.all(
//                     color: msg.isUser
//                         ? const Color(0xFF009798).withOpacity(0.3)
//                         : Colors.grey.withOpacity(0.2),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.05),
//                       blurRadius: 5,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (msg.imagePath != null)
//                       //! Pehla: Image upload ke baad AI response ek dafa dikhta tha phir gayab ho jata tha, white container reh jata tha
//                       //! Ab: Image rendering ko Builder se wrap kia aur error handling add kia, AIChatController ma notifyListeners ensure kia
//                       //! Faida: Image upload ke baad message stable rahega, hang nahi hoga
//                       Builder(
//                         builder: (context) {
//                           try {
//                             return Row(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.only(
//                                       bottom: constraints.maxHeight * 0.01),
//                                   height: constraints.maxHeight * 0.15,
//                                   width: constraints.maxWidth *
//                                       0.6, // Reduced width to prevent overflow
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     image: DecorationImage(
//                                       image: FileImage(File(msg.imagePath!)),
//                                       fit: BoxFit.cover,
//                                       onError: (exception, stackTrace) {
//                                         print('Image load error: $exception');
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             );
//                           } catch (e) {
//                             return Container(
//                               padding:
//                                   EdgeInsets.all(constraints.maxWidth * 0.02),
//                               color: Colors.red.withOpacity(0.1),
//                               child: Text(
//                                 'Failed to load image: $e',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.red[700],
//                                   fontSize: constraints.maxWidth * 0.034,
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     SelectableText(
//                       msg.content,
//                       style: GoogleFonts.poppins(
//                         color: Colors.black87,
//                         fontSize: constraints.maxWidth * 0.036,
//                         height: 1.5,
//                       ),
//                     ),
//                     SizedBox(height: constraints.maxHeight * 0.005),
//                     Text(
//                       msg.isUser ? 'You' : 'Dr. MediCare AI',
//                       style: GoogleFonts.poppins(
//                         fontSize: constraints.maxWidth * 0.028,
//                         color: Colors.grey[500],
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Streaming response bubble with typing animation
//   Widget _buildStreamingBubble(
//       BuildContext context, BoxConstraints constraints, String streamedText) {
//     return FadeInUp(
//       duration: const Duration(milliseconds: 300),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Show avatar for streaming AI response
//             //! Pehla: CircleAvatar ka radius constraints.maxWidth * 0.08 tha, jo bada tha
//             //! Ab: Radius ko constraints.maxWidth * 0.05 kia taake avatar chota ho
//             //! Faida: UI zyada compact aur balanced dikhega
//             Padding(
//               padding: EdgeInsets.only(right: constraints.maxWidth * 0.02),
//               child: CircleAvatar(
//                 radius: constraints.maxWidth * 0.05, // Smaller avatar
//                 backgroundImage: const AssetImage(PngImages.doctor),
//                 backgroundColor: Colors.white,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: const Color(0xFF009798),
//                       width: 1.5, // Reduced border width for smaller avatar
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Flexible(
//               child: Container(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//                 margin: EdgeInsets.symmetric(
//                     vertical: constraints.maxHeight * 0.008),
//                 constraints: BoxConstraints(
//                     maxWidth: constraints.maxWidth *
//                         0.75), // Adjusted for smaller avatar
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                     bottomRight: Radius.circular(20),
//                     bottomLeft: Radius.circular(5),
//                   ),
//                   border: Border.all(
//                       color: const Color(0xFF009798).withOpacity(0.2)),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (streamedText.isNotEmpty)
//                       SelectableText(
//                         streamedText,
//                         style: GoogleFonts.poppins(
//                           color: Colors.black87,
//                           fontSize: constraints.maxWidth * 0.036,
//                           height: 1.5,
//                         ),
//                       ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         _typingDot(constraints),
//                         _typingDot(constraints, delay: 200),
//                         _typingDot(constraints, delay: 400),
//                         SizedBox(width: constraints.maxWidth * 0.02),
//                         Text(
//                           'Dr. MediCare is typing...',
//                           style: GoogleFonts.poppins(
//                             fontSize: constraints.maxWidth * 0.028,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Error message bubble
//   Widget _buildErrorBubble(
//       BuildContext context, BoxConstraints constraints, String error) {
//     return FadeInUp(
//       duration: const Duration(milliseconds: 300),
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.01),
//         padding: EdgeInsets.all(constraints.maxWidth * 0.04),
//         decoration: BoxDecoration(
//           color: Colors.red.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(15),
//           border: Border.all(color: Colors.red.withOpacity(0.3)),
//         ),
//         child: Row(
//           children: [
//             Icon(Icons.error,
//                 color: Colors.red, size: constraints.maxWidth * 0.05),
//             SizedBox(width: constraints.maxWidth * 0.03),
//             Expanded(
//               child: Text(
//                 error,
//                 style: GoogleFonts.poppins(
//                   color: Colors.red[700],
//                   fontSize: constraints.maxWidth * 0.034,
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => Provider.of<AIChatController>(context, listen: false)
//                   .clearError(),
//               child: Icon(Icons.close,
//                   color: Colors.red, size: constraints.maxWidth * 0.04),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Animated typing dot
//   Widget _typingDot(BoxConstraints constraints, {int delay = 0}) {
//     return Bounce(
//       duration: const Duration(milliseconds: 600),
//       delay: Duration(milliseconds: delay),
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.005),
//         width: constraints.maxWidth * 0.015,
//         height: constraints.maxWidth * 0.015,
//         decoration: const BoxDecoration(
//           color: Color(0xFF009798),
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }

//   /// Enhanced input area with medical features
//   Widget _buildInputArea(BuildContext context, BoxConstraints constraints) {
//     return Container(
//       margin: EdgeInsets.all(constraints.maxWidth * 0.03),
//       padding: EdgeInsets.symmetric(
//         horizontal: constraints.maxWidth * 0.02,
//         vertical: constraints.maxHeight * 0.008,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -2),
//           ),
//         ],
//         border: Border.all(
//           color: const Color(0xFF009798).withOpacity(0.2),
//           width: 1.5,
//         ),
//       ),
//       child: Consumer<AIChatController>(
//         builder: (context, controller, _) => Row(
//           children: [
//             // Image picker button
//             GestureDetector(
//               onTap: controller.isStreaming
//                   ? null
//                   : () => controller.pickAndAnalyzeImage(),
//               child: Container(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
//                 decoration: BoxDecoration(
//                   color: controller.isStreaming
//                       ? Colors.grey.withOpacity(0.3)
//                       : const Color(0xFF009798).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: controller.isStreaming
//                       ? Colors.grey
//                       : const Color(0xFF009798),
//                   size: constraints.maxWidth * 0.05,
//                 ),
//               ),
//             ),
//             SizedBox(width: constraints.maxWidth * 0.03),

//             // Text input field
//             Expanded(
//               child: TextField(
//                 controller: controller.textController,
//                 style:
//                     GoogleFonts.poppins(fontSize: constraints.maxWidth * 0.036),
//                 decoration: InputDecoration(
//                   hintText: controller.isStreaming
//                       ? 'Dr. MediCare is responding...'
//                       : 'Describe your symptoms or ask about medications...',
//                   hintStyle: GoogleFonts.poppins(
//                     color: Colors.grey[500],
//                     fontSize: constraints.maxWidth * 0.034,
//                   ),
//                   border: InputBorder.none,
//                 ),
//                 enabled: !controller.isStreaming,
//                 maxLines: null,
//                 textCapitalization: TextCapitalization.sentences,
//                 onSubmitted: (text) => _sendMessage(context, text),
//               ),
//             ),

//             // Send button
//             GestureDetector(
//               onTap: controller.isStreaming
//                   ? null
//                   : () => _sendMessage(context, controller.textController.text),
//               child: Container(
//                 padding: EdgeInsets.all(constraints.maxWidth * 0.025),
//                 decoration: BoxDecoration(
//                   color: controller.isStreaming
//                       ? Colors.grey
//                       : const Color(0xFF009798),
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: (controller.isStreaming
//                               ? Colors.grey
//                               : const Color(0xFF009798))
//                           .withOpacity(0.3),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   controller.isStreaming ? Icons.hourglass_empty : Icons.send,
//                   color: Colors.white,
//                   size: constraints.maxWidth * 0.05,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Send message handler
//   void _sendMessage(BuildContext context, String text) {
//     final message = text.trim();
//     final controller = Provider.of<AIChatController>(context, listen: false);
//     if (message.isNotEmpty && !controller.isStreaming) {
//       controller.sendMessage(message);
//       controller.textController.clear();
//     }
//   }
// }




import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/ai_bot_module/ai_repo.dart';
import 'package:laza/Features/ai_bot_module/chat_message.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
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
    final screenSize = getScreenSize(context);
    // Define responsive breakpoints
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;
    final isMobile = screenSize.width < 600;

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
                      _buildMedicalHeader(context, constraints, screenSize),
                      Expanded(child: _buildChatArea(context, constraints, screenSize)),
                      _buildInputArea(context, constraints, screenSize),
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
                  height: constraints.maxHeight * 0.5,
                  child: ParticlesFly(
                    height: constraints.maxHeight * 0.5,
                    width: constraints.maxWidth,
                    //! Pehla: numberOfParticles 20 tha, web ke liye thodi zyada particles chahiye
                    //! Ab: Desktop ke liye numberOfParticles 30 aur speed 0.7 ki, mobile/tablet ke liye 20 aur 0.6
                    //! Faida: Web par animation zyada vibrant dikhegi, mobile par performance stable rahegi
                    numberOfParticles: isDesktop ? 30 : 20,
                    speedOfParticles: isDesktop ? 0.7 : 0.6,
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
  Widget _buildMedicalHeader(BuildContext context, BoxConstraints constraints, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Container(
        padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. MediCare AI',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 32 : isTablet ? 28 : constraints.maxWidth * 0.065,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF009798),
                  ),
                ),
                Text(
                  'Your Personal Medical Assistant',
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 16 : isTablet ? 14 : constraints.maxWidth * 0.032,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Consumer<AIChatController>(
              builder: (context, controller, _) => Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 20 : isTablet ? 16 : constraints.maxWidth * 0.04,
                  vertical: isDesktop ? 12 : isTablet ? 10 : constraints.maxHeight * 0.01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: controller.isStreaming
                      ? LinearGradient(colors: [Colors.red, Colors.redAccent.shade100])
                      : LinearGradient(colors: [Colors.teal, Colors.tealAccent.shade200]),
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
                      controller.isStreaming ? Icons.psychology : Icons.medical_services,
                      color: Colors.white,
                      size: isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.04,
                    ),
                    SizedBox(width: isDesktop ? 12 : isTablet ? 10 : constraints.maxWidth * 0.02),
                    Text(
                      controller.isStreaming ? 'Analyzing...' : 'Ready',
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.034,
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
  Widget _buildChatArea(BuildContext context, BoxConstraints constraints, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isDesktop ? 32 : isTablet ? 24 : constraints.maxWidth * 0.03),
        width: isDesktop ? screenSize.width * 0.7 : isTablet ? screenSize.width * 0.85 : null, // Constrain width on web
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
                return _buildWelcomeScreen(context, constraints, screenSize);
              }

              return Container(
                //! Pehla: Chat area ka koi debug border nahi tha
                //! Ab: Temporary green border add kia taake chat area ka position aur size confirm ho
                //! Faida: Debugging ma madad milti hai, confirm hota hai ke chat area sahi jagah render ho raha hai
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green.withOpacity(0.5)), // Debug border
                ),
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.all(isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.04),
                  itemCount: controller.messages.length +
                      (controller.isStreaming ? 1 : 0) +
                      (controller.errorMessage.isNotEmpty ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show error message
                    if (controller.errorMessage.isNotEmpty && index == 0) {
                      //! Ye error message show karta hai agar koi issue ho (e.g., API error)
                      return _buildErrorBubble(context, constraints, controller.errorMessage, screenSize);
                    }

                    // Adjust index for error message
                    int messageIndex = controller.errorMessage.isNotEmpty ? index - 1 : index;

                    // Show streaming response
                    if (messageIndex == controller.messages.length && controller.isStreaming) {
                      //! Ye streaming response show karta hai jab AI jawab generate kar raha hota hai
                      return _buildStreamingBubble(context, constraints, controller.streamedText, screenSize);
                    }

                    // Show regular message
                    if (messageIndex < controller.messages.length) {
                      final msg = controller.messages[messageIndex];
                      //! Ye regular messages (user aur AI ke) show karta hai
                      return _buildMessageBubble(context, constraints, msg, messageIndex, screenSize);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Welcome screen for new users
  Widget _buildWelcomeScreen(BuildContext context, BoxConstraints constraints, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return FadeIn(
      duration: const Duration(milliseconds: 800),
      child: SingleChildScrollView(
        //! Pehla: Column direct use ho raha tha, overflow error aa raha tha (51 pixels bottom se)
        //! Ab: Column ko SingleChildScrollView ma wrap kia
        //! Faida: Content jo screen se bahar ja raha tha ab scrollable ho gaya, overflow error fix ho gaya
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: isDesktop ? 20 : isTablet ? 15 : 10),
            CircleAvatar(
              backgroundColor: Colors.teal.withOpacity(0.6),
              radius: isDesktop ? 80 : isTablet ? 70 : 60,
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
            SizedBox(height: isDesktop ? 32 : isTablet ? 24 : constraints.maxHeight * 0.03),
            Text(
              'Welcome to Dr. MediCare AI',
              style: GoogleFonts.poppins(
                fontSize: isDesktop ? 28 : isTablet ? 24 : constraints.maxWidth * 0.055,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF009798),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isDesktop ? 24 : isTablet ? 20 : constraints.maxHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 48 : isTablet ? 40 : constraints.maxWidth * 0.08),
              child: Text(
                'I\'m your personal medical assistant with complete MBBS training. Ask me about symptoms, medications, treatments, or upload medical images for analysis.',
                style: GoogleFonts.poppins(
                  fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.038,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: isDesktop ? 40 : isTablet ? 32 : constraints.maxHeight * 0.04),
            _buildQuickActionButtons(context, constraints, screenSize),
          ],
        ),
      ),
    );
  }

  /// Quick action buttons for common medical queries
  Widget _buildQuickActionButtons(BuildContext context, BoxConstraints constraints, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

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
      spacing: isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.02,
      runSpacing: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.015,
      children: quickActions.map((action) {
        return GestureDetector(
          onTap: () {
            final controller = Provider.of<AIChatController>(context, listen: false);
            if (action['query'] == 'analyze_image') {
              controller.pickAndAnalyzeImage();
            } else {
              controller.sendMessage(action['query'] as String);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.04,
              vertical: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.015,
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
                  size: isDesktop ? 32 : isTablet ? 28 : constraints.maxWidth * 0.06,
                ),
                SizedBox(height: isDesktop ? 12 : isTablet ? 10 : constraints.maxHeight * 0.01),
                Text(
                  action['text'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: isDesktop ? 16 : isTablet ? 14 : constraints.maxWidth * 0.03,
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
  Widget _buildMessageBubble(BuildContext context, BoxConstraints constraints, ChatMessage msg, int index, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return FadeInUp(
      duration: Duration(milliseconds: 300 + (index * 50)),
      child: Align(
        alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show avatar only for AI messages
            if (!msg.isUser)
              //! Pehla: CircleAvatar ka radius constraints.maxWidth * 0.08 tha, jo bada tha
              //! Ab: Radius mobile ke liye 0.05 aur desktop/tablet ke liye screenSize.width * 0.035 kia
              //! Faida: UI zyada compact aur responsive dikhega
              Padding(
                padding: EdgeInsets.only(right: isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.02),
                child: CircleAvatar(
                  radius: isDesktop ? screenSize.width * 0.035 : isTablet ? screenSize.width * 0.04 : constraints.maxWidth * 0.05,
                  backgroundImage: const AssetImage(PngImages.doctor),
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF009798),
                        width: isDesktop || isTablet ? 2 : 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            Flexible(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.008),
                padding: EdgeInsets.all(isDesktop ? 20 : isTablet ? 16 : constraints.maxWidth * 0.04),
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? screenSize.width * 0.5 : isTablet ? screenSize.width * 0.65 : constraints.maxWidth * 0.75,
                ),
                decoration: BoxDecoration(
                  color: msg.isUser ? const Color(0xFF009798).withOpacity(0.15) : Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20),
                    topRight: const Radius.circular(20),
                    bottomLeft: msg.isUser ? const Radius.circular(20) : const Radius.circular(5),
                    bottomRight: msg.isUser ? const Radius.circular(5) : const Radius.circular(20),
                  ),
                  border: Border.all(
                    color: msg.isUser ? const Color(0xFF009798).withOpacity(0.3) : Colors.grey.withOpacity(0.2),
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
                      //! Ab: Image rendering ko Builder se wrap kia aur error handling add kia, responsive size ke liye width adjust kia
                      //! Faida: Image upload ke baad message stable rahega, web par bhi sahi dikhega
                      Builder(
                        builder: (context) {
                          try {
                            return Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.01),
                                  height: isDesktop ? 200 : isTablet ? 150 : constraints.maxHeight * 0.15,
                                  width: isDesktop ? screenSize.width * 0.4 : isTablet ? screenSize.width * 0.5 : constraints.maxWidth * 0.6,
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
                              padding: EdgeInsets.all(isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.02),
                              color: Colors.red.withOpacity(0.1),
                              child: Text(
                                'Failed to load image: $e',
                                style: GoogleFonts.poppins(
                                  color: Colors.red[700],
                                  fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.034,
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
                        fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.036,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: isDesktop ? 12 : isTablet ? 10 : constraints.maxHeight * 0.005),
                    Text(
                      msg.isUser ? 'You' : 'Dr. MediCare AI',
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop ? 16 : isTablet ? 14 : constraints.maxWidth * 0.028,
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
  Widget _buildStreamingBubble(BuildContext context, BoxConstraints constraints, String streamedText, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

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
            //! Ab: Radius mobile ke liye 0.05 aur desktop/tablet ke liye screenSize.width * 0.035 kia
            //! Faida: UI zyada compact aur responsive dikhega
            Padding(
              padding: EdgeInsets.only(right: isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.02),
              child: CircleAvatar(
                radius: isDesktop ? screenSize.width * 0.035 : isTablet ? screenSize.width * 0.04 : constraints.maxWidth * 0.05,
                backgroundImage: const AssetImage(PngImages.doctor),
                backgroundColor: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF009798),
                      width: isDesktop || isTablet ? 2 : 1.5,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                padding: EdgeInsets.all(isDesktop ? 20 : isTablet ? 16 : constraints.maxWidth * 0.04),
                margin: EdgeInsets.symmetric(vertical: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.008),
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? screenSize.width * 0.5 : isTablet ? screenSize.width * 0.65 : constraints.maxWidth * 0.75,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(5),
                  ),
                  border: Border.all(color: const Color(0xFF009798).withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (streamedText.isNotEmpty)
                      SelectableText(
                        streamedText,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.036,
                          height: 1.5,
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _typingDot(constraints, screenSize),
                        _typingDot(constraints, screenSize, delay: 200),
                        _typingDot(constraints, screenSize, delay: 400),
                        SizedBox(width: isDesktop ? 12 : isTablet ? 10 : constraints.maxWidth * 0.02),
                        Text(
                          'Dr. MediCare is typing...',
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 16 : isTablet ? 14 : constraints.maxWidth * 0.028,
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
  Widget _buildErrorBubble(BuildContext context, BoxConstraints constraints, String error, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.01),
        padding: EdgeInsets.all(isDesktop ? 20 : isTablet ? 16 : constraints.maxWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.red,
              size: isDesktop ? 28 : isTablet ? 24 : constraints.maxWidth * 0.05,
            ),
            SizedBox(width: isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.03),
            Expanded(
              child: Text(
                error,
                style: GoogleFonts.poppins(
                  color: Colors.red[700],
                  fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.034,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Provider.of<AIChatController>(context, listen: false).clearError(),
              child: Icon(
                Icons.close,
                color: Colors.red,
                size: isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.04,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Animated typing dot
  Widget _typingDot(BoxConstraints constraints, Size screenSize, {int delay = 0}) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Bounce(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: delay),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isDesktop ? 8 : isTablet ? 6 : constraints.maxWidth * 0.005),
        width: isDesktop ? 12 : isTablet ? 10 : constraints.maxWidth * 0.015,
        height: isDesktop ? 12 : isTablet ? 10 : constraints.maxWidth * 0.015,
        decoration: const BoxDecoration(
          color: Color(0xFF009798),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  /// Enhanced input area with medical features
  Widget _buildInputArea(BuildContext context, BoxConstraints constraints, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Center(
      child: Container(
        margin: EdgeInsets.all(isDesktop ? 32 : isTablet ? 24 : constraints.maxWidth * 0.03),
        width: isDesktop ? screenSize.width * 0.7 : isTablet ? screenSize.width * 0.85 : null,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : isTablet ? 20 : constraints.maxWidth * 0.02,
          vertical: isDesktop ? 16 : isTablet ? 12 : constraints.maxHeight * 0.008,
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
                onTap: controller.isStreaming ? null : () => controller.pickAndAnalyzeImage(),
                child: Container(
                  padding: EdgeInsets.all(isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.025),
                  decoration: BoxDecoration(
                    color: controller.isStreaming
                        ? Colors.grey.withOpacity(0.3)
                        : const Color(0xFF009798).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: controller.isStreaming ? Colors.grey : const Color(0xFF009798),
                    size: isDesktop ? 28 : isTablet ? 24 : constraints.maxWidth * 0.05,
                  ),
                ),
              ),
              SizedBox(width: isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.03),
              // Text input field
              Expanded(
                child: TextField(
                  controller: controller.textController,
                  style: GoogleFonts.poppins(fontSize: isDesktop ? 18 : isTablet ? 16 : constraints.maxWidth * 0.036),
                  decoration: InputDecoration(
                    hintText: controller.isStreaming
                        ? 'Dr. MediCare is responding...'
                        : 'Describe your symptoms or ask about medications...',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey[500],
                      fontSize: isDesktop ? 16 : isTablet ? 14 : constraints.maxWidth * 0.034,
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
                onTap: controller.isStreaming ? null : () => _sendMessage(context, controller.textController.text),
                child: Container(
                  padding: EdgeInsets.all(isDesktop ? 16 : isTablet ? 12 : constraints.maxWidth * 0.025),
                  decoration: BoxDecoration(
                    color: controller.isStreaming ? Colors.grey : const Color(0xFF009798),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: (controller.isStreaming ? Colors.grey : const Color(0xFF009798)).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    controller.isStreaming ? Icons.hourglass_empty : Icons.send,
                    color: Colors.white,
                    size: isDesktop ? 28 : isTablet ? 24 : constraints.maxWidth * 0.05,
                  ),
                ),
              ),
            ],
          ),
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
