// import 'dart:io';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:laza/Firebase/Auth/signUp_auth.dart';
// import 'package:laza/Providers/bottom_buttom_provider.dart';
// import 'package:laza/Providers/textfeild_tick_provider.dart';

// import 'package:laza/Resources/Paths/imports.dart';

// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:switcher_button/switcher_button.dart';
// import '../../Resources/MediaQuery/media_query.dart';
// import '../../Resources/NotificationMassage/ToastMassage.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool rememberMe = true;

//   File? _image;
//   final picker = ImagePicker();
//   bool _isPicking = false;

//   Future<void> pickImage() async {
//     if (_isPicking) return;
//     _isPicking = true;

//     try {
//       final pickedImage = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedImage != null) {
//         setState(() => _image = File(pickedImage.path));
//       } else {
//         Toastmassage.ErrorToast('No Image selected');
//       }
//     } catch (e) {
//       Toastmassage.ErrorToast('Error picking image');
//     } finally {
//       _isPicking = false;
//     }
//   }

//   @override
//   void dispose() {
//     passwordController.dispose();
//     emailController.dispose();
//     nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = getScreenSize(context).height * (1 / 812);
//     final buttonProvider = Provider.of<BottomButtomProvider>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 45),
//           child: SizedBox(
//             height: getScreenSize(context).height -133,
//             child: Column(
//               children: [
//                 const TopHeader(lable: 'Sign Up')
//                     .animate()
//                     .fade(duration: 500.ms)
//                     .slideY(begin: -0.3, end: 0),

//                 SizedBox(height: 40 * h),

//                 // Profile image picker
//                 InkWell(
//                   onTap: pickImage,
//                   child: Stack(
//                     alignment: const Alignment(.9, 1),
//                     children: [
//                       Container(
//                         clipBehavior: Clip.antiAlias,
//                         height: 100 *h,
//                         width: 100 *h,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(color: MyColor.textLight, width: 1.5),
//                           color: MyColor.grey,
//                         ),
//                         child: _image == null
//                             ? Icon(Icons.person, color: MyColor.textLight, size: 80  *h)
//                             : Image.file(_image!, fit: BoxFit.cover),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: MyColor.white,
//                         ),
//                         child:  Icon(Icons.add_circle_outlined,
//                             color: MyColor.purple, size: 30 *h),
//                       ),
//                     ],
//                   ),
//                 )
//                     .animate()
//                     .fade(duration: 500.ms)
//                     .scaleXY(begin: 0.9, end: 1, duration: 400.ms),

//                 SizedBox(height: 20 * h),

//                 // Name
//                 Consumer<TextfeildTickProvider>(
//                   builder: (_, value, __) => MyTextField(
//                     title: 'UserName',
//                     controller: nameController,
//                     SuffixIcon: value.namechanger(),
//                     hintText: 'Enter Name',
//                     fieldType: 'name',
//                   )
//                       .animate()
//                       .fade(duration: 400.ms)
//                       .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//                 ),
//                 SizedBox(height: 20 * h),

//                 // Password
//                 Consumer<TextfeildTickProvider>(
//                   builder: (_, value, __) => MyTextField(
//                     title: 'Password',
//                     controller: passwordController,
//                     SuffixIcon: value.passwordchanger(),
//                     hintText: 'Enter Password',
//                     fieldType: 'password',
//                   )
//                       .animate()
//                       .fade(duration: 400.ms)
//                       .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//                 ),
//                 SizedBox(height: 20 * h),

//                 // Email
//                 Consumer<TextfeildTickProvider>(
//                   builder: (_, value, __) => MyTextField(
//                     title: 'Email Address',
//                     controller: emailController,
//                     SuffixIcon: value.emailchanger(),
//                     hintText: 'Enter Email',
//                     fieldType: 'email',
//                   )
//                       .animate()
//                       .fade(duration: 400.ms)
//                       .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//                 ),
// Spacer(),
//                 // Remember Me
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Remember me',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: MyColor.textBlack,
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black87,
//                         borderRadius: BorderRadius.circular(100),
//                         border: Border.all(
//                           color: MyColor.textLight,
//                           width: 1,
//                         ),
//                       ),
//                       height: 18,
//                       width: 33,
//                       child: SwitcherButton(
//                         offColor: MyColor.white,
//                         onColor: MyColor.green,
//                         value: rememberMe,
//                         onChange: (v) => setState(() => rememberMe = v),
//                       ),
//                     ),
//                   ],
//                 )
//                     .animate()
//                     .fade(duration: 400.ms)
//                     .scaleXY(begin: 0.9, end: 1),
//                 const SizedBox(height: 15),
//               ],
//             ),
//           ),
//         ),

//         // Sign Up button
//         bottomNavigationBar: BottomButtons(
//           lable: 'Sign Up',
//           ontap: () async {
//             if (_image != null &&
//                 emailController.text.isNotEmpty &&
//                 passwordController.text.isNotEmpty &&
//                 nameController.text.isNotEmpty) {
//               buttonProvider.startloading();
//               signUp_auth(
//                   emailController.text,
//                   passwordController.text,
//                   context,
//                   nameController.text,
//                   _image,
//                   rememberMe);

//               SharedPreferences sp = await SharedPreferences.getInstance();
//               sp.setBool('rememberMe', rememberMe);
//             } else {
//               Toastmassage.ErrorToast('Fill complete data');
//             }
//           },
//         )
//             .animate()
//             .fade(duration: 500.ms)
//             .scaleXY(begin: 0.95, end: 1, duration: 300.ms),
//       ),
//     );
//   }

// }

import 'dart:io';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laza/Features/Auth/signUp_auth.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import '../../../../Resources/MediaQuery/media_query.dart';
import '../../../../Resources/NotificationMassage/ToastMassage.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = true;

  File? _image;
  final picker = ImagePicker();
  bool _isPicking = false;

  Future<void> pickImage() async {
    if (_isPicking) return;
    _isPicking = true;
    try {
      final pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() => _image = File(pickedImage.path));
      } else {
        Toastmassage.ErrorToast(context,'No Image selected');
      }
    } catch (e) {
      Toastmassage.ErrorToast(context,'Error picking image');
    } finally {
      _isPicking = false;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = getScreenSize(context).height * (1 / 812);
    final buttonProvider =
        Provider.of<BottomButtomProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const TopHeader(
                      lable:
                          'Create Account') //! Widgets/top_back_and-text.dart
                  .animate()
                  .fade(duration: 500.ms)
                  .slideY(begin: -0.3, end: 0),

              const SizedBox(height: 30),

              // Profile Picker
              InkWell(
                onTap: pickImage,
                borderRadius: BorderRadius.circular(100),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 110 * h,
                      width: 110 * h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: _image == null
                          ? Icon(Icons.person_outline,
                              size: 70 * h, color: Colors.grey[400])
                          : Image.file(_image!, fit: BoxFit.cover),
                    ),
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: MyColor.purple,
                      child: Icon(Icons.add_a_photo,
                          size: 18, color: Colors.white),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fade(duration: 500.ms)
                  .scaleXY(begin: 0.9, end: 1, duration: 400.ms),

              const SizedBox(height: 30),

              // Card container for fields
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Name
                    Consumer<TextfeildTickProvider>(
                      builder: (_, value, __) => MyTextField(
                        title: 'User Name',
                        controller: nameController,
                        SuffixIcon: value.namechanger(),
                        hintText: 'Enter your name',
                        fieldType: 'name',
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Password
                    Consumer<TextfeildTickProvider>(
                      builder: (_, value, __) => MyTextField(
                        title: 'Password',
                        controller: passwordController,
                        SuffixIcon: value.passwordchanger(),
                        hintText: 'Enter password',
                        fieldType: 'password',
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Email
                    Consumer<TextfeildTickProvider>(
                      builder: (_, value, __) => MyTextField(
                        title: 'Email Address',
                        controller: emailController,
                        SuffixIcon: value.emailchanger(),
                        hintText: 'Enter your email',
                        fieldType: 'email',
                      ),
                    ),
                    const SizedBox(height: 20),

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
                          onChange: (v) => setState(() => rememberMe = v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Bottom Sign-Up Button
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BottomButtons(
            //! Resources/Widgets/bottom_button.dart
            lable: 'Sign Up',
            ontap: () async {
              if (_image != null &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  nameController.text.isNotEmpty) {
                buttonProvider.startloading();
                signUp_auth(emailController.text, passwordController.text,
                    context, nameController.text, _image, rememberMe);

                // SharedPreferences sp = await SharedPreferences.getInstance();
                // sp.setBool('rememberMe', rememberMe);
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
    );
  }
}
