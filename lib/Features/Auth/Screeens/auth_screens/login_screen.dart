// import 'package:laza/Firebase/Auth/login_auth.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Providers/textfeild_tick_provider.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Paths/imports.dart';

// import 'package:laza/Veiw/auth_screens/SignIn.dart';
// import 'package:laza/Veiw/auth_screens/forget_password_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:switcher_button/switcher_button.dart';
// import 'package:flutter_animate/flutter_animate.dart';

// import '../../Resources/MediaQuery/media_query.dart';
// import '../../Resources/NotificationMassage/ToastMassage.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool rememberMe = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final w = getScreenSize(context).width * (1 / 375);
//     final h = getScreenSize(context).height * (1 / 812);
//     final provider = Provider.of<TextfeildTickProvider>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.only(top: 45),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               height: getScreenSize(context).height - 137,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Header
//                   const Text('Welcome' ,style:  TextStyle(
//                     fontFamily: 'Inter',
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: MyColor.textBlack,
//                   ),)
//                       .animate()
//                       .fade(duration: 500.ms)
//                       .slideY(begin: -0.3, end: 0),

//                   SizedBox(height: 5 * h),

//                   const Text(
//                     'Please enter your data to continue',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 13,
//                       fontWeight: FontWeight.w400,
//                       color: MyColor.textLight,
//                     ),
//                   ).animate().fade(duration: 500.ms),
//                   Spacer(),
//                   // Email field
//                   Consumer<TextfeildTickProvider>(
//                     builder: (_, value, __) => MyTextField(
//                       title: 'Email Address',
//                       fieldType: 'emaillogin',
//                       SuffixIcon: value.emailloginchanger(),
//                       controller: emailController,
//                       hintText: 'Enter Email',
//                     )
//                         .animate()
//                         .fade(duration: 400.ms)
//                         .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//                   ),
//                   SizedBox(height: 20 * h),

//                   // Password field
//                   Consumer<TextfeildTickProvider>(
//                     builder: (_, __, ___) => MyTextField(
//                       title: 'Password',
//                       fieldType: 'passwordlogin',
//                       SuffixIcon: provider.passwordLoginchanger(),
//                       controller: passwordController,
//                       hintText: 'Enter Password',
//                     )
//                         .animate()
//                         .fade(duration: 400.ms)
//                         .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//                   ),
//                   SizedBox(height: 20 * h),

//                   // Forgot Password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: InkWell(
//                       onTap: () => NavigatorTo(context, const ForgetPasswordScreen()),
//                       child: const Text(
//                         'Forgot password?',
//                         style: TextStyle(
//                           fontFamily: 'Inter',
//                           fontSize: 15,
//                           fontWeight: FontWeight.w400,
//                           color: MyColor.red,
//                         ),
//                       ),
//                     ).animate().fade(duration: 500.ms).slideX(begin: 0.2, end: 0),
//                   ),
//                   SizedBox(height: 40 * h),

//                   // Remember Me Switch
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Remember me',
//                         style: TextStyle(
//                           fontFamily: 'Inter',
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: MyColor.textBlack,
//                         ),
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black87,
//                           borderRadius: BorderRadius.circular(100),
//                           border: Border.all(
//                             color: MyColor.textLight,
//                             width: 1,
//                           ),
//                         ),
//                         height: 18,
//                         width: 33,
//                         child: SwitcherButton(
//                           offColor: MyColor.white,
//                           onColor: MyColor.green,
//                           value: rememberMe,
//                           onChange: (val) => setState(() => rememberMe = val),
//                         ),
//                       ),
//                     ],
//                   ).animate().fade(duration: 400.ms).scaleXY(begin: 0.9, end: 1),
//                  const Spacer(), // Terms
//                   InkWell(
//                     onTap: (){
//                       NavigatorTo(context, SignInScreen());
//                     },
//                     child: RichText(
//                       textAlign: TextAlign.center,
//                       text: const TextSpan(
//                         text:
//                         "Don't have a Account ",
//                         style: TextStyle(
//                           fontFamily: 'Inter',
//                           fontSize: 13,
//                           fontWeight: FontWeight.w400,
//                           color: MyColor.textLight,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: 'Signup',
//                             style: TextStyle(
//                               fontFamily: 'Inter',
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: MyColor.textBlack,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ).animate().fade(duration: 400.ms).slideY(begin: 0.3, end: 0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         bottomNavigationBar: Consumer<BottomButtomProvider>(
//           builder: (context, value, _) => BottomButtons(
//             lable: 'Login',
//             ontap: () async {
//               if (emailController.text.isNotEmpty &&
//                   passwordController.text.isNotEmpty) {
//                 value.startloading();
//                 loginAuth(
//                     emailController.text, passwordController.text, context, rememberMe);

//                 SharedPreferences sp = await SharedPreferences.getInstance();
//                 sp.setBool('rememberMe', rememberMe);
//               } else {
//                 Toastmassage.ErrorToast('Fill complete data');
//               }
//             },
//           )
//               .animate()
//               .fade(duration: 500.ms)
//               .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:laza/Firebase/Auth/login_auth.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Providers/textfeild_tick_provider.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Paths/imports.dart';
// import 'package:laza/Veiw/auth_screens/SignIn.dart';
// import 'package:laza/Veiw/auth_screens/forget_password_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:switcher_button/switcher_button.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import '../../Resources/MediaQuery/media_query.dart';
// import '../../Resources/NotificationMassage/ToastMassage.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool rememberMe = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = getScreenSize(context).height * (1 / 812);
//     final provider = Provider.of<TextfeildTickProvider>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Gradient Header
//               Container(
//                 width: double.infinity,
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF009798), Color(0xFF4DB6AC)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(30),
//                     bottomRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Welcome Back!",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "Please login to your account",
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.85),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ).animate().fade(duration: 500.ms).slideY(begin: -0.3, end: 0),
//               ),

//               const SizedBox(height: 30),

//               // Form Card
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Container(
//                   padding: const EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 12,
//                         offset: const Offset(0, 4),
//                       )
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       // Email field
//                       Consumer<TextfeildTickProvider>(
//                         builder: (_, value, __) => MyTextField(
//                           title: 'Email Address',
//                           fieldType: 'emaillogin',
//                           SuffixIcon: value.emailloginchanger(),
//                           controller: emailController,
//                           hintText: 'Enter Email',
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Password field
//                       Consumer<TextfeildTickProvider>(
//                         builder: (_, __, ___) => MyTextField(
//                           title: 'Password',
//                           fieldType: 'passwordlogin',
//                           SuffixIcon: provider.passwordLoginchanger(),
//                           controller: passwordController,
//                           hintText: 'Enter Password',
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Forgot Password
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           onTap: () => NavigatorTo(
//                               context, const ForgetPasswordScreen()),
//                           child: const Text(
//                             'Forgot password?',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: MyColor.red,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 25),

//                       // Remember Me
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Remember me',
//                             style: TextStyle(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SwitcherButton(
//                             offColor: Colors.grey[300]!,
//                             onColor: MyColor.green,
//                             value: rememberMe,
//                             onChange: (val) => setState(() => rememberMe = val),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // Signup Link
//               InkWell(
//                 onTap: () {
//                   NavigatorTo(context, const SignInScreen());
//                 },
//                 child: RichText(
//                   text: const TextSpan(
//                     text: "Don't have an account? ",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: MyColor.textLight,
//                     ),
//                     children: [
//                       TextSpan(
//                         text: 'Sign Up',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: MyColor.purple,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),

//         // Bottom Login Button
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Consumer<BottomButtomProvider>(
//             builder: (context, value, _) => BottomButtons(
//               lable: 'Login',
//               ontap: () async {
//                 if (emailController.text.isNotEmpty &&
//                     passwordController.text.isNotEmpty) {
//                   value.startloading();
//                   loginAuth(
//                     emailController.text,
//                     passwordController.text,
//                     context,
//                     rememberMe,
//                   );

//                   SharedPreferences sp = await SharedPreferences.getInstance();
//                   sp.setBool('rememberMe', rememberMe);
//                 } else {
//                   Toastmassage.ErrorToast('Fill complete data');
//                 }
//               },
//             )
//                 .animate()
//                 .fade(duration: 500.ms)
//                 .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:laza/Features/Auth/login_auth.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/SignIn.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/forget_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../Resources/NotificationMassage/ToastMassage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TextfeildTickProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF009798), Color(0xFF4DB6AC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Please login to your account",
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 15,
                      ),
                    ),
                  ],
                ).animate().fade(duration: 500.ms).slideY(begin: -0.3, end: 0),
              ),
              const SizedBox(height: 30),

              // Form Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email field
                      Consumer<TextfeildTickProvider>(
                        builder: (_, value, __) => MyTextField( //! Resources/Widgets/TextFields.dart
                          title: 'Email Address',
                          fieldType: 'emaillogin',
                          SuffixIcon: value.emailloginchanger(),
                          controller: emailController,
                          hintText: 'Enter Email',
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      Consumer<TextfeildTickProvider>(
                        builder: (_, __, ___) => MyTextField(
                          title: 'Password',
                          fieldType: 'passwordlogin',
                          SuffixIcon: provider.passwordLoginchanger(),
                          controller: passwordController,
                          hintText: 'Enter Password',
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => NavigatorTo(
                              context, const ForgetPasswordScreen()),
                          child: Text(
                            'Forgot password?',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.teal.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Remember Me
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Remember me',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SwitcherButton(
                            offColor: Colors.grey[300]!,
                            onColor: Colors.teal,
                            value: rememberMe,
                            onChange: (val) => setState(() => rememberMe = val),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Signup Link
              InkWell(
                onTap: () {
                  NavigatorTo(context, const SignInScreen());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<BottomButtomProvider>(
            builder: (context, value, _) => BottomButtons(  //! Resources/Widgets/bottom_button.dart
              lable: 'Login',
              ontap: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  value.startloading();
                  loginAuth(
                    emailController.text,
                    passwordController.text,
                    context,
                    rememberMe,
                  );

                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setBool('rememberMe', rememberMe);
                } else {
                  Toastmassage.ErrorToast(context,'Fill complete data');
                }
              },
            )
                .animate()
                .fade(duration: 500.ms)
                .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
          ),
        ),
      ),
    );
  }
}
