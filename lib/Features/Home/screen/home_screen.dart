//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::
//!              !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        |
//!              --------------------------------------        |
//!              **************************************        |
//!::::::::::::::::::::   I Have Seen this   :::::::::::::::::::

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Home/provider/home-provider.dart';
import 'package:laza/Features/Home/screen/DrawerScreen.dart';
import 'package:laza/Features/WishList/providers/wishList_provider.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart';
import 'package:laza/Resources/Widgets/new_arrival_tile.dart';
import 'package:laza/Features/Home/screen/all_arrival_screen.dart' hide MediCareTheme;
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Features/Product_DetailScreen/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../../Models/new_arrival_model.dart';
import '../../../Resources/MediaQuery/media_query.dart';
import '../../ai_bot_module/chat_view.dart';

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

  @override
  void dispose() {
    searchController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider =
        Provider.of<HomeScreenProvvider>(context, listen: false);
    homeProvider.getProduct(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: MediCareTheme.lightTeal.withOpacity(0.1),
        key: _scaffoldKey,
        appBar: _buildEnhancedAppBar(),
        drawer: buildModernDrawer(context),
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
                    _buildHelloSection(),
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

//! hero section :
  Widget _buildHelloSection() {
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
              ),
            ),
            Text(
              'Trusted and verified products',
              style: GoogleFonts.poppins(
                color: MediCareTheme.textSecondary,
                fontSize: 14,
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
//!  floating action button chatbot button=================>  towards AiChat
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
