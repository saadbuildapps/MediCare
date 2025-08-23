import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Features/Auth/logout_auth.dart';
import 'package:laza/Features/Card/Screens/payment_screen.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Features/Home/screen/all_arrival_screen.dart';
import 'package:laza/Features/WishList/screens/favirate_list_screen.dart';
import 'package:laza/Resources/NavigationBar/nav_bar.dart';
import 'package:laza/Resources/Navigators/navigators.dart';
import 'package:laza/Resources/Paths/imports.dart' hide MediCareTheme;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';

final _auth = FirebaseAuth.instance;
Future<DocumentSnapshot<Map<String, dynamic>>> UserData() async {
  final String userId = _auth.currentUser!.uid.toString();
  final userRef = FirebaseFirestore.instance.collection('User').doc(userId);
  return await userRef.get();
}

Widget buildModernDrawer(BuildContext context) {
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
  return Builder(builder: (context) {
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
  });
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
