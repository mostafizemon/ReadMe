import 'package:blog/controllers/splash_controller.dart';
import 'package:blog/widgets/app_name_custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppNameCustomTextstyle(),
            Text(
              'Write your Blog',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 24,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
