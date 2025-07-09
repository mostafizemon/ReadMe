import 'dart:convert';

import 'package:blog/models/blog_model.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constraints/app_constraint.dart';
import '../services/sharedpreferences_service.dart';

class UserBlogController extends GetxController {
  RxList<BlogModel> blogs = <BlogModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  onInit() {
    fetchUserBlogs();
    super.onInit();
  }

  Future<void> deleteBlog(int blogId) async {
    try {
      final String url = "$baseUrl/api/blogs/$blogId";
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Authorization": SharedPreferencesService().getAuthHeader()!,
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        CustomSnakbar.show(
          title: "Success",
          message: "Blog Remove Successfull",
          backgroundColor: Colors.green,
          icon: Icons.check_circle_rounded,
        );
        fetchUserBlogs();
      } else {
        CustomSnakbar.show(
          title: "Failed",
          message: "Blog Remove Failed",
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
    }
  }

  Future<void> fetchUserBlogs() async {
    try {
      isLoading.value = true;
      final String url = "$baseUrl/api/user/blogs";
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": SharedPreferencesService().getAuthHeader()!,
          "Accept": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final blogList = data['data'] as List;
        blogs.value = blogList.map((item) => BlogModel.fromJson(item)).toList();
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        throw Exception("Failed to fetch blogs");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to fetch blogs");
    } finally {
      isLoading.value = false;
    }
  }
}
