// // home_screen.dart

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:laza/Providers/home-provider.dart';
// import 'package:laza/Providers/search_provider.dart';
// import 'package:laza/Providers/wishList_provider.dart';
// import 'package:laza/Resources/NavigationBar/nav_bar.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Resources/Paths/imports.dart';
// import 'package:laza/Resources/Widgets/drawerTile.dart';
// import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
// import 'package:laza/Veiw/shoping_screen/all_arrival_screen.dart';
// import 'package:laza/Veiw/cart_screen.dart';
// import 'package:laza/Veiw/favirate_list_screen.dart';
// import 'package:laza/Veiw/payment_screen.dart';
// import 'package:laza/Veiw/product_detail_screen.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import '../Firebase/Auth/logout_auth.dart';
// import '../Models/new_arrival_model.dart';
// import '../Providers/theme_provider.dart';
// import '../Resources/MediaQuery/media_query.dart';
// import '../Resources/Paths/AssetsPath.dart';
// import '../ai_bot_module/chat_view.dart';

// // Enhanced Color Scheme
// class MediCareColors {
//   static const Color primaryTeal = Color(0xFF00695C);
//   static const Color lightTeal = Color(0xFF4DB6AC);
//   static const Color accentTeal = Color(0xFF26A69A);
//   static const Color backgroundColor = Color(0xFFF0F9F8);
//   static const Color cardBackground = Colors.white;
//   static const Color textPrimary = Color(0xFF263238);
//   static const Color textSecondary = Color(0xFF546E7A);
//   static const Color textLight = Color(0xFF78909C);
//   static const Color errorColor = Color(0xFFE57373);
//   static const Color shadowColor = Color(0x1A000000);
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// class _HomeScreenState extends State<HomeScreen> {
//   TextEditingController searchController = TextEditingController();
//   final snapshotRef =
//       FirebaseFirestore.instance.collection('MedCareProducts').snapshots();
//   final _auth = FirebaseAuth.instance;

//   Future<DocumentSnapshot<Map<String, dynamic>>> UserData() async {
//     final String userId = _auth.currentUser!.uid.toString();
//     final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
//     return await userRef.get();
//   }

//   @override
//   void initState() {
//     super.initState();
//     final homeProvider =
//         Provider.of<HomeScreenProvvider>(context, listen: false);
//     homeProvider.getProduct();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final homeProvider = Provider.of<HomeScreenProvvider>(context);

//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldKey,
//         backgroundColor: MediCareColors.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: MediCareColors.backgroundColor,
//           elevation: 0,
//           toolbarHeight: 80,
//           leading: Padding(
//             padding: const EdgeInsets.only(left: 16),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () => _scaffoldKey.currentState!.openDrawer(),
//               child: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: MediCareColors.cardBackground,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: MediCareColors.shadowColor,
//                       blurRadius: 4,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: SvgPicture.asset(Images.menu,
//                     height: 24, color: MediCareColors.textPrimary),
//               ),
//             ),
//           ),
//           actions: [
//             InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 navigatedFrom = '';
//                 NavigatorTo(context, const CartScreen());
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 20),
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: MediCareColors.cardBackground,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: MediCareColors.shadowColor,
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Image.asset(PngImages.Cart, height: 24, width: 24),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         drawer: _buildEnhancedDrawer(),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildGreeting(),
//               const SizedBox(height: 20),
//               _buildSearchBar(context, homeProvider),
//               const SizedBox(height: 20),
//               _buildSectionHeader('Medications', 'View All'),
//               const SizedBox(height: 12),
//               _buildProductGrid(),
//             ],
//           ),
//         ),
//         floatingActionButton: _buildEnhancedAIButton(context),
//       ),
//     );
//   }

//   Widget _buildGreeting() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text(
//           'Hello',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w700,
//             color: MediCareColors.textPrimary,
//             fontFamily: 'Inter',
//           ),
//         ),
//         Text(
//           'Welcome to MediCare',
//           style: TextStyle(
//             fontSize: 16,
//             color: MediCareColors.textLight,
//             fontFamily: 'Inter',
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSearchBar(
//       BuildContext context, HomeScreenProvvider homeProvider) {
//     return Container(
//       decoration: BoxDecoration(
//         color: MediCareColors.cardBackground,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: MediCareColors.shadowColor,
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextFormField(
//         controller: searchController,
//         onChanged: (val) => homeProvider.search(val.toString().toLowerCase()),
//         decoration: InputDecoration(
//           hintText: 'Search medications...',
//           hintStyle: const TextStyle(
//             color: MediCareColors.textLight,
//             fontSize: 16,
//             fontFamily: 'Inter',
//           ),
//           border: InputBorder.none,
//           prefixIcon: Padding(
//             padding: const EdgeInsets.all(12),
//             child: SvgPicture.asset(Images.search,
//                 height: 20, color: MediCareColors.textSecondary),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title, String actionText) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: MediCareColors.primaryTeal,
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//             fontFamily: 'Inter',
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             NavigatorTo(context, const AllArrivalScreen());
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: MediCareColors.primaryTeal.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               actionText,
//               style: const TextStyle(
//                 color: MediCareColors.primaryTeal,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14,
//                 fontFamily: 'Inter',
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProductGrid() {
//     return SizedBox(
//       height: getScreenSize(context).height - 300,
//       child: Consumer<HomeScreenProvvider>(
//         builder: (context, homevalue, child) {
//           List<NewArrivalModel> data = homevalue.productdata;
//           if (data.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.search_off,
//                     size: 64,
//                     color: MediCareColors.textLight,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'No Products Found',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontFamily: 'Inter',
//                       fontWeight: FontWeight.w600,
//                       color: MediCareColors.textSecondary,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Try adjusting your search',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: 'Inter',
//                       color: MediCareColors.textLight,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return GridView.builder(
//             physics: const BouncingScrollPhysics(),
//             itemCount: data.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 14,
//               crossAxisSpacing: 14,
//               mainAxisExtent: 300,
//             ),
//             itemBuilder: (context, index) {
//               return InkWell(
//                 borderRadius: BorderRadius.circular(16),
//                 onTap: () {
//                   NavigatorTo(
//                     context,
//                     ProductDetailScreen(
//                       Productprice: data[index].Productprice,
//                       Producttype: data[index].Producttype,
//                       Productname: data[index].Productname,
//                       ProductimagePath: data[index].ProductimagePath,
//                       Size: data[index].Size,
//                       Productdescription: data[index].Productdescription,
//                       ProductReviews: data[index].Reviews,
//                       ProductId: data[index].ProductId,
//                     ),
//                   );
//                 },
//                 child: Consumer<WishlistProvider>(
//                   builder: (context, wishlist, _) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         color: MediCareColors.cardBackground,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: MediCareColors.shadowColor,
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           )
//                         ],
//                       ),
//                       child: NewArrivalTile(
//                         image: data[index].ProductimagePath,
//                         description: data[index].Productdescription,
//                         type: data[index].Producttype,
//                         price: data[index].Productprice,
//                         productId: data[index].ProductId,
//                         position: index,
//                         name: data[index].Productname,
//                         Size: data[index].Size,
//                         reviews: data[index].Reviews,
//                         brand: data[index].ProductBrand,
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEnhancedDrawer() {
//     return Drawer(
//       backgroundColor: MediCareColors.backgroundColor,
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   MediCareColors.primaryTeal,
//                   MediCareColors.lightTeal,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'Menu',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                         fontFamily: 'Inter',
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => NavigatorPop(context),
//                       child: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.close,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                   future: UserData(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasError) {
//                       return const Text(
//                         'No Data found',
//                         style: TextStyle(color: Colors.white70),
//                       );
//                     } else if (snapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return LoadingAnimationWidget.stretchedDots(
//                         color: Colors.white,
//                         size: 20,
//                       );
//                     } else {
//                       final user = snapshot.data!.data()!;
//                       return Row(
//                         children: [
//                           Container(
//                             height: 60,
//                             width: 60,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               image: DecorationImage(
//                                 image: NetworkImage(user['profileImage']),
//                                 fit: BoxFit.cover,
//                               ),
//                               border: Border.all(
//                                 color: Colors.white,
//                                 width: 2,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 15),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   user['Name'],
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                                 Text(
//                                   user['Email'],
//                                   style: const TextStyle(
//                                     color: Colors.white70,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   _buildDrawerItem(
//                     icon: Icons.shopping_bag_outlined,
//                     title: 'My Orders',
//                     onTap: () => NavigatorTo(context, const CartScreen()),
//                   ),
//                   _buildDrawerItem(
//                     icon: Icons.credit_card,
//                     title: 'Payment Methods',
//                     onTap: () => NavigatorTo(context, const PaymentScreen()),
//                   ),
//                   _buildDrawerItem(
//                     icon: Icons.favorite_outline,
//                     title: 'Wishlist',
//                     onTap: () =>
//                         NavigatorTo(context, const FavirateListScreen()),
//                   ),
//                   const Spacer(),
//                   _buildDrawerItem(
//                     icon: Icons.logout,
//                     title: 'Logout',
//                     onTap: () => logoutAuth(context),
//                     isDestructive: true,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     bool isDestructive = false,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: isDestructive
//               ? MediCareColors.errorColor
//               : MediCareColors.primaryTeal,
//           size: 24,
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             color: isDestructive
//                 ? MediCareColors.errorColor
//                 : MediCareColors.textPrimary,
//             fontWeight: FontWeight.w500,
//             fontSize: 16,
//             fontFamily: 'Inter',
//           ),
//         ),
//         onTap: onTap,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         tileColor: MediCareColors.cardBackground,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//     );
//   }

//   Widget _buildEnhancedAIButton(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const AIChatView()),
//         );
//       },
//       backgroundColor: MediCareColors.primaryTeal,
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(28),
//       ),
//       child: const Icon(
//         Icons.smart_toy_rounded,
//         color: Colors.white,
//         size: 28,
//       ),
//     );
//   }
// }

//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::
//!              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        |
//!              --------------------------------------        |
//!              **************************************        |
//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Home/provider/home-provider.dart';
import 'package:laza/Features/WishList/providers/wishList_provider.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
import 'package:laza/Features/Home/screen/all_arrival_screen.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Features/WishList/screens/favirate_list_screen.dart';
import 'package:laza/Features/Card/Screens/payment_screen.dart';
import 'package:laza/Features/Product_DetailScreen/screen/product_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../Auth/logout_auth.dart';
import '../../../Models/new_arrival_model.dart';
import '../../../Resources/MediaQuery/media_query.dart';
import '../../ai_bot_module/chat_view.dart';

// Enhanced Color Scheme
class MediCareTheme {
  static const Color primaryTeal = Color(0xFF00695C);
  static const Color lightTeal = Color(0xFF4DB6AC);
  static const Color accentTeal = Color(0xFF26A69A);
  static const Color backgroundColor = Color(0xFFF8FFFE);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF9E9E9E);
  static const Color errorColor = Color(0xFFE57373);
  static const Color successColor = Color(0xFF4CAF50);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x15000000);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final snapshotRef =
      FirebaseFirestore.instance.collection('MedCareProducts').snapshots();
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> UserData() async {
    final String userId = _auth.currentUser!.uid.toString();
    final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
    return await userRef.get();
  }

  @override
  void dispose() {
    searchController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeprovider = Provider.of<ThemeProvider>(context);
    final homeProvider =
        Provider.of<HomeScreenProvvider>(context, listen: false);
    homeProvider.getProduct(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: MediCareTheme.accentTeal.withAlpha(10),
        backgroundColor: MediCareTheme.lightTeal.withOpacity(0.1),

        key: _scaffoldKey,
        // backgroundColor: MediCareTheme.backgroundColor,
        appBar: _buildEnhancedAppBar(),
        drawer: _buildModernDrawer(context),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                homeProvider.getProduct(context);
              },
              color: MediCareTheme.primaryTeal,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHeroSection(),
                    const SizedBox(height: 30),
                    _buildContentSection(),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: _buildAIFloatingButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: MediCareTheme.backgroundColor,
      toolbarHeight: 70,
      leading: Container(
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
          onTap: () => _scaffoldKey.currentState!.openDrawer(),
          child: const Icon(
            Icons.menu_rounded,
            color: MediCareTheme.primaryTeal,
            size: 24,
          ),
        ),
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MediCareTheme.primaryTeal.withOpacity(0.1),
              MediCareTheme.lightTeal.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: MediCareTheme.primaryTeal,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_hospital,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'MediCare',
              style: GoogleFonts.poppins(
                color: MediCareTheme.primaryTeal,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                // fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
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
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            MediCareTheme.primaryTeal,
            MediCareTheme.lightTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: MediCareTheme.primaryTeal.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello! 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your health is our priority',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        // fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.local_pharmacy,
                    color: MediCareTheme.primaryTeal,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Quick delivery • Genuine medicines',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 11.7,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildSearchSection(),
          const SizedBox(height: 24),
          _buildQuickActionsGrid(),
          const SizedBox(height: 30),
          _buildSectionHeader(),
          const SizedBox(height: 16),
          _buildProductGrid(),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      decoration: BoxDecoration(
        color: MediCareTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: MediCareTheme.shadowMedium,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: (val) {
          final homeProvider =
              Provider.of<HomeScreenProvvider>(context, listen: false);
          homeProvider.search(val.toString().toLowerCase());
        },
        decoration: InputDecoration(
          hintText: 'Search medicines, supplements...',
          hintStyle: GoogleFonts.poppins(
            color: MediCareTheme.textLight,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: MediCareTheme.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: MediCareTheme.primaryTeal,
              width: 2,
            ),
          ),
          prefixIcon: Container(
            padding: const EdgeInsets.all(16),
            child: const Icon(
              Icons.search,
              color: MediCareTheme.primaryTeal,
              size: 24,
            ),
          ),
          suffixIcon: searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: MediCareTheme.textLight,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            icon: CupertinoIcons.chat_bubble_2_fill,

            willingSize: 28,
            title: 'Ai Chatbot',
            color: MediCareTheme.accentTeal,
            // color: Colors.red,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.local_pharmacy,
            willingSize: 28,
            title: 'pharmacy',
            color: Colors.red,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionCard(
            icon: Icons.schedule,
            willingSize: 28,
            title: 'Delivery',
            // color: MediCareTheme.successColor,
            color: MediCareTheme.textPrimary,

            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
    required double willingSize,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MediCareTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: MediCareTheme.shadowLight,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: willingSize,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: MediCareTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                // fontFamily: 'Inter',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Featured Medications',
              style: GoogleFonts.poppins(
                color: MediCareTheme.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 22,
                // fontFamily: 'Inter',
              ),
            ),
            Text(
              'Trusted and verified products',
              style: GoogleFonts.poppins(
                color: MediCareTheme.textSecondary,
                fontSize: 14,
                // fontFamily: 'Inter',
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => NavigatorTo(context, const AllArrivalScreen()),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MediCareTheme.primaryTeal.withOpacity(0.1),
                  MediCareTheme.lightTeal.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: MediCareTheme.primaryTeal.withOpacity(0.3),
              ),
            ),
            child: Text(
              'View All',
              style: GoogleFonts.poppins(
                color: MediCareTheme.primaryTeal,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

// 8BDDBB
  Widget _buildProductGrid() {
    return SizedBox(
      height: getScreenSize(context).height - 400,
      child: Consumer<HomeScreenProvvider>(
        builder: (context, homevalue, _) {
          List<NewArrivalModel> data = homevalue.productdata;
          if (data.isEmpty) {
            return _buildEmptyState();
          }
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 300,
            ),
            itemBuilder: (context, index) {
              return _buildProductCard(data[index], index);
            },
          );
        },
      ),
    );
  }

  Widget _buildProductCard(NewArrivalModel product, int index) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        NavigatorTo(
          context,
          ProductDetailScreen(
            Productprice: product.Productprice,
            Producttype: product.Producttype,
            Productname: product.Productname,
            ProductimagePath: product.ProductimagePath,
            Size: product.Size,
            Productdescription: product.Productdescription,
            ProductReviews: product.Reviews,
            ProductId: product.ProductId,
          ),
        );
      },

      //!
      child: Consumer<WishlistProvider>(
        builder: (context, wishlist, _) {
          return NewArrivalTile(
            //! Resource/Widgets/new_arrival_tile.dart
            image: product.ProductimagePath,
            description: product.Productdescription,
            type: product.Producttype,
            price: product.Productprice,
            productId: product.ProductId,
            position: index,
            name: product.Productname,
            size: product.Size,
            reviews: product.Reviews,
            brand: product.ProductBrand,
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: MediCareTheme.primaryTeal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off,
              size: 64,
              color: MediCareTheme.textLight,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Products Found',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: MediCareTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your search terms',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Inter',
              color: MediCareTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: _buildDrawerContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MediCareTheme.primaryTeal,
            MediCareTheme.lightTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MediCare',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => NavigatorPop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: UserData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'No Data found',
                  style: GoogleFonts.poppins(color: Colors.white70),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingAnimationWidget.stretchedDots(
                  color: Colors.white,
                  size: 20,
                );
              } else {
                return Row(
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(
                              snapshot.data!.data()!['profileImage']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.data()!['Name'],
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            overflow: TextOverflow.ellipsis,
                            snapshot.data!.data()!['Email'],
                            style: GoogleFonts.poppins(
                              color: Colors.white70,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildDrawerItem(
            icon: Icons.shopping_bag_outlined,
            title: 'My Orders',
            onTap: () => NavigatorTo(context, const CartScreen()),
          ),
          _buildDrawerItem(
            icon: Icons.credit_card,
            title: 'Payment Methods',
            onTap: () {
              navigatedFrom = '';
              NavigatorTo(context, const PaymentScreen());
            },
          ),
          _buildDrawerItem(
            icon: Icons.favorite_outline,
            title: 'Wishlist',
            onTap: () {
              navigatedFrom = '';
              NavigatorTo(context, const FavirateListScreen());
            },
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () => logoutAuth(context),
              isDestructive: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive
                ? MediCareTheme.errorColor.withOpacity(0.1)
                : MediCareTheme.primaryTeal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDestructive
                ? MediCareTheme.errorColor
                : MediCareTheme.primaryTeal,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: isDestructive
                ? MediCareTheme.errorColor
                : MediCareTheme.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildAIFloatingButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: MediCareTheme.primaryTeal.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          


          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AIChatView()),
          );
        },
        backgroundColor: MediCareTheme.primaryTeal,
        elevation: 0,
        child: const Icon(
          Icons.smart_toy_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
