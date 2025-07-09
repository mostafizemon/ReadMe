import 'package:blog/controllers/home_controller.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/services/sharedpreferences_service.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:blog/constraints/app_constraint.dart';
import 'package:get/get.dart';

class AddNewBlogController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> addNewBlog(String title, String description) async {
    isLoading.value = true;
    try {
      final String url = "$baseUrl/api/blogs";
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${SharedPreferencesService().getAccessToken()}",
        },
        body: {"title": title, "description": description},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        CustomSnakbar.show(
          title: "Success",
          message: "Blog Create Successfull",
          backgroundColor: Colors.green,
          icon: Icons.check_circle,
        );
        final homeController = Get.find<HomeController>();
        homeController.fetchBlogs();
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        CustomSnakbar.show(
          title: "Failed",
          message: "Blog Create Faile",
          backgroundColor: Colors.red,
          icon: Icons.warning,
        );
      }
    } catch (e) {
      CustomSnakbar.show(
        title: "Failed",
        message: "Blog Create Faile",
        backgroundColor: Colors.red,
        icon: Icons.warning,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
