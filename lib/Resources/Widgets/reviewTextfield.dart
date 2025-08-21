import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Paths/imports.dart';

class ReuseableTextfield extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  const ReuseableTextfield({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text, // default normal text input
    this.inputFormatters,
    this.obscureText = false, // for passwords if needed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: MyColor.textBlack,
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              hintStyle: GoogleFonts.poppins(
                color: MyColor.textLight,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: MyColor.grey,
            ),
          ),
        ),
      ],
    );
  }
}
