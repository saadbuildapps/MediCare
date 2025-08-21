//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::
//!              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        |
//!              --------------------------------------        |
//!              **************************************        |
//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:laza/Resources/Navigators/navigators.dart';
// import 'package:laza/Features/Product_DetailScreen/screen/product_detail_screen.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:provider/provider.dart';
// import '../../WishList/providers/wishList_provider.dart';
// import '../../../Resources/Widgets/new_arrival_tile.dart';

// // Enhanced Theme Colors
// class MediCareTheme {
//   static const Color primaryTeal = Color(0xFF00695C);
//   static const Color lightTeal = Color(0xFF4DB6AC);
//   static const Color accentTeal = Color(0xFF26A69A);
//   static const Color backgroundColor = Color(0xFFF8FFFE);
//   static const Color cardBackground = Colors.white;
//   static const Color textPrimary = Color(0xFF1A1A1A);
//   static const Color textSecondary = Color(0xFF666666);
//   static const Color textLight = Color(0xFF9E9E9E);
//   static const Color errorColor = Color(0xFFE57373);
//   static const Color shadowLight = Color(0x0A000000);
//   static const Color shadowMedium = Color(0x15000000);
// }

// class AllArrivalScreen extends StatefulWidget {
//   const AllArrivalScreen({super.key});

//   @override
//   State<AllArrivalScreen> createState() => _AllArrivalScreenState();
// }

// class _AllArrivalScreenState extends State<AllArrivalScreen>
//     with TickerProviderStateMixin {
//   final snapshotRef =
//       FirebaseFirestore.instance.collection('MedCareProducts').snapshots();

//   late AnimationController _fadeController;
//   late AnimationController _slideController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;

//   String selectedFilter = 'All';
//   bool isGridView = true;

//   final List<String> filterOptions = [
//     'All',
//     'Medicine',
//     'Medical Kit',
//     'Others',
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _initAnimations();
//   }

//   void _initAnimations() {
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _slideController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(
//         CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

//     _fadeController.forward();
//     _slideController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _slideController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: MediCareTheme.backgroundColor,
//         appBar: _buildEnhancedAppBar(),
//         body: FadeTransition(
//           opacity: _fadeAnimation,
//           child: SlideTransition(
//             position: _slideAnimation,
//             child: Column(
//               children: [
//                 _buildHeaderSection(),
//                 _buildFilterSection(),
//                 Expanded(child: _buildProductSection()),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildEnhancedAppBar() {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: MediCareTheme.backgroundColor,
//       toolbarHeight: 70,
//       leading: Container(
//         margin: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: MediCareTheme.cardBackground,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: const [
//             BoxShadow(
//               color: MediCareTheme.shadowLight,
//               blurRadius: 10,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () => NavigatorPop(context),
//           child: const Icon(
//             Icons.arrow_back_rounded,
//             color: MediCareTheme.primaryTeal,
//             size: 24,
//           ),
//         ),
//       ),
//       title: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               MediCareTheme.primaryTeal.withOpacity(0.1),
//               MediCareTheme.lightTeal.withOpacity(0.1),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Text(
//           'All Products',
//           style: GoogleFonts.poppins(
//             color: MediCareTheme.primaryTeal,
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       centerTitle: true,
//       actions: [
//         Container(
//           margin: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: MediCareTheme.cardBackground,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: const [
//               BoxShadow(
//                 color: MediCareTheme.shadowLight,
//                 blurRadius: 10,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(16),
//             onTap: () {
//               setState(() {
//                 isGridView = !isGridView;
//               });
//             },
//             child: Container(
//               padding: const EdgeInsets.all(12),
//               child: Icon(
//                 isGridView ? Icons.view_list : Icons.grid_view,
//                 color: MediCareTheme.primaryTeal,
//                 size: 24,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeaderSection() {
//     return Container(
//       margin: const EdgeInsets.all(20),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [
//             MediCareTheme.primaryTeal,
//             MediCareTheme.lightTeal,
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: MediCareTheme.primaryTeal.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Discover',
//                   style: GoogleFonts.poppins(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Quality healthcare products',
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: const Icon(
//               Icons.medical_services,
//               color: Colors.white,
//               size: 32,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFilterSection() {
//     return Container(
//       height: 60,
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: filterOptions.length,
//         itemBuilder: (context, index) {
//           final isSelected = selectedFilter == filterOptions[index];
//           return Container(
//             margin: const EdgeInsets.only(right: 12),
//             child: InkWell(
//               borderRadius: BorderRadius.circular(20),
//               onTap: () {
//                 setState(() {
//                   selectedFilter = filterOptions[index];
//                 });
//               },
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 decoration: BoxDecoration(
//                   gradient: isSelected
//                       ? const LinearGradient(
//                           colors: [
//                             MediCareTheme.primaryTeal,
//                             MediCareTheme.lightTeal,
//                           ],
//                         )
//                       : null,
//                   color: isSelected ? null : MediCareTheme.cardBackground,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: [
//                     BoxShadow(
//                       color: isSelected
//                           ? MediCareTheme.primaryTeal.withOpacity(0.3)
//                           : MediCareTheme.shadowLight,
//                       blurRadius: isSelected ? 15 : 8,
//                       offset: Offset(0, isSelected ? 6 : 2),
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   filterOptions[index],
//                   style: GoogleFonts.poppins(
//                     color:
//                         isSelected ? Colors.white : MediCareTheme.textSecondary,
//                     fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductSection() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//       child: StreamBuilder<QuerySnapshot>(
//         stream: snapshotRef,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return _buildErrorWidget();
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return _buildLoadingWidget();
//           }

//           // Saare products firestore se
//           final allProducts = snapshot.data!.docs;

//           // Filter apply karo according to selectedFilter
//           final products = selectedFilter == 'All'
//               ? allProducts
//               : allProducts.where((doc) {
//                   final type = (doc['type'] as String).toLowerCase();

//                   if (selectedFilter == 'Medical Kit') {
//                     return type == 'medicalkit';
//                   } else if (selectedFilter == 'Others') {
//                     return type == 'others';
//                   } else if (selectedFilter == 'Medicine') {
//                     // jitne bhi medicalkit/others nahi hain unhe Medicine me dikhana
//                     return type != 'medicalkit' && type != 'others';
//                   }
//                   return true;
//                 }).toList();

//           if (products.isEmpty) {
//             return _buildEmptyWidget();
//           }

//           return RefreshIndicator(
//             onRefresh: () async {
//               await Future.delayed(const Duration(seconds: 1));
//             },
//             color: MediCareTheme.primaryTeal,
//             child: isGridView
//                 ? _buildGridView(products)
//                 : _buildListView(products),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildGridView(List<QueryDocumentSnapshot> products) {
//     return GridView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: products.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         mainAxisExtent: 300,
//       ),
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return _buildProductGridCard(product, index);
//       },
//     );
//   }

//   Widget _buildListView(List<QueryDocumentSnapshot> products) {
//     return ListView.builder(
//       physics: const BouncingScrollPhysics(),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index];
//         return _buildProductListCard(product, index);
//       },
//     );
//   }

//   Widget _buildProductGridCard(QueryDocumentSnapshot product, int index) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(24),
//       onTap: () {
//         NavigatorTo(
//           context,
//           ProductDetailScreen(
//             Productprice: product['price'],
//             Producttype: product['type'],
//             Productname: product['name'],
//             ProductimagePath: product['images'],
//             Size: product['sizes'],
//             Productdescription: product['description'],
//             ProductReviews: product['reviews'],
//             ProductId: product['ProductId'],
//           ),
//         );
//       },
//       child: Consumer<WishlistProvider>(
//         builder: (context, wishlist, _) {
//           return NewArrivalTile(
//             //! Resource/Widgets/new_arrival_tile.dart
//             image: product['images'],
//             description: product['description'],
//             type: product['type'],
//             price: product['price'],
//             productId: product['ProductId'].toString(),
//             position: index,
//             name: product['name'],
//             size: product['sizes'],
//             reviews: product['reviews'],
//             brand: product['brand'],
//           );
//         },
//       ),
//     ).animate().fade(duration: 600.ms, delay: (100 * index).ms).scale(
//         begin: const Offset(0.9, 0.9),
//         end: const Offset(1, 1),
//         duration: 500.ms);
//   }

//   Widget _buildProductListCard(QueryDocumentSnapshot product, int index) {
//     // Safely handle images
//     final List<dynamic> images = product['images'] ?? [];
//     final provider = Provider.of<WishlistProvider>(context, listen: false);

//     final String imageUrl = images.isNotEmpty
//         ? images[0] as String
//         : 'https://via.placeholder.com/150';

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: MediCareTheme.cardBackground,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: const [
//           BoxShadow(
//             color: MediCareTheme.shadowLight,
//             blurRadius: 15,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(20),
//         onTap: () {
//           NavigatorTo(
//             context,
//             ProductDetailScreen(
//               Productprice: product['price'],
//               Producttype: product['type'],
//               Productname: product['name'],
//               ProductimagePath: [imageUrl],
//               Size: product['sizes'],
//               Productdescription: product['description'],
//               ProductReviews: product['reviews'],
//               ProductId: product['ProductId'],
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 height: 80,
//                 width: 80,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product['name'],
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 20,
//                         color: MediCareTheme.textPrimary,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       product['type'],
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         color: MediCareTheme.textSecondary,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: MediCareTheme.primaryTeal.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             '\$${product['price']}',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: MediCareTheme.primaryTeal,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     )
//         .animate()
//         .fade(duration: 600.ms, delay: (80 * index).ms)
//         .slideX(begin: 0.2, end: 0, duration: 500.ms);
//   }

//   Widget _buildLoadingWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           LoadingAnimationWidget.stretchedDots(
//             color: MediCareTheme.primaryTeal,
//             size: 50,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Loading products...',
//             style: GoogleFonts.poppins(
//               color: MediCareTheme.textSecondary,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: MediCareTheme.errorColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.error_outline,
//               size: 64,
//               color: MediCareTheme.errorColor,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'Something went wrong 😕',
//             style: GoogleFonts.poppins(
//               color: MediCareTheme.errorColor,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Please try again later',
//             style: GoogleFonts.poppins(
//               color: MediCareTheme.textSecondary,
//               fontSize: 14,
//             ),
//           ),
//           const SizedBox(height: 24),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {});
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: MediCareTheme.primaryTeal,
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//             child: const Text(
//               'Retry',
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyWidget() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: MediCareTheme.primaryTeal.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: const Icon(
//               Icons.inventory_2_outlined,
//               size: 64,
//               color: MediCareTheme.textLight,
//             ),
//           ),
//           const SizedBox(height: 24),
//           Text(
//             'No Products Found',
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: MediCareTheme.textSecondary,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Check back soon for new arrivals',
//             style: GoogleFonts.poppins(
//               fontSize: 14,
//               color: MediCareTheme.textLight,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//!::::::::::::::::::::   Responsive AllArrivalScreen   :::::::::::::::::::
//! Pehla: UI mobile ke liye optimize thi, web par stretched aur cramped dikhti thi
//! Ab: Responsive breakpoints add kiye (mobile, tablet, desktop) aur layouts adjust kiye
//! Faida: Web par professional aur balanced UI, mobile functionality unchanged

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Resources/MediaQuery/media_query.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Features/Product_DetailScreen/screen/product_detail_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../WishList/providers/wishList_provider.dart';
import '../../../Resources/Widgets/new_arrival_tile.dart';

// Enhanced Theme Colors
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
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowMedium = Color(0x15000000);
}

// Utility function to get screen size
// Size getScreenSize(BuildContext context) {
//   return MediaQuery.sizeOf(context);
// }

class AllArrivalScreen extends StatefulWidget {
  const AllArrivalScreen({super.key});

  @override
  State<AllArrivalScreen> createState() => _AllArrivalScreenState();
}

class _AllArrivalScreenState extends State<AllArrivalScreen>
    with TickerProviderStateMixin {
  final snapshotRef =
      FirebaseFirestore.instance.collection('MedCareProducts').snapshots();

  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String selectedFilter = 'All';
  bool isGridView = true;

  final List<String> filterOptions = [
    'All',
    'Medicine',
    'Medical Kit',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MediCareTheme.backgroundColor,
        appBar: _buildEnhancedAppBar(context, screenSize),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              //! Pehla: Column full width le rahi thi, web par stretched dikhta tha
              //! Ab: Center widget aur maxWidth constraint add kia
              //! Faida: Web par content centered aur balanced dikhega
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop
                      ? screenSize.width * 0.8
                      : isTablet
                          ? screenSize.width * 0.9
                          : screenSize.width,
                ),
                child: Column(
                  children: [
                    _buildHeaderSection(context, screenSize),
                    _buildFilterSection(context, screenSize),
                    Expanded(child: _buildProductSection(context, screenSize)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar(
      BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return AppBar(
      elevation: 0,
      backgroundColor: MediCareTheme.backgroundColor,
      toolbarHeight: isDesktop
          ? 80
          : isTablet
              ? 75
              : 70,
      leading: Container(
        margin: EdgeInsets.all(isDesktop
            ? 16
            : isTablet
                ? 14
                : 12),
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
          onTap: () => NavigatorPop(context),
          child: Icon(
            Icons.arrow_back_rounded,
            color: MediCareTheme.primaryTeal,
            size: isDesktop
                ? 28
                : isTablet
                    ? 26
                    : 24,
          ),
        ),
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? 20
              : isTablet
                  ? 18
                  : 16,
          vertical: isDesktop
              ? 10
              : isTablet
                  ? 9
                  : 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MediCareTheme.primaryTeal.withOpacity(0.1),
              MediCareTheme.lightTeal.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          'All Products',
          style: GoogleFonts.poppins(
            color: MediCareTheme.primaryTeal,
            fontWeight: FontWeight.w700,
            fontSize: isDesktop
                ? 22
                : isTablet
                    ? 20
                    : 18,
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: EdgeInsets.all(isDesktop
              ? 16
              : isTablet
                  ? 14
                  : 12),
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
              setState(() {
                isGridView = !isGridView;
              });
            },
            child: Container(
              padding: EdgeInsets.all(isDesktop
                  ? 14
                  : isTablet
                      ? 13
                      : 12),
              child: Icon(
                isGridView ? Icons.view_list : Icons.grid_view,
                color: MediCareTheme.primaryTeal,
                size: isDesktop
                    ? 28
                    : isTablet
                        ? 26
                        : 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Container(
      margin: EdgeInsets.all(isDesktop
          ? 32
          : isTablet
              ? 24
              : 20),
      padding: EdgeInsets.all(isDesktop
          ? 24
          : isTablet
              ? 22
              : 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            MediCareTheme.primaryTeal,
            MediCareTheme.lightTeal,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: MediCareTheme.primaryTeal.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discover',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: isDesktop
                        ? 32
                        : isTablet
                            ? 30
                            : 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                    height: isDesktop
                        ? 8
                        : isTablet
                            ? 6
                            : 4),
                Text(
                  'Quality healthcare products',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isDesktop
                        ? 16
                        : isTablet
                            ? 15
                            : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(isDesktop
                ? 20
                : isTablet
                    ? 18
                    : 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.medical_services,
              color: Colors.white,
              size: isDesktop
                  ? 36
                  : isTablet
                      ? 34
                      : 32,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Container(
      height: isDesktop
          ? 70
          : isTablet
              ? 65
              : 60,
      margin: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? 32
              : isTablet
                  ? 24
                  : 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterOptions.length,
        itemBuilder: (context, index) {
          final isSelected = selectedFilter == filterOptions[index];
          return Container(
            margin: EdgeInsets.only(
                right: isDesktop
                    ? 16
                    : isTablet
                        ? 14
                        : 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  selectedFilter = filterOptions[index];
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop
                      ? 24
                      : isTablet
                          ? 22
                          : 20,
                  vertical: isDesktop
                      ? 14
                      : isTablet
                          ? 13
                          : 12,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [
                            MediCareTheme.primaryTeal,
                            MediCareTheme.lightTeal,
                          ],
                        )
                      : null,
                  color: isSelected ? null : MediCareTheme.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? MediCareTheme.primaryTeal.withOpacity(0.3)
                          : MediCareTheme.shadowLight,
                      blurRadius: isSelected ? 15 : 8,
                      offset: Offset(0, isSelected ? 6 : 2),
                    ),
                  ],
                ),
                child: Text(
                  filterOptions[index],
                  style: GoogleFonts.poppins(
                    color:
                        isSelected ? Colors.white : MediCareTheme.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: isDesktop
                        ? 16
                        : isTablet
                            ? 15
                            : 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductSection(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isDesktop
            ? 32
            : isTablet
                ? 24
                : 20,
        isDesktop
            ? 24
            : isTablet
                ? 22
                : 20,
        isDesktop
            ? 32
            : isTablet
                ? 24
                : 20,
        0,
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: snapshotRef,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _buildErrorWidget(context, screenSize);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingWidget(context, screenSize);
          }

          final allProducts = snapshot.data!.docs;
          final products = selectedFilter == 'All'
              ? allProducts
              : allProducts.where((doc) {
                  final type = (doc['type'] as String).toLowerCase();
                  if (selectedFilter == 'Medical Kit') {
                    return type == 'medicalkit';
                  } else if (selectedFilter == 'Others') {
                    return type == 'others';
                  } else if (selectedFilter == 'Medicine') {
                    return type != 'medicalkit' && type != 'others';
                  }
                  return true;
                }).toList();

          if (products.isEmpty) {
            return _buildEmptyWidget(context, screenSize);
          }

          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            color: MediCareTheme.primaryTeal,
            child: isGridView
                ? _buildGridView(products, screenSize)
                : _buildListView(products, screenSize),
          );
        },
      ),
    );
  }

  Widget _buildGridView(List<QueryDocumentSnapshot> products, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop
            ? 4
            : isTablet
                ? 3
                : 2,
        mainAxisSpacing: isDesktop
            ? 24
            : isTablet
                ? 20
                : 16,
        crossAxisSpacing: isDesktop
            ? 24
            : isTablet
                ? 20
                : 16,
        mainAxisExtent: isDesktop
            ? 340
            : isTablet
                ? 320
                : 300,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductGridCard(product, index, screenSize);
      },
    );
  }

  Widget _buildListView(List<QueryDocumentSnapshot> products, Size screenSize) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductListCard(product, index, screenSize);
      },
    );
  }

  Widget _buildProductGridCard(
      QueryDocumentSnapshot product, int index, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        NavigatorTo(
          context,
          ProductDetailScreen(
            Productprice: product['price'],
            Producttype: product['type'],
            Productname: product['name'],
            ProductimagePath: product['images'],
            Size: product['sizes'],
            Productdescription: product['description'],
            ProductReviews: product['reviews'],
            ProductId: product['ProductId'],
          ),
        );
      },
      child: Consumer<WishlistProvider>(
        builder: (context, wishlist, _) {
          return NewArrivalTile(
            image: product['images'],
            description: product['description'],
            type: product['type'],
            price: product['price'],
            productId: product['ProductId'].toString(),
            position: index,
            name: product['name'],
            size: product['sizes'],
            reviews: product['reviews'],
            brand: product['brand'],
          );
        },
      ),
    ).animate().fade(duration: 600.ms, delay: (100 * index).ms).scale(
        begin: const Offset(0.9, 0.9),
        end: const Offset(1, 1),
        duration: 500.ms);
  }

  Widget _buildProductListCard(
      QueryDocumentSnapshot product, int index, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;
    final List<dynamic> images = product['images'] ?? [];
    final String imageUrl = images.isNotEmpty
        ? images[0] as String
        : 'https://via.placeholder.com/150';

    return Container(
      margin: EdgeInsets.only(
          bottom: isDesktop
              ? 24
              : isTablet
                  ? 20
                  : 16),
      decoration: BoxDecoration(
        color: MediCareTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: MediCareTheme.shadowLight,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          NavigatorTo(
            context,
            ProductDetailScreen(
              Productprice: product['price'],
              Producttype: product['type'],
              Productname: product['name'],
              ProductimagePath: [imageUrl],
              Size: product['sizes'],
              Productdescription: product['description'],
              ProductReviews: product['reviews'],
              ProductId: product['ProductId'],
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.all(isDesktop
              ? 20
              : isTablet
                  ? 18
                  : 16),
          child: Row(
            children: [
              Container(
                height: isDesktop
                    ? 100
                    : isTablet
                        ? 90
                        : 80,
                width: isDesktop
                    ? 100
                    : isTablet
                        ? 90
                        : 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                  width: isDesktop
                      ? 20
                      : isTablet
                          ? 18
                          : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: isDesktop
                            ? 22
                            : isTablet
                                ? 21
                                : 20,
                        color: MediCareTheme.textPrimary,
                      ),
                    ),
                    SizedBox(
                        height: isDesktop
                            ? 8
                            : isTablet
                                ? 6
                                : 4),
                    Text(
                      product['type'],
                      style: GoogleFonts.poppins(
                        fontSize: isDesktop
                            ? 16
                            : isTablet
                                ? 15
                                : 14,
                        color: MediCareTheme.textSecondary,
                      ),
                    ),
                    SizedBox(
                        height: isDesktop
                            ? 12
                            : isTablet
                                ? 10
                                : 8),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop
                                ? 10
                                : isTablet
                                    ? 9
                                    : 8,
                            vertical: isDesktop
                                ? 6
                                : isTablet
                                    ? 5
                                    : 4,
                          ),
                          decoration: BoxDecoration(
                            color: MediCareTheme.primaryTeal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '\$${product['price']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: MediCareTheme.primaryTeal,
                              fontSize: isDesktop
                                  ? 16
                                  : isTablet
                                      ? 15
                                      : 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: 600.ms, delay: (80 * index).ms)
        .slideX(begin: 0.2, end: 0, duration: 500.ms);
  }

  Widget _buildLoadingWidget(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.stretchedDots(
            color: MediCareTheme.primaryTeal,
            size: isDesktop
                ? 60
                : isTablet
                    ? 55
                    : 50,
          ),
          SizedBox(
              height: isDesktop
                  ? 20
                  : isTablet
                      ? 18
                      : 16),
          Text(
            'Loading products...',
            style: GoogleFonts.poppins(
              color: MediCareTheme.textSecondary,
              fontSize: isDesktop
                  ? 18
                  : isTablet
                      ? 17
                      : 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop
                ? 28
                : isTablet
                    ? 26
                    : 24),
            decoration: BoxDecoration(
              color: MediCareTheme.errorColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: isDesktop
                  ? 72
                  : isTablet
                      ? 68
                      : 64,
              color: MediCareTheme.errorColor,
            ),
          ),
          SizedBox(
              height: isDesktop
                  ? 28
                  : isTablet
                      ? 26
                      : 24),
          Text(
            'Something went wrong 😕',
            style: GoogleFonts.poppins(
              color: MediCareTheme.errorColor,
              fontSize: isDesktop
                  ? 22
                  : isTablet
                      ? 21
                      : 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
              height: isDesktop
                  ? 12
                  : isTablet
                      ? 10
                      : 8),
          Text(
            'Please try again later',
            style: GoogleFonts.poppins(
              color: MediCareTheme.textSecondary,
              fontSize: isDesktop
                  ? 16
                  : isTablet
                      ? 15
                      : 14,
            ),
          ),
          SizedBox(
              height: isDesktop
                  ? 28
                  : isTablet
                      ? 26
                      : 24),
          ElevatedButton(
            onPressed: () {
              setState(() {});
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MediCareTheme.primaryTeal,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop
                    ? 40
                    : isTablet
                        ? 36
                        : 32,
                vertical: isDesktop
                    ? 20
                    : isTablet
                        ? 18
                        : 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: isDesktop
                    ? 18
                    : isTablet
                        ? 17
                        : 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context, Size screenSize) {
    final isDesktop = screenSize.width >= 1024;
    final isTablet = screenSize.width >= 600 && screenSize.width < 1024;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(isDesktop
                ? 28
                : isTablet
                    ? 26
                    : 24),
            decoration: BoxDecoration(
              color: MediCareTheme.primaryTeal.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              size: isDesktop
                  ? 72
                  : isTablet
                      ? 68
                      : 64,
              color: MediCareTheme.textLight,
            ),
          ),
          SizedBox(
              height: isDesktop
                  ? 28
                  : isTablet
                      ? 26
                      : 24),
          Text(
            'No Products Found',
            style: GoogleFonts.poppins(
              fontSize: isDesktop
                  ? 22
                  : isTablet
                      ? 21
                      : 20,
              fontWeight: FontWeight.w600,
              color: MediCareTheme.textSecondary,
            ),
          ),
          SizedBox(
              height: isDesktop
                  ? 12
                  : isTablet
                      ? 10
                      : 8),
          Text(
            'Check back soon for new arrivals',
            style: GoogleFonts.poppins(
              fontSize: isDesktop
                  ? 16
                  : isTablet
                      ? 15
                      : 14,
              color: MediCareTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
