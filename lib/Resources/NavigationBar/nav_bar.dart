import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Resources/Paths/AssetsPath.dart';
import 'package:laza/Features/Cart/Screens/cart_screen.dart';
import 'package:laza/Features/WishList/screens/favirate_list_screen.dart';
import 'package:laza/Features/Home/screen/home_screen.dart';

import '../../Features/Card/Screens/payment_screen.dart';
import '../Paths/imports.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

var navigatedFrom;

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  List screens = [
    const HomeScreen(),
    const FavirateListScreen(),
    const CartScreen(),
    const PaymentScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            navigatedFrom = 'navBar';
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: SvgPicture.asset(Images.bottomHome),
              title: Text(
                'Home',
                style: GoogleFonts.poppins(
                  color: MyColor.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              activeColor: MyColor.purple,
              inactiveColor: MyColor.grey,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(Images.heart),
              title: Text(
                'Wishlist',
                style: GoogleFonts.poppins(
                  color: MyColor.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              activeColor: MyColor.purple,
              inactiveColor: MyColor.grey,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(Images.bottomCart),
              title: Text(
                'Cart',
                style: GoogleFonts.poppins(
                  color: MyColor.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              activeColor: MyColor.purple,
              inactiveColor: MyColor.grey,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(Images.bottomPayment),
              title: Text(
                'Payment',
                style: GoogleFonts.poppins(
                  color: MyColor.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              activeColor: MyColor.purple,
              inactiveColor: MyColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}

