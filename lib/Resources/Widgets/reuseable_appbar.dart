// reuseable_appbar.dart (updated based on snippet)

//!  i have seen  this :::::::::::::::::

//! ____________________________________

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:google_fonts/google_fonts.dart';

import '../NavigationBar/nav_bar.dart';
import '../Navigators/navigators.dart';
import '../Paths/imports.dart';

appBar(BuildContext context, {title, screenType}) {
  //! Used in Add_ReviewScreen  +
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.poppins(
        // fontFamily: "Inter",
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.teal.shade700,
      ),
    ),
    elevation: 0.5,
    centerTitle: true,
    backgroundColor: Colors.white,
    toolbarHeight: 80,
    leading: (navigatedFrom == 'navBar')
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                NavigatorTo(context, screenType);
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 25,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
          ),
  );
}

buildAppBar(
  BuildContext context,
  String tittle,
) {
  //! Used in ReviewScreen.dart
  return PreferredSize(
    preferredSize: const Size.fromHeight(90),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          tittle,
          style: GoogleFonts.poppins(
            // fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 90,
      ),
    ),
  );
}
