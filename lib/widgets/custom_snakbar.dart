import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnakbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: textColor,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: duration,
      borderRadius: 10,
    );
  }
}
