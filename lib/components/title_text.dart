import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/constants/theme.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.txt,
  });

  final String txt;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: rblack,
      ),
    );
  }
}
