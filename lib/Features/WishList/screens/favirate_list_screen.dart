
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/WishList/providers/wishList_provider.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
import 'package:laza/Features/Home/screen/home_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../Resources/NavigationBar/nav_bar.dart';
import '../../../Resources/Paths/imports.dart';
import '../../Cart/Screens/cart_screen.dart';
import '../../Product_DetailScreen/screen/product_detail_screen.dart';

class FavirateListScreen extends StatefulWidget {
  const FavirateListScreen({super.key});

  @override
  State<FavirateListScreen> createState() => _FavirateListScreenState();
}

class _FavirateListScreenState extends State<FavirateListScreen> {
  final snapshotRef = FirebaseFirestore.instance
      .collection('Wishlist')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('WishlistItem')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    final w = getScreenSize(context).width / 375;
    // final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xFFFAFAFA),
        backgroundColor: MediCareTheme.lightTeal,

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                'My Wishlist',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: -0.3,
                ),
              ),
              centerTitle: true,
              toolbarHeight: 90,
              // leading: (navigatedFrom == 'navBar')
              //     ? const SizedBox()
              //     : Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: InkWell(
              //           splashColor: Colors.transparent,
              //           borderRadius: BorderRadius.circular(25),
              //           onTap: () => NavigatorPop(context),
              //           child: Container(
              //             height: 45,
              //             width: 45,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: const Color(0xFFF5F5F5),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.08),
              //                   blurRadius: 8,
              //                   offset: const Offset(0, 2),
              //                 ),
              //               ],
              //             ),
              //             child: const Icon(
              //               Icons.arrow_back_ios_new_rounded,
              //               size: 20,
              //               color: Color(0xFF1A1A1A),
              //             ),
              //           ),
              //         ),
              //       ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MediCareTheme.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: MediCareTheme.shadowLight,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      navigatedFrom = '';
                      NavigatorTo(context, const CartScreen());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            color: MediCareTheme.primaryTeal,
                            size: 24,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: MediCareTheme.errorColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
          child: Consumer<WishlistProvider>(
            builder: (context, value, child) {
              return StreamBuilder<QuerySnapshot>(
                stream: snapshotRef,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              color: Colors.red.shade400,
                              size: 48,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Oops! Something went wrong',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF1A1A1A),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please try again later',
                              style: GoogleFonts.poppins(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 400.ms).scale();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: MyColor.purple.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LoadingAnimationWidget.stretchedDots(
                              color: MyColor.purple,
                              size: 60,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Loading your wishlist...',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF666666),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().scale(duration: 300.ms).fadeIn();
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return Center(
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 200 * w,
                              width: 200 * w,
                              child: Lottie.asset(
                                Animations.emptybox,
                                repeat: true,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Your wishlist is empty',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1A1A1A),
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Start adding items you love to see them here',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF666666),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    MyColor.purple,
                                    MyColor.purple.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: MyColor.purple.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Start Shopping',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 500.ms).slideY();
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section with enhanced styling
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
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
                                  Icons.favorite_rounded,
                                  color: MyColor.red,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${docs.length} ${docs.length == 1 ? 'item' : 'items'}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: const Color(0xFF1A1A1A),
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    Text(
                                      'In your wishlist',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: const Color(0xFF666666),
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
                                  color: MyColor.purple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '❤️ Saved',
                                  style: GoogleFonts.poppins(
                                    color: MyColor.purple,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 300.ms).scale(),

                        const SizedBox(height: 24),

                        // Grid Section
                        Expanded(
                          child: GridView.builder(
                            itemCount: docs.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 12,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (context, index) {
                              final item = docs[index];

                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  NavigatorTo(
                                    context,
                                    ProductDetailScreen(
                                      Productprice: item['Productprice'],
                                      Producttype: item['Producttype'],
                                      Productname: item['Productname'],
                                      ProductimagePath:
                                          item['ProductimagePath'],
                                      Size: item['Size'],
                                      Productdescription:
                                          item['Productdescription'],
                                      ProductReviews: item['ProductReviews'],
                                      ProductId: item['ProductId'],
                                    ),
                                  );
                                },

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: NewArrivalTile(
                                    //! Resource/Widgets/new_arrival_tile.dart
                                    favProductId: item['ProductId'],
                                    image: item['ProductimagePath'],
                                    description: item['Productdescription'],
                                    type: item['Producttype'],
                                    price: item['Productprice'],
                                    productId: item['ProductId'].toString(),
                                    position: index,
                                    name: item['Productname'],
                                    size: item['Size'],
                                    reviews: item['ProductReviews'],
                                    brand: item['Productbrand'],
                                  ),
                                ),
                                // ),
                              )
                                  .animate()
                                  .fadeIn(delay: (index * 100).ms)
                                  .scale(
                                    delay: (index * 100).ms,
                                    curve: Curves.easeOutBack,
                                  )
                                  .slideY(
                                    begin: 0.3,
                                    delay: (index * 100).ms,
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
