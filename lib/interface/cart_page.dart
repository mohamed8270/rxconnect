// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find<CartController>();
  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: rwhite,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: rgreen,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed('orderpage');
          },
          backgroundColor: rgreen,
          elevation: 0,
          child: Text(
            'Checkout',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: rwhite,
            ),
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: rgrey,
                  width: 0.5,
                ),
              ),
            ),
          ),
          centerTitle: false,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => Get.toNamed('bottomnavbar'),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.network(
                'https://www.svgrepo.com/show/327609/arrow-back.svg',
                height: 12,
                width: 12,
                color: rgreen,
              ),
            ),
          ),
          title: Text(
            "Cart Details",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: rblack,
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: cartController.cartItems.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: screenSize.height * 0.13,
                // width: screenSize.width * 0.65,
                decoration: BoxDecoration(
                  color: rwhite,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: rgrey, width: 1.3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  cartController.cartItems[i].imageUrl,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                cartController.cartItems[i].title,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: rblack,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                cartController.cartItems[i].dosage,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: rblack.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                cartController.cartItems[i].taking,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: rblack.withOpacity(0.5),
                                ),
                              ),
                              Text(
                                'Quantity: ${cartController.cartItems[i].quantity.toString()}',
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
                      InkWell(
                        onTap: () => cartController
                            .removeItem(cartController.cartItems[i].id),
                        child: SvgPicture.network(
                          'https://www.svgrepo.com/show/502608/delete-2.svg',
                          height: 24,
                          width: 24,
                          color: rblack.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
