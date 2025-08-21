// import 'package:flutter/material.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Paths/AssetsPath.dart';
// import 'package:laza/Veiw/auth_screens/login_screen.dart';

// class MedCareOnboardingScreen extends StatelessWidget {
//   const MedCareOnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // White background
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top Image or Illustration
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Image.asset(
//                   PngImages.doctor, // Replace with your asset
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),

//             // Text Section
//             Expanded(
//               flex: 2,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 decoration: const BoxDecoration(
//                   color: Colors.teal, // Primary color section
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Welcome to MedCare",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       "Your health is our priority. Buy Medician, track records, and get AI advice at your fingertips.",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 30),

//                     // Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.teal,
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         onPressed: () {
//                           NavigatorToReplace(context, LoginScreen());
//                         },
//                         child: const Text(
//                           "Get Started",
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
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
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/login_screen.dart';

//!Doctor Screen 

class MedCareOnboardingScreen extends StatelessWidget {
  const MedCareOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Clean white background
      body: SafeArea(
        child: Column(
          children: [
            // Top Illustration
            Expanded(

              flex: 3, //! it will take most of the screen like 70%
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  PngImages.doctor,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Bottom Section with Gradient
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF009798), Color(0xFF4DB6AC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      "Welcome to MediCare",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Your health is our priority. Buy Medician, track records, and get AI advice at your fingertips.",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    // Get Started Button
                    SizedBox(
                      width: double.infinity,
                      child: InkWell(
                        onTap: () {
                          NavigatorToReplace(context, const LoginScreen());
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
child: Center(
  child: Text(
    "Get Started",
    style: GoogleFonts.poppins(
      color: const Color(0xFF009798),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
),
                        ),
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
}
