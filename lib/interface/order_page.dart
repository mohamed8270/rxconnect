// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/controllers/cart_controller.dart';
import 'package:rxconnect/interface/user_input.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final CartController cartController = Get.find<CartController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController talukController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
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
            if (nameController.text == '' &&
                emailController.text == '' &&
                numberController.text == '' &&
                addressController.text == '' &&
                talukController.text == '' &&
                districtController.text == '') {
              Get.snackbar(
                'Empty values',
                'Please enter a value',
                colorText: rwhite,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
              );
            } else {
              cartController.clearCart();
              Get.toNamed('bottomnavbar');
              Get.snackbar(
                'Success',
                'Order placed successfully',
                backgroundColor: rgreen,
                snackPosition: SnackPosition.BOTTOM,
                colorText: rwhite,
              );
            }
          },
          backgroundColor: rgreen,
          elevation: 0,
          child: Text(
            'Order Now',
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
            onTap: () => Get.back(),
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
            "User Details",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: rblack,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Detail's",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: rblack,
                ),
              ),
              const Gap(10),
              UserInputWidget(
                height: screenSize.height * 0.055,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/491095/user.svg',
                txt: 'Name',
                type: TextInputType.name,
                userController: nameController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputWidget(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.46,
                    icnLink: 'https://www.svgrepo.com/show/488920/email.svg',
                    txt: 'Email',
                    type: TextInputType.emailAddress,
                    userController: emailController,
                  ),
                  UserInputWidget(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.46,
                    icnLink:
                        'https://www.svgrepo.com/show/533284/phone-alt.svg',
                    txt: 'Phone No.',
                    type: TextInputType.number,
                    userController: numberController,
                  ),
                ],
              ),
              const Gap(10),
              UserInputWidget(
                height: screenSize.height * 0.2,
                width: screenSize.width * 0.95,
                icnLink: 'https://www.svgrepo.com/show/533170/address-book.svg',
                txt: 'Address',
                type: TextInputType.streetAddress,
                userController: addressController,
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserInputWidget(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.46,
                    icnLink:
                        'https://www.svgrepo.com/show/510853/building-01.svg',
                    txt: 'Taluk',
                    type: TextInputType.streetAddress,
                    userController: talukController,
                  ),
                  UserInputWidget(
                    height: screenSize.height * 0.055,
                    width: screenSize.width * 0.46,
                    icnLink:
                        'https://www.svgrepo.com/show/496889/building-4.svg',
                    txt: 'District',
                    type: TextInputType.streetAddress,
                    userController: districtController,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
