import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessAnimationPopup extends StatefulWidget {
  const OrderSuccessAnimationPopup({super.key});

  @override
  State<OrderSuccessAnimationPopup> createState() =>
      _OrderSuccessAnimationPopupState();
}

class _OrderSuccessAnimationPopupState
    extends State<OrderSuccessAnimationPopup> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pop(); // 3 sec baad close
    });
  }
  //    - assets/videos/success.mp4

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 370,
        width: 370,
        child: Lottie.asset(
          'assets/animations/bike.json',
          repeat: false,
        ),
      ),
    );
  }
}
