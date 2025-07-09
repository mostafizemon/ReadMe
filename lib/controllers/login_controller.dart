import 'dart:convert';

import 'package:blog/constraints/app_constraint.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/services/sharedpreferences_service.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxBool isObsecureText = true.obs;
  RxBool isLoading = false.obs;

  void obsecureToggleButton() {
    isObsecureText.value = !isObsecureText.value;
  }

  Future<void> loginUser(String email, String password) async {
    String url = "$baseUrl/api/login";
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {"Accept": "application/json"},
        body: {"email": email, "password": password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final token = data['access_token'];
        final type = data['token_type'];
        final user = data['user'];
        final name = user['name'];
        final email = user['email'];

        if (token != null && type != null) {
          await SharedPreferencesService().saveAuthToken(
            accessToken: token,
            tokenType: type,
            userName: name,
            userEmail: email,
          );

          CustomSnakbar.show(
            title: "Success",
            message: "Login Successful",
            backgroundColor: Colors.green,
            icon: Icons.check_circle,
          );
          Get.offAllNamed(AppRoutes.homeScreen);
        }
      } else {
        final error = json.decode(response.body);
        CustomSnakbar.show(
          title: "Failed",
          message: error['message'] ?? 'Login failed',
          backgroundColor: Colors.red,
          icon: Icons.warning,
        );
      }
    } catch (e) {
      CustomSnakbar.show(
        title: "Failed",
        message: e.toString(),
        backgroundColor: Colors.red,
        icon: Icons.warning,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
