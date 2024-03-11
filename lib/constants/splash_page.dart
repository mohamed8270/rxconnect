// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rxconnect/constants/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () {
      Get.toNamed("bottomnavbar");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgreen,
      body: SafeArea(
        child: Center(
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/318051/medicine-pill.svg',
            height: 200,
            width: 200,
            color: rwhite,
          ),
        ),
      ),
    );
  }
}
