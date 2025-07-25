import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color(0xff1A5D1A), // Deep Forest Green
    Color(0xff4CAF50), // Medium Green
    Color(0xffA5D6A7), 
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Obx(() => AnimatedOpacity(
                opacity: controller.showLogo.value ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Image.asset(
                  'assets/images/splash_img.png',
                  color: Colors.white,
                  width: 200,
                ),
              )),
        ),
      ),
    );
  }
}
