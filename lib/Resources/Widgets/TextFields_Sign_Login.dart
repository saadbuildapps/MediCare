import 'package:google_fonts/google_fonts.dart';
import 'package:laza/Providers/textfeild_tick_provider.dart';
import 'package:provider/provider.dart';

import '../MediaQuery/media_query.dart';
import '../Paths/imports.dart';
//!  custom text field widget  used in both SignIn and Login Screens
class MyTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final String? fieldType;
  final onchange;
  final validator;
  final SuffixIcon;
  const MyTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.onchange,
    this.validator,
    this.SuffixIcon,
    this.fieldType,
  });

  @override
  Widget build(BuildContext context) {
    // final w = getScreenSize(context).width * (1 / 375);
    final h = getScreenSize(context).height * (1 / 812);

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 13 * h,
                fontWeight: FontWeight.w400,
                // fontFamily: 'Inter',
                color: MyColor.textLight),
          ),
          Consumer<TextfeildTickProvider>(
            builder: (BuildContext context, TextfeildTickProvider value,
                Widget? child) {
              return TextFormField(
                  onChanged: (val) {
                    (fieldType?.toLowerCase() == 'password')
                        ? value.passwordchecker(controller.text.toString())
                        : (fieldType?.toLowerCase() == 'email')
                            ? value.emailChecker(controller.text.toString())
                            : (fieldType?.toLowerCase() == 'name')
                                ? value.namechecker(controller.text.toString())
                                : (fieldType?.toLowerCase() == 'emaillogin')
                                    ? value.emailloginChecker(
                                        controller.text.toString())
                                    : (fieldType?.toLowerCase() ==
                                            'passwordlogin')
                                        ? value.passwordloginchecker(
                                            controller.text.toString())
                                        : null;
                  },
                  style: TextStyle(
                      fontSize: 15 * h,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: MyColor.textBlack),
                  controller: controller,
                  cursorErrorColor: MyColor.red,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        // fontFamily: 'Inter',
                        color: MyColor.textBlack),
                    suffixIcon: SuffixIcon,
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE7E8EA))),
                    disabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE7E8EA))),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColor.textLight),
                    ),
                    errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.red)),
                    focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColor.red)),
                  ));
            },
          )
        ]);
  }
}
