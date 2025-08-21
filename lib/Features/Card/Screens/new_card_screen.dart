// import 'package:flutter/services.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:laza/Firebase/DataBase/add_card.dart';
// import 'package:laza/Models/card_type_model.dart';
// import 'package:laza/Providers/card-type-provider.dart';
// import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
// import 'package:laza/Resources/Widgets/reuseable_textfield.dart';
// import 'package:provider/provider.dart';

// import '../../Providers/bottom_buttom_provider.dart';
// import '../../Resources/MediaQuery/media_query.dart';
// import '../../Resources/Paths/imports.dart';

// class NewCardScreen extends StatefulWidget {
//   const NewCardScreen({super.key});

//   @override
//   State<NewCardScreen> createState() => _NewCardScreenState();
// }

// class _NewCardScreenState extends State<NewCardScreen> {
//   String cardType = 'master';
//   final TextEditingController cardOwnerController = TextEditingController();
//   final TextEditingController cardNumberController = TextEditingController();
//   final TextEditingController cardExpController = TextEditingController();
//   final TextEditingController cardCVVController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final w = getScreenSize(context).width * (1 / 375);

//     return SafeArea(
//       child: Scaffold(
//         appBar: appBar(context, title: 'Payment'),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 _buildCardTypeSelector()
//                     .animate()
//                     .fade(duration: 400.ms)
//                     .slideY(begin: 0.2),
//                 const SizedBox(height: 15),
//                 _buildTextFields(w),
//               ],
//             ),
//           ),
//         ),
//         bottomNavigationBar: BottomButtons(
//           lable: 'Add Card',
//           ontap: () {
//             Provider.of<BottomButtomProvider>(context, listen: false)
//                 .startloading();
//             addCard(
//               ownername: cardOwnerController.text,
//               cardNo: cardNumberController.text,
//               exp: cardExpController.text,
//               cvv: cardCVVController.text,
//               type: cardType,
//               context: context,
//             );
//           },
//         )
//             .animate()
//             .fade(duration: 500.ms, delay: 200.ms)
//             .scale(begin: const Offset(0.95, 0.95)),
//       ),
//     );
//   }

//   /// Card type selector row
//   Widget _buildCardTypeSelector() {
//     return SizedBox(
//       height: 50,
//       child: Consumer<CardTypeProvider>(
//         builder: (context, value, child) {
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: cardTypeList.length,
//             itemBuilder: (context, index) {
//               final isSelected = value.selectedIndex == index;
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: InkWell(
//                   onTap: () {
//                     value.selectedSize(index);
//                     cardType = cardTypeList[index].cardType;
//                   },
//                   child: Container(
//                     height: 50,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color:
//                           isSelected ? const Color(0xffFFEEE3) : MyColor.grey,
//                       border: Border.all(
//                         color:
//                             isSelected ? const Color(0xffFF5F00) : MyColor.grey,
//                       ),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Image.asset(cardTypeList[index].cardLogoPath)
//                           .animate()
//                           .fade(duration: 300.ms, delay: (index * 80).ms)
//                           .scale(begin: const Offset(0.95, 0.95)),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   /// Card form fields
//   Widget _buildTextFields(double w) {
//     return Column(
//       children: [
//         ReuseableTextfield(
//           title: 'Card Owner',
//           controller: cardOwnerController,
//           hint: 'Ali',
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(
//                 RegExp(r"[a-zA-Z\s]")), // Only letters & spaces
//             LengthLimitingTextInputFormatter(30), // Optional limit
//           ],
//         ).animate().fade(duration: 400.ms, delay: 100.ms).slideX(begin: -0.2),
//         const SizedBox(height: 15),
//         ReuseableTextfield(
//           title: 'Card Number',
//           controller: cardNumberController,
//           hint: '5254 7634 8734 7690',
//           keyboardType: TextInputType.number,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//             LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces
//             _CardNumberInputFormatter(),
//           ],
//         ).animate().fade(duration: 400.ms, delay: 200.ms).slideX(begin: -0.2),
//         const SizedBox(height: 15),
//         Row(
//           children: [
//             Expanded(
//               child: ReuseableTextfield(
//                 title: 'Exp',
//                 controller: cardExpController,
//                 hint: '24/24',
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(5), // MM/YY
//                   _ExpiryDateFormatter(),
//                 ],
//               )
//                   .animate()
//                   .fade(duration: 400.ms, delay: 300.ms)
//                   .slideX(begin: -0.2),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: ReuseableTextfield(
//                 title: 'CVV',
//                 controller: cardCVVController,
//                 hint: '2345',
//                 keyboardType: TextInputType.number,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.digitsOnly,
//                   LengthLimitingTextInputFormatter(4),
//                 ],
//               )
//                   .animate()
//                   .fade(duration: 400.ms, delay: 400.ms)
//                   .slideX(begin: 0.2),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// /// Formats card number as "#### #### #### ####"
// class _CardNumberInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var digitsOnly = newValue.text.replaceAll(' ', '');
//     var newString = '';
//     for (int i = 0; i < digitsOnly.length; i++) {
//       newString += digitsOnly[i];
//       if ((i + 1) % 4 == 0 && i + 1 != digitsOnly.length) {
//         newString += ' ';
//       }
//     }
//     return TextEditingValue(
//       text: newString,
//       selection: TextSelection.collapsed(offset: newString.length),
//     );
//   }
// }

// /// Formats expiry as "MM/YY"
// class _ExpiryDateFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue, TextEditingValue newValue) {
//     var digitsOnly = newValue.text.replaceAll('/', '');
//     if (digitsOnly.length > 2) {
//       digitsOnly = '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2)}';
//     }
//     return TextEditingValue(
//       text: digitsOnly,
//       selection: TextSelection.collapsed(offset: digitsOnly.length),
//     );
//   }
// }

// ================================
// 6. NEW CARD SCREEN (GetX Design + Provider)
// ================================
// File: view/shopping_screen/new_card_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:laza/Models/card_type_model.dart';
import 'package:laza/Features/Card/Providers/card-type-provider.dart';
import 'package:laza/Features/Card/Providers/card_submitButton_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:provider/provider.dart';
import '../Providers/card_form_provider.dart';
import '../../../Providers/bottom_buttom_provider.dart';
import '../../../Firebase/DataBase/add_card.dart';

class NewCardScreen extends StatefulWidget {
  const NewCardScreen({super.key});

  @override
  State<NewCardScreen> createState() => _NewCardScreenState();
}

class _NewCardScreenState extends State<NewCardScreen>
    with TickerProviderStateMixin {
  late AnimationController rotateController;
  late Animation<Offset> slideAnimation;
  late AnimationController slideController;
  bool showShimmer = false;

  // Controllers
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();

    rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: slideController, curve: Curves.easeOutBack),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      await slideController.forward();
      if (mounted) {
        Provider.of<CardFormProvider>(context, listen: false).setAnimated();
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            showShimmer = true;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    rotateController.dispose();
    slideController.dispose();
    cardNumberController.dispose();
    cardNameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  Widget buildCardTypeSelector(
      String type, String imagePath, CardTypeProvider provider) {
    return Consumer<CardTypeProvider>(
      builder: (context, cardTypeProvider, child) {
        final isSelected = cardTypeProvider.selectedCardType == type;

        return GestureDetector(
          onTap: () {
            // Find index of this card type
            int index =
                cardTypeList.indexWhere((element) => element.cardType == type);
            provider.selectedSize(index);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.transparent,
                width: 2,
              ),
            ),
            child: SvgPicture.asset(imagePath, width: 20, height: 20),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: appBar(context, title: 'Add New Card'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Dynamic Background
                Consumer<CardTypeProvider>(
                  builder: (context, cardTypeProvider, child) {
                    Gradient gradient;

                    switch (cardTypeProvider.selectedCardType) {  
                      case 'Visa':
                        gradient = const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 98, 110, 248),
                            Color.fromARGB(255, 166, 180, 245),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        );
                        break;
                      case 'MasterCard':
                        gradient = const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 247, 114, 74),
                            Color.fromARGB(255, 255, 168, 141),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        );
                        break;
                      default:
                        gradient = const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 61, 61, 61),
                            Color.fromARGB(255, 151, 150, 150),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        );
                    }

                    return Container(
                      width: double.infinity,
                      height: 430,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: gradient,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                // Foreground Content
                Column(
                  children: [
                    const SizedBox(height: 40),

                    // Card UI + Animation
                    SlideTransition(
                      position: slideAnimation,
                      child: Consumer2<CardTypeProvider, CardFormProvider>(
                        builder:
                            (context, cardTypeProvider, formProvider, child) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            switchInCurve: Curves.easeInOut,
                            switchOutCurve: Curves.easeInOut,
                            transitionBuilder: (child, animation) {
                              final offsetAnimation = Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                            child: Container(
                              key: ValueKey(cardTypeProvider.selectedCardType),
                              child: AnimatedBuilder(
                                animation: rotateController,
                                builder: (context, child) => Transform.rotate(
                                  angle: rotateController.value * 2 * pi,
                                  child: child,
                                ),
                                child: Stack(
                                  children: [
                                    // Card Widget
                                    Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateX(-0.05)
                                        ..rotateY(0.05),
                                      alignment: FractionalOffset.center,
                                      child: Container(
                                        height: 220,
                                        width: double.infinity,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                            colors:
                                                cardTypeProvider
                                                            .selectedCardType ==
                                                        'Visa'
                                                    ? [
                                                        const Color(0xff93278F),
                                                        const Color(0xff29ABE2)
                                                      ]
                                                    : cardTypeProvider
                                                                .selectedCardType ==
                                                            'MasterCard'
                                                        ? [
                                                            Colors.orange,
                                                            Colors.redAccent
                                                          ]
                                                        : [
                                                            const Color(0xff2F2C2C),
                                                            const Color(0xff3F3F3F)
                                                          ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 20,
                                              offset: Offset(0, 10),
                                            ),
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                cardTypeProvider
                                                    .selectedCardType
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 30,
                                              left: 10,
                                              child: SvgPicture.asset(
                                                'assets/images/sim.svg',
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 60,
                                              left: 10,
                                              child: Text(
                                                formProvider.formatCardNumber(
                                                    formProvider.rawCardNumber),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  letterSpacing: 1.2,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 30,
                                              left: 10,
                                              child: Text(
                                                formProvider
                                                        .cardholderName.isEmpty
                                                    ? "CARDHOLDER NAME"
                                                    : formProvider
                                                        .cardholderName
                                                        .toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 30,
                                              right: 10,
                                              child: Text(
                                                formProvider.expiryDate.isEmpty
                                                    ? "MM/YY"
                                                    : formProvider.expiryDate,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Shimmer
                                    if (showShimmer)
                                      Positioned.fill(
                                        child: Transform.rotate(
                                          angle: 0,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.transparent,
                                            highlightColor:
                                                Colors.white.withOpacity(0.1),
                                            direction: ShimmerDirection.ltr,
                                            period: const Duration(seconds: 3),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Card Type Selector
                    Consumer<CardTypeProvider>(
                      builder: (context, provider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildCardTypeSelector(
                                'Visa', 'assets/images/visa.svg', provider),
                            buildCardTypeSelector('MasterCard',
                                'assets/images/master.svg', provider),
                            buildCardTypeSelector(
                                'PayPal', 'assets/images/paypal.svg', provider),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Form Fields
            Consumer<CardFormProvider>(
              builder: (context, formProvider, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      // Card Number Field
                      TextField(
                        controller: cardNumberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 16,
                        decoration: InputDecoration(
                          hintText: 'Card Number',
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: Consumer<CardTypeProvider>(
                            builder: (context, cardTypeProvider, child) {
                              String imagePath;
                              if (cardTypeProvider.selectedCardType == 'Visa') {
                                imagePath = 'assets/images/number.svg';
                              } else if (cardTypeProvider.selectedCardType ==
                                  'MasterCard') {
                                imagePath = 'assets/images/m1.svg';
                              } else {
                                imagePath = 'assets/images/number2.svg';
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: SvgPicture.asset(
                                  imagePath,
                                  width: 24,
                                  height: 24,
                                ),
                              );
                            },
                          ),
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onChanged: (value) => formProvider.setCardNumber(value),
                      ),
                      const SizedBox(height: 15),

                      // Cardholder Name Field
                      TextField(
                        controller: cardNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: 'Cardholder Name',
                          hintStyle: const TextStyle(fontFamily: 'Poppins'),
                          suffixIcon: const Icon(Icons.person_4,
                              color: Color.fromARGB(255, 223, 99, 5)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        onChanged: (value) =>
                            formProvider.setCardholderName(value),
                      ),
                      const SizedBox(height: 15),

                      // Expiry and CVV Row
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: expiryController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9/]')),
                                LengthLimitingTextInputFormatter(5),
                              ],
                              decoration: InputDecoration(
                                hintText: 'Expiry',
                                hintStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                suffixIcon: const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.calendarDays,
                                    color: Color.fromARGB(255, 223, 99, 5),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                              onChanged: (value) {
                                formProvider.formatExpiryDate(value);
                                expiryController.text = formProvider.expiryDate;
                                expiryController.selection =
                                    TextSelection.collapsed(
                                  offset: formProvider.expiryDate.length,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: TextField(
                              controller: cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              decoration: InputDecoration(
                                hintText: 'CVV',
                                hintStyle:
                                    const TextStyle(fontFamily: 'Poppins'),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: SvgPicture.asset(
                                    'assets/images/cvv1.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                              ),
                              onChanged: (value) => formProvider.setCVV(value),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Submit Button
            Consumer3<SubmitButtonProvider, CardFormProvider, CardTypeProvider>(
              builder: (context, buttonProvider, formProvider, cardTypeProvider,
                  child) {
                return AnimatedSubmitButton(
                  controller: buttonProvider,
                  cardTypeProvider: cardTypeProvider,
                  onSubmit: () {
                    // Add card using old Firebase function
                    Provider.of<BottomButtomProvider>(context, listen: false)
                        .startloading();
                    addCard(
                      ownername: cardNameController.text,
                      cardNo: cardNumberController.text,
                      exp: expiryController.text,
                      cvv: cvvController.text,
                      type: cardTypeProvider.selectedCardType,
                      context: context,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================================
// 7. ANIMATED SUBMIT BUTTON WIDGET
// ================================
class AnimatedSubmitButton extends StatelessWidget {
  final void Function() onSubmit;
  final SubmitButtonProvider controller;
  final CardTypeProvider cardTypeProvider;
  final double width;
  final double height;

  const AnimatedSubmitButton({
    super.key,
    required this.onSubmit,
    required this.controller,
    required this.cardTypeProvider,
    this.width = 260,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SubmitButtonProvider>(
      builder: (context, buttonProvider, child) {
        return GestureDetector(
          onTap: buttonProvider.isSubmitting
              ? null
              : () => buttonProvider.startAnimation(onSubmit),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              children: [
                // Background Container
                Container(
                    width: width, height: height, color: Colors.grey[350]),

                // Animated Filling
                Consumer<CardTypeProvider>(
                  builder: (context, cardTypeProvider, child) {
                    List<Color> gradientColors;

                    if (cardTypeProvider.selectedCardType == 'Visa') {
                      gradientColors = [
                        const Color(0xff93278F),
                        const Color(0xff29ABE2)
                      ];
                    } else if (cardTypeProvider.selectedCardType ==
                        'MasterCard') {
                      gradientColors = [Colors.orange, Colors.redAccent];
                    } else {
                      gradientColors = [
                        const Color(0xff2F2C2C),
                        const Color(0xff3F3F3F)
                      ];
                    }

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: width * buttonProvider.fillPercent,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: const Radius.circular(30),
                          right: Radius.circular(
                              buttonProvider.fillPercent == 1 ? 30 : 0),
                        ),
                      ),
                    );
                  },
                ),

                // Text or Check Icon
                Positioned.fill(
                  child: Center(
                    child: buttonProvider.isDone
                        ? Transform.scale(
                            scale: 2.5,
                            child: Lottie.asset(
                              'assets/images/tick.json',
                              width: 120,
                              height: 120,
                              repeat: false,
                            ),
                          )
                        : const Text(
                            "Add Card",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
