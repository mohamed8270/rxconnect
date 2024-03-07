// ignore_for_file: deprecated_member_use

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/constants/theme.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({
    super.key,
    required this.onClick,
    required this.txt,
  });

  final VoidCallback onClick;
  final String txt;

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: onClick,
      child: DottedBorder(
        dashPattern: const [4, 4],
        strokeWidth: 1,
        strokeCap: StrokeCap.round,
        borderType: BorderType.Rect,
        color: rblack.withOpacity(0.4),
        child: Container(
          height: screeSize.height * 0.1,
          width: screeSize.width * 0.95,
          decoration: const BoxDecoration(
            color: rwhite,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(
                'https://www.svgrepo.com/show/505669/image-1.svg',
                height: 45,
                width: 45,
                color: rgreen,
              ),
              const Gap(10),
              Text(
                txt,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: rblack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
