import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Providers/bottom_buttom_provider.dart';
import 'package:provider/provider.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/imports.dart';

bool isLoading = false;

//! custom bottom button widget used in login, signinScreens.  
class BottomButtons extends StatelessWidget {
  final String lable;
  final double height;
  final double width;
  final double boardRadius;
  final VoidCallback ontap;
  const BottomButtons(
      {super.key,
      required this.lable,
      required this.ontap,
      this.height = 75,
      this.width = double.maxFinite,
      this.boardRadius = 0});

  @override
  Widget build(BuildContext context) {
    final fullHeight = getScreenSize(context).height;
    final fullWidth = getScreenSize(context).width;
    final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);
    return Consumer<BottomButtomProvider>(builder: (context, value, child) {
      return InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          ontap();
          print(value.isLoading);
        },
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(boardRadius),
            color: MyColor.purple,
          ),
          width: width,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (value.isLoading)
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      )
                    : Text(
                        lable,
                        style: GoogleFonts.poppins(
                          // fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: MyColor.white,
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
