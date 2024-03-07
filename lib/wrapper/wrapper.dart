import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxconnect/constants/splash_page.dart';
import 'package:rxconnect/constants/theme.dart';
import 'package:rxconnect/interface/bottom_nav_bar.dart';
import 'package:rxconnect/interface/cart_page.dart';
import 'package:rxconnect/interface/order_page.dart';
import 'package:rxconnect/pages/home_page.dart';
import 'package:rxconnect/pages/profile_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RxConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: rwhite),
        useMaterial3: true,
      ),
      routes: {
        "homepage": (c) => const HomePage(),
        "profilepage": (c) => const ProfilePage(),
        "bottomnavbar": (c) => const BottomNavBar(),
        "cartpage": (c) => CartPage(),
        "orderpage": (c) => const OrderPage(),
        "splashpage": (c) => const SplashPage(),
      },
      home: const SplashPage(),
    );
  }
}
