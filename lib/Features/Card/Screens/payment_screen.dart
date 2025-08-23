import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Card/Providers/card-type-provider.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:laza/Resources/Widgets/reuseable_appbar.dart';
import 'package:laza/Features/Card/Screens/new_card_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../Resources/MediaQuery/media_query.dart';
import '../../../Resources/NavigationBar/nav_bar.dart';
import '../../../Resources/Paths/imports.dart';

int selectedIndex = 0;
String statusOfCard = 'unsave';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Future<DocumentSnapshot<Map<String, dynamic>>> userData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('User').doc(uid).get();
  }

  Future<void> _refreshData() async {
    setState(() {}); // Trigger a rebuild to refresh the FutureBuilder
    await userData(); // Ensure data is fetched
    await Future.delayed(
        const Duration(seconds: 2)); // Maintain delay for UI feedback
  }

  //! Method to handle add card with limit check
  void _handleAddCard(BuildContext context, int cardCount) {
    if (cardCount >= 3) {
      Toastmassage.ErrorToast(context, 'Only 3 cards allowed');
    } else {
      NavigatorTo(context, const NewCardScreen());
    }
  }

  //! Method to get card colors based on card type

  List<Color> _getCardColors(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return [
          const Color(0xff93278F), // Same as NewCardScreen
          const Color(0xff29ABE2) // Same as NewCardScreen
        ];
      case 'mastercard':
        return [
          Colors.orange, // Same as NewCardScreen
          Colors.redAccent // Same as NewCardScreen
        ];
      case 'paypal':
        return [
          const Color(0xff2F2C2C), // Same as NewCardScreen default
          const Color(0xff2F2C2C), // Same as NewCardScreen default

          // Same as NewCardScreen default
          const Color(0xff3F3F3F) // Same as NewCardScreen default
        ];
      default:
        return [
          const Color(0xff2F2C2C), // Same as NewCardScreen default
          const Color(0xff3F3F3F) // Same as NewCardScreen default
        ];
    }
  }

  //! Method to get card brand name
  String _getCardBrand(String cardNo) {
    if (cardNo.startsWith('4')) {
      return 'VISA';
    } else if (cardNo.startsWith('5') || cardNo.startsWith('2')) {
      return 'MASTERCARD';
    } else {
      return 'PAYPAL';
    }
  }

  //! Method to mask card number
  String _maskCardNumber(String cardNo) {
    if (cardNo.length >= 4) {
      String lastFour = cardNo.substring(cardNo.length - 4);
      return 'XXXX XXXX XXXX $lastFour';
    }
    return cardNo;
  }

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: buildAppBar(
          context,
          'Payment',
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          color: MyColor.purple,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: userData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFF8F9FA),
                          MyColor.purple.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor.purple.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.error_outline_rounded,
                              color: MyColor.purple,
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'No Data Found',
                            style: GoogleFonts.poppins(
                              color: MyColor.textBlack,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Please try again later',
                            style: GoogleFonts.poppins(
                              color: MyColor.textBlack.withOpacity(0.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fade(duration: 600.ms);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFFF8F9FA),
                          MyColor.purple.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColor.purple.withOpacity(0.15),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: LoadingAnimationWidget.stretchedDots(
                              color: MyColor.purple,
                              size: 60,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'Loading your cards...',
                            style: GoogleFonts.poppins(
                              color: MyColor.textBlack.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().scale(duration: 500.ms);
                }
                final cards = snapshot.data?.data()?['Cards'] ?? [];

                if (cards.isEmpty) {
                  return _NoCardView(w: w)
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.1);
                }

                // Check if card limit (3) is reached
                bool isCardLimitReached = cards.length >= 3;
                return _CardListView(
                  cards: cards,
                  selectedIndex: selectedIndex,
                  onSelect: (index) => setState(() => selectedIndex = index),
                  onAddCard: isCardLimitReached
                      ? () => _handleAddCard(context, cards.length)
                      : () => NavigatorTo(context, const NewCardScreen()),
                  onSave: () {
                    statusOfCard = 'save';
                    if (navigatedFrom != 'navBar') {
                      NavigatorToReplace(context, const NavBar());
                    }
                  },
                  onDelete: (index) {
                    setState(() {
                      cards.removeAt(index);
                      if (selectedIndex >= cards.length) {
                        selectedIndex = cards.length > 0 ? cards.length - 1 : 0;
                      }
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection('User')
                          .doc(uid)
                          .update({'Cards': cards});
                    });
                  },
                  getCardColors: _getCardColors, // Pass the function itself
                  getCardBrand: _getCardBrand,
                  maskCardNumber: _maskCardNumber,
                ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.05);
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ================================
// ENHANCED CARD LIST VIEW WIDGET
// ================================
class _CardListView extends StatelessWidget {
  final List cards;
  final int selectedIndex;
  final Function(int) onSelect;
  final VoidCallback? onAddCard;
  final VoidCallback onSave;
  final Function(int) onDelete;
  final Function(String) getCardColors; // Corrected to use the passed function
  final Function(String) getCardBrand;
  final Function(String) maskCardNumber;

  const _CardListView({
    required this.cards,
    required this.selectedIndex,
    required this.onSelect,
    required this.onAddCard,
    required this.onSave,
    required this.onDelete,
    required this.getCardColors,
    required this.getCardBrand,
    required this.maskCardNumber,
  });

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width * (1 / 375);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF8F9FA),
            MyColor.purple.withOpacity(0.03),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyColor.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.credit_card_rounded,
                        color: MyColor.purple,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Cards',
                          style: GoogleFonts.poppins(
                            color: MyColor.textBlack,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${cards.length} card${cards.length > 1 ? 's' : ''} available',
                          style: GoogleFonts.poppins(
                            color: MyColor.textBlack.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
          ),

          // Cards Carousel - FIXED HEIGHT
          //!//!//!
          Container(
            height:
                220, // Increased from 220 to 240 to accommodate shadows and padding
            margin: const EdgeInsets.symmetric(vertical: 15),
            child: Consumer<CardTypeProvider>(
              builder: (_, value, __) {
                return ListView.builder(
                  itemCount: cards.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (_, index) {
                    final isSelected = selectedIndex == index;
                    final card = cards[index];

                    final cardType = card['cardType'] ?? 'default';
                    final cardNumber = card['cardNo'] ?? '';
                    final cardColors = getCardColors(cardType
                        .toLowerCase()); // Use the passed getCardColors function
                    final maskedCardNumber = maskCardNumber(cardNumber);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        onTap: () => onSelect(index),
                        child: Stack(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              height: isSelected ? 200 : 185,
                              width: isSelected ? 320 : 300,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: isSelected
                                      ? cardColors
                                      : [
                                          cardColors[0].withOpacity(0.8),
                                          cardColors[1].withOpacity(0.8),
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected
                                        ? cardColors[0].withOpacity(0.4)
                                        : Colors.black.withOpacity(0.1),
                                    blurRadius: isSelected ? 25 : 15,
                                    offset: Offset(0, isSelected ? 12 : 8),
                                  ),
                                ],
                                border: isSelected
                                    ? Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Container(
                                height: isSelected ? 220 : 210,
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Top row with SIM chip and card brand
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SIM Chip
                                        SvgPicture.asset(
                                          'assets/images/sim.svg',
                                          height: 40,
                                          width: 40,
                                        ),

                                        // Card Brand
                                        Text(
                                          (card['cardType'] ?? 'CARD')
                                              .toString()
                                              .toUpperCase(), // Display the exact card type
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    // Card Number
                                    Text(
                                      maskedCardNumber,
                                      style: GoogleFonts.robotoMono(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const Spacer(),
                                    // Bottom row with name and expiry
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Card Holder Name
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'CARD HOLDER',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              (card['name'] ?? 'CARD HOLDER')
                                                  .toString()
                                                  .toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Expiry Date
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'VALID CARD',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              card['exp'] ?? 'MM/YY',
                                              style: GoogleFonts.robotoMono(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Selection indicator
                            if (isSelected)
                              Positioned(
                                top: 15,
                                right: 15,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.check_circle_rounded,
                                    color: cardColors[0],
                                    size: 20,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                        .animate()
                        .scale(
                          duration: 400.ms,
                          curve: Curves.easeOut,
                          delay: (index * 100).ms,
                        )
                        .fadeIn(delay: (index * 100).ms);
                  },
                );
              },
            ),
          ),

          // Card Details Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet_rounded,
                      color: MyColor.purple,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Card Details',
                      style: GoogleFonts.poppins(
                        color: MyColor.textBlack,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        onDelete(selectedIndex);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _EnhancedPaymentCard(
                  icon: Icons.person_outline_rounded,
                  title: 'Card Owner',
                  data: cards[selectedIndex]['name'],
                ),
                const SizedBox(height: 15),
                _EnhancedPaymentCard(
                  icon: Icons.credit_card_outlined,
                  title: 'Card Number',
                  data: cards[selectedIndex]['cardNo'],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _EnhancedPaymentCard(
                        icon: Icons.date_range_outlined,
                        title: 'Exp',
                        data: cards[selectedIndex]['exp'],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _EnhancedPaymentCard(
                        icon: Icons.security_rounded,
                        title: 'CVV',
                        data: cards[selectedIndex]['cvv'],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .slideY(begin: 0.1),

          const SizedBox(height: 25),

          // Add New Card Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _AddCardButton(onTap: onAddCard ?? () {}),
          ),

          const SizedBox(height: 25),

          // Save Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    MyColor.purple,
                    MyColor.purple.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: MyColor.purple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onSave,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.save_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Save Card',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().scale(duration: 400.ms, delay: 400.ms).fadeIn(),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ================================
// ENHANCED PAYMENT CARD WIDGET
// ================================
class _EnhancedPaymentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;

  const _EnhancedPaymentCard({
    required this.icon,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: MyColor.purple.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MyColor.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: MyColor.purple,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: MyColor.textBlack.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data,
                  style: GoogleFonts.poppins(
                    color: MyColor.textBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================
// ENHANCED ADD CARD BUTTON WIDGET
// ================================
class _AddCardButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddCardButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: MyColor.purple,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColor.purple.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColor.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add New Card',
                  style: GoogleFonts.poppins(
                    color: MyColor.purple,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(delay: 100.ms);
  }
}

// ================================
// ENHANCED NO CARD VIEW WIDGET
// ================================
class _NoCardView extends StatelessWidget {
  final double w;

  const _NoCardView({required this.w});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF8F9FA),
            MyColor.purple.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyColor.purple.withOpacity(0.1),
                  MyColor.purple.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: MyColor.purple.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: const Icon(
              Icons.credit_card_off_rounded,
              color: MyColor.purple,
              size: 80,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'No Cards Added',
            style: GoogleFonts.poppins(
              color: MyColor.textBlack,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add your first payment card to get started\nwith secure transactions',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: MyColor.textBlack.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: _AddCardButton(
              onTap: () => NavigatorTo(context, const NewCardScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
