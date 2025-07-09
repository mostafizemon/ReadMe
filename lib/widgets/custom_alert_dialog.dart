import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';

class CustomAlertDialog extends StatelessWidget {
  final String content;
  const CustomAlertDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Login Required"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
            Get.toNamed(AppRoutes.loginScreen); // Navigate to login screen
          },
          child: const Text("Login"),
        ),
      ],
    );
  }
}
