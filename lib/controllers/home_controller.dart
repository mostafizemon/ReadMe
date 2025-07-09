import 'dart:convert';

import 'package:blog/constraints/app_constraint.dart';
import 'package:blog/models/blog_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  RxString selectedFilter = "All".obs;
  RxList<BlogModel> blogs = <BlogModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    fetchBlogs();
    super.onInit();
  }

  void setFilter(String filter) {
    if (selectedFilter.value != filter) {
      selectedFilter.value = filter;
      fetchBlogs();
    }
  }

  Future<void> fetchBlogs() async {
    isLoading.value = true;
    String endpoint = "$baseUrl/api/blogs/";
    if (selectedFilter.value == "Latest") {
      endpoint = "$baseUrl/api/blogs/latest";
    } else if (selectedFilter.value == "Trending") {
      endpoint = "$baseUrl/api/blogs/trending";
    }
    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        blogs.value = List<BlogModel>.from(
          data['data'].map((item) => BlogModel.fromJson(item)),
        );
      } else {}
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
