


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Home/screen/all_arrival_screen.dart';
import 'package:laza/Features/Confirmation/confirm_Animation.dart';
import 'package:laza/Firebase/DataBase/user_cart.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import '../../Resources/MediaQuery/media_query.dart';
import '../../Resources/NavigationBar/nav_bar.dart';
import '../../Resources/Paths/imports.dart' hide MediCareTheme;

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: appBar(context, title: ''),  //!   not used 
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Circular Success Animation
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: MediCareTheme.primaryTeal.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child:  const  Center(
                    child: Icon(
                      Icons.check_circle,
                      size: 120,
                      color: MediCareTheme.primaryTeal,
                    ),
                  ),
                )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.easeOutBack)
                    .fade(duration: 600.ms),

                const SizedBox(height: 30),

                // ✅ Title
                Text(
                  'Order Confirmed!',
                  style: GoogleFonts.poppins(
                    color: MediCareTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                )
                    .animate()
                    .fade(duration: 500.ms)
                    .slideY(begin: 0.3, curve: Curves.easeOut),

                const SizedBox(height: 12),

                // ✅ Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Your order has been placed successfully. You will receive a confirmation email shortly.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: MediCareTheme.textSecondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                )
                    .animate()
                    .fade(duration: 500.ms, delay: 100.ms)
                    .slideY(begin: 0.3),

                const SizedBox(height: 50),

                // ✅ Go to Orders Button
                InkWell(
                  onTap: () => NavigatorToReplace(context, const CartScreen()),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 55,
                    width: 320 * w,
                    decoration: BoxDecoration(
                      color: MediCareTheme.primaryTeal,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Go to Orders',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fade(duration: 500.ms, delay: 200.ms)
                      .slideY(begin: 0.3),
                ),

                const SizedBox(height: 20),

                // ✅ Continue Shopping Button
              // ✅ Confirm Order Button with Video Popup
InkWell(
  onTap: () async {
    // ✅ Show Lottie Animation Popup
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const OrderSuccessAnimationPopup(),
    );

    // ✅ Old Logic chalega after animation
    Cart.clearCart(context);
    NavigatorToReplace(context, const NavBar());
  },
  borderRadius: BorderRadius.circular(12),
  child: Container(
    height: 55,
    width: 320 * w,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: MediCareTheme.primaryTeal, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: Text(
        'Confirm Order',
        style: GoogleFonts.poppins(
          color: MediCareTheme.primaryTeal,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
) ,

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


