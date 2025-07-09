import 'package:blog/constraints/app_constraint.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../services/sharedpreferences_service.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    isLoading.value = true;
    try {
      final String url = "$baseUrl/api/user/profile";
      final response = await http.post(
        Uri.parse(url),
        headers: {"Authorization": SharedPreferencesService().getAuthHeader()!},
        body: {"name": name, "email": email},
      );
      if (response.statusCode == 200) {
        SharedPreferencesService().updateUserDetails(
          userName: name,
          userEmail: email,
        );
        CustomSnakbar.show(
          title: "Success",
          message: "Profile Update Successfull",
          backgroundColor: Colors.green,
          icon: Icons.check_circle_rounded,
        );
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        CustomSnakbar.show(
          title: "Failed",
          message: "Profile Update Failed",
          backgroundColor: Colors.red,
          icon: Icons.warning,
        );
      }
    } catch (e) {
      CustomSnakbar.show(
        title: "Failed",
        message: "Something went wrong",
        backgroundColor: Colors.red,
        icon: Icons.warning,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
