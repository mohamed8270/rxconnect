// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/constants/theme.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.title,
    required this.dosage,
    required this.icn,
    required this.medform,
    required this.imglink,
    required this.meddes,
    required this.click,
  });

  final String title;
  final String dosage;
  final String icn;
  final String medform;
  final String imglink;
  final String meddes;
  final VoidCallback click;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
          height: screenSize.height * 0.3,
          // width: screenSize.width * 0.65,
          decoration: BoxDecoration(
            color: rwhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: rgrey, width: 1.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: screenSize.height * 0.1,
                      width: screenSize.width * 0.22,
                      decoration: BoxDecoration(
                        color: rwhite,
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            imglink,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: rblack,
                          ),
                        ),
                        const Gap(5),
                        Row(
                          children: [
                            Text(
                              dosage,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: rblack.withOpacity(0.5),
                              ),
                            ),
                            const Gap(10),
                            SvgPicture.network(
                              icn,
                              height: 11,
                              width: 11,
                              color: rgreen,
                            ),
                            Text(
                              medform,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: rblack.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(5),
                Expanded(
                  child: SizedBox(
                    width: screenSize.width * 0.65,
                    child: Text(
                      meddes,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: rblack.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                const Gap(5),
                InkWell(
                  onTap: click,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: screenSize.height * 0.05,
                    width: screenSize.width * 0.65,
                    decoration: BoxDecoration(
                      color: rgreen,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Add to Card",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: rwhite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
