// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:laza/Resources/MediaQuery/media_query.dart';
// import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
// import 'package:laza/Resources/Widgets/reuseable_textfield.dart';

// import 'package:provider/provider.dart';
// import 'package:switcher_button/switcher_button.dart';

// import '../../Providers/addressProvider.dart';
// import '../../Providers/bottom_buttom_provider.dart';
// import '../../Resources/Paths/imports.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController phoneNoController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final h = getScreenSize(context).height * (1 / 812);
//     final addressProvider = Provider.of<Addressprovider>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//         appBar: appBar(context, title: 'Address'),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//           child: Column(
//             children: [
//               // Name
//               ReuseableTextfield(title: 'Name', controller: nameController, hint: 'Ali')
//                   .animate()
//                   .fade(duration: 400.ms)
//                   .slide(begin: const Offset(0, 0.2)),
//               const SizedBox(height: 15),

//               // Country & City
//               Row(
//                 children: [
//                   Expanded(
//                     child: ReuseableTextfield(title: 'Country', controller: countryController, hint: 'Pakistan')
//                         .animate()
//                         .fade(duration: 450.ms)
//                         .slide(begin: const Offset(-0.2, 0)),
//                   ),
//                   const SizedBox(width: 15),
//                   Expanded(
//                     child: ReuseableTextfield(title: 'City', controller: cityController, hint: 'Sahiwal')
//                         .animate()
//                         .fade(duration: 500.ms)
//                         .slide(begin: const Offset(0.2, 0)),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 15),

//               // Phone Number
//               ReuseableTextfield(title: 'Phone Number', controller: phoneNoController, hint: '0330 23456788')
//                   .animate()
//                   .fade(duration: 550.ms)
//                   .slide(begin: const Offset(0, 0.2)),
//               const SizedBox(height: 15),

//               // Address
//               ReuseableTextfield(title: 'Address', controller: addressController, hint: 'Kalma Garden')
//                   .animate()
//                   .fade(duration: 600.ms)
//                   .slide(begin: const Offset(0, 0.2)),
//               const SizedBox(height: 25),

//               // Save as primary switch
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Save as primary address',
//                     style: TextStyle(
//                       fontFamily: 'Inter',
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                       color: MyColor.textBlack,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.black87,
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(
//                         color: MyColor.textLight,
//                         width: 1,
//                       ),
//                     ),
//                     height: 25,
//                     width: 45,
//                     child: SwitcherButton(
//                       offColor: MyColor.white,
//                       onColor: MyColor.green,
//                       value: true,
//                       onChange: (value) {},
//                     ),
//                   ),
//                 ],
//               )
//                   .animate()
//                   .fade(duration: 650.ms)
//                   .scale(begin: const Offset(0.8, 0.8)),
//               SizedBox(height: 216 * h),

//               // Save Address Button
//               Consumer<Addressprovider>(
//                 builder: (context, value, child) {
//                   return BottomButtons(
//                     lable: 'Save Address',
//                     ontap: () {
//                       Provider.of<BottomButtomProvider>(context, listen: false).startloading();
//                       addressProvider.address(
//                         nameController.text.trim(),
//                         cityController.text.trim(),
//                         countryController.text.trim(),
//                         phoneNoController.text.trim(),
//                         addressController.text.trim(),
//                         context,
//                       );
//                     },
//                   )
//                       .animate()
//                       .fade(duration: 700.ms)
//                       .scale(begin: const Offset(0.9, 0.9));
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:laza/Resources/MediaQuery/media_query.dart';
// import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
// import 'package:laza/Resources/Widgets/reuseable_textfield.dart';

// import 'package:provider/provider.dart';
// import 'package:switcher_button/switcher_button.dart';

// import '../../Providers/addressProvider.dart';
// import '../../Providers/bottom_buttom_provider.dart';
// import '../../Resources/Paths/imports.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({super.key});

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController phoneNoController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final h = getScreenSize(context).height * (1 / 812);
//     final w = getScreenSize(context).width / 375;
//     final addressProvider =
//         Provider.of<Addressprovider>(context, listen: false);

//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: const Color(0xFFFAFAFA),
//         appBar: appBar(context, title: 'Delivery Address'),
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFFFAFAFA),
//                 Color(0xFFF0F0F0),
//               ],
//             ),
//           ),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Section with Icon
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   margin: const EdgeInsets.only(bottom: 24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 16,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: MyColor.purple.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(
//                           Icons.location_on_rounded,
//                           color: MyColor.purple,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Add New Address',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFF1A1A1A),
//                                 fontFamily: 'Inter',
//                                 letterSpacing: -0.3,
//                               ),
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Fill in your delivery details',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.grey.shade600,
//                                 fontFamily: 'Inter',
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                           vertical: 6,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Text(
//                           '📍 New',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Inter',
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),

//                 // Form Container
//                 Container(
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(24),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.06),
//                         blurRadius: 20,
//                         offset: const Offset(0, 6),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Personal Information Section
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.red.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Icon(
//                               Icons.person_rounded,
//                               color: Colors.red,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'Personal Information',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1A1A1A),
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Name Field with enhanced styling
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.02),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ReuseableTextfield(
//                           title: 'Full Name',
//                           controller: nameController,
//                           hint: 'Enter your full name',
//                         ),
//                       )
//                           .animate()
//                           .fade(duration: 400.ms)
//                           .slide(begin: const Offset(0, 0.2)),
//                       const SizedBox(height: 20),

//                       // Location Section
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.orange.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Icon(
//                               Icons.public_rounded,
//                               color: Colors.orange,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'Location Details',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1A1A1A),
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Country & City Row with enhanced design
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.02),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: ReuseableTextfield(
//                                 title: 'Country',
//                                 controller: countryController,
//                                 hint: 'Pakistan',
//                               ),
//                             ),
//                           )
//                               .animate()
//                               .fade(duration: 450.ms)
//                               .slide(begin: const Offset(-0.2, 0)),
//                           const SizedBox(width: 16),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.02),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: ReuseableTextfield(
//                                 title: 'City',
//                                 controller: cityController,
//                                 hint: 'Sahiwal',
//                               ),
//                             ),
//                           )
//                               .animate()
//                               .fade(duration: 500.ms)
//                               .slide(begin: const Offset(0.2, 0)),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Contact Section
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.green.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: const Icon(
//                               Icons.phone_rounded,
//                               color: Colors.green,
//                               size: 16,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'Contact Information',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1A1A1A),
//                               fontFamily: 'Inter',
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),

//                       // Phone Number with enhanced styling
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.02),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ReuseableTextfield(
//                           title: 'Phone Number',
//                           controller: phoneNoController,
//                           hint: '+92 330 2345678',
//                         ),
//                       )
//                           .animate()
//                           .fade(duration: 550.ms)
//                           .slide(begin: const Offset(0, 0.2)),
//                       const SizedBox(height: 20),

//                       // Address with enhanced styling
//                       Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.02),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: ReuseableTextfield(
//                           title: 'Complete Address',
//                           controller: addressController,
//                           hint: 'Street address, building, apartment',
//                         ),
//                       )
//                           .animate()
//                           .fade(duration: 600.ms)
//                           .slide(begin: const Offset(0, 0.2)),
//                       const SizedBox(height: 24),

//                       // Primary Address Switch with enhanced design
//                       Container(
//                         padding: const EdgeInsets.all(20),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF8F9FA),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.grey.withOpacity(0.1),
//                             width: 1,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: MyColor.purple.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: const Icon(
//                                 Icons.star_rounded,
//                                 color: MyColor.purple,
//                                 size: 16,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Primary Address',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w600,
//                                       color: Color(0xFF1A1A1A),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 2),
//                                   Text(
//                                     'Set as default delivery location',
//                                     style: TextStyle(
//                                       fontFamily: 'Inter',
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w400,
//                                       color: Colors.grey.shade600,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               height: 32,
//                               width: 56,
//                               child: SwitcherButton(
//                                 offColor: Colors.grey.shade300,
//                                 onColor: MyColor.green,
//                                 value: true,
//                                 onChange: (value) {},
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                           .animate()
//                           .fade(duration: 650.ms)
//                           .scale(begin: const Offset(0.95, 0.95)),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 160 * h),

//                 // Save Address Button with enhanced design
//                 Consumer<Addressprovider>(
//                   builder: (context, value, child) {
//                     return Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         gradient: LinearGradient(
//                           colors: [
//                             MyColor.purple,
//                             MyColor.purple.withOpacity(0.8),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: MyColor.purple.withOpacity(0.3),
//                             blurRadius: 16,
//                             offset: const Offset(0, 6),
//                           ),
//                         ],
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(16),
//                           onTap: () {
//                             Provider.of<BottomButtomProvider>(context,
//                                     listen: false)
//                                 .startloading();
//                             addressProvider.address(
//                               nameController.text.trim(),
//                               cityController.text.trim(),
//                               countryController.text.trim(),
//                               phoneNoController.text.trim(),
//                               addressController.text.trim(),
//                               context,
//                             );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(vertical: 18),
//                             child: const Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.save_rounded,
//                                   color: Colors.white,
//                                   size: 20,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Text(
//                                   'Save Address',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Inter',
//                                     letterSpacing: 0.2,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                         .animate()
//                         .fade(duration: 700.ms)
//                         .scale(begin: const Offset(0.95, 0.95))
//                         .slideY(begin: 0.3);
//                   },
//                 ),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Resources/Widgets/reviewTextfield.dart';

import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import 'provider/addressProvider.dart';
import '../../Providers/bottom_buttom_provider.dart';
import '../../Resources/Paths/imports.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Validation method
  bool _validateFields() {
    return nameController.text.trim().isNotEmpty &&
        countryController.text.trim().isNotEmpty &&
        cityController.text.trim().isNotEmpty &&
        phoneNoController.text.trim().isNotEmpty &&
        addressController.text.trim().isNotEmpty;
  }

  // Show validation error message
  void _showValidationError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Please fill in all fields before saving',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.red.shade600,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(16),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = getScreenSize(context).height * (1 / 812);
    final w = getScreenSize(context).width / 375;
    final addressProvider =
        Provider.of<Addressprovider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: appBar(context,
            title: 'Delivery Address', screenType: const CartScreen()),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFAFAFA),
                Color(0xFFF0F0F0),
              ],
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section with Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MyColor.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: MyColor.purple,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add New Address',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Fill in your delivery details',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '📍 New',
                          style: GoogleFonts.poppins(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2),

                // Form Container
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Personal Information Section
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Colors.red,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Personal Information',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Name Field with enhanced styling
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ReuseableTextfield(
                          title: 'Full Name',
                          controller: nameController,
                          hint: 'Enter your full name',
                        ),
                      )
                          .animate()
                          .fade(duration: 400.ms)
                          .slide(begin: const Offset(0, 0.2)),
                      const SizedBox(height: 20),

                      // Location Section
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.public_rounded,
                              color: Colors.orange,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Location Details',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Country & City Row with enhanced design
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ReuseableTextfield(
                                title: 'Country',
                                controller: countryController,
                                hint: 'Pakistan',
                              ),
                            ),
                          )
                              .animate()
                              .fade(duration: 450.ms)
                              .slide(begin: const Offset(-0.2, 0)),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ReuseableTextfield(
                                title: 'City',
                                controller: cityController,
                                hint: 'Sahiwal',
                              ),
                            ),
                          )
                              .animate()
                              .fade(duration: 500.ms)
                              .slide(begin: const Offset(0.2, 0)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Contact Section
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.phone_rounded,
                              color: Colors.green,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Contact Information',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Phone Number with enhanced styling
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ReuseableTextfield(
                          title: 'Phone Number',
                          controller: phoneNoController,
                          hint: '+92 330 2345678',
                        ),
                      )
                          .animate()
                          .fade(duration: 550.ms)
                          .slide(begin: const Offset(0, 0.2)),
                      const SizedBox(height: 20),

                      // Address with enhanced styling
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ReuseableTextfield(
                          title: 'Complete Address',
                          controller: addressController,
                          hint: 'Street address, building, apartment',
                        ),
                      )
                          .animate()
                          .fade(duration: 600.ms)
                          .slide(begin: const Offset(0, 0.2)),
                      const SizedBox(height: 24),

                      // Primary Address Switch with enhanced design
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: MyColor.purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.star_rounded,
                                color: MyColor.purple,
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Primary Address',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1A1A1A),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Set as default delivery location',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              height: 32,
                              width: 56,
                              child: SwitcherButton(
                                offColor: Colors.grey.shade300,
                                onColor: MyColor.green,
                                value: true,
                                onChange: (value) {},
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fade(duration: 650.ms)
                          .scale(begin: const Offset(0.95, 0.95)),
                    ],
                  ),
                ),

                SizedBox(height: 60 * h),

                // Save Address Button with enhanced design and validation
                Consumer<Addressprovider>(
                  builder: (context, value, child) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [
                            MyColor.purple,
                            MyColor.purple.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.purple.withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            // Validate fields before proceeding
                            if (_validateFields()) {
                              Provider.of<BottomButtomProvider>(context,
                                      listen: false)
                                  .startloading();
                              addressProvider.address(
                                nameController.text.trim(),
                                cityController.text.trim(),
                                countryController.text.trim(),
                                phoneNoController.text.trim(),
                                addressController.text.trim(),
                                context,
                              );
                            } else {
                              _showValidationError();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.save_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Save Address',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fade(duration: 700.ms)
                        .scale(begin: const Offset(0.95, 0.95))
                        .slideY(begin: 0.3);
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
