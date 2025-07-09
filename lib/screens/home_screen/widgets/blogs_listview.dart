import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controller.dart';
import '../../../routes/app_routes.dart';

class BlogsListview extends StatelessWidget {
  const BlogsListview({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.blogs.isEmpty) {
          return const Center(child: Text("No Blogs Found"));
        }
        return ListView.separated(
          itemCount: controller.blogs.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final blog = controller.blogs[index];
            return ListTile(
              onTap: () {
                Get.toNamed(AppRoutes.blogDetailsScreen, arguments: blog);
              },
              title: Text(
                blog.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    "Posted By: ${blog.user.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Reading Time: ${(blog.totalReadTime / 60).toStringAsFixed(2)} Minutes",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
