import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_ontroller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/emoney_character.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
