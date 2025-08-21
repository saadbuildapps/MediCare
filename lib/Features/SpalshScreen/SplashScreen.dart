import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Features/Auth/Screeens/auth_screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Resources/NavigationBar/nav_bar.dart';
import '../../Resources/Paths/AssetsPath.dart';
import '../../Resources/Paths/imports.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _auth = FirebaseAuth.instance;
  bool? statu;

  rememberMe() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool status = sp.getBool('rememberMe') ?? false;
    statu = status;
    final userstate = _auth.currentUser;

    print('User exists: ${userstate != null}');
    print('RememberMe status: $statu');

    if (statu == true) {
      if (userstate != null) {
        Timer(const Duration(seconds: 4), () {
          NavigatorToReplace(context, const NavBar());
        });
      }
    } else {
      Timer(const Duration(seconds: 4), () {
        NavigatorToReplace(context, const MedCareOnboardingScreen());
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.white,
      body: Center(
        child: Image.asset(
          PngImages.splash,
          height: getScreenSize(context).height * .5,
          width: getScreenSize(context).width ,
        ) .animate()
            .fadeIn(duration: 800.ms, curve: Curves.easeInOut) // Smooth fade-in
            .scale(duration: 1000.ms, curve: Curves.easeInOutBack) // Slight overshoot for a dynamic pop
            .then()
            .rotate(begin: -0.02, end: 0.0, duration: 500.ms, curve: Curves.easeOutQuad) // Adds a tiny rotation effect
            .then()
            .moveY(begin: -20, end: 0, duration: 600.ms, curve: Curves.decelerate),
      ),
    );
  }
}
