import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/blog_details_controller.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogDetailsController controller = Get.find<BlogDetailsController>();
    final blog = controller.blog;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              blog.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Created By: ${blog.user.name}",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              blog.description,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),

            const SizedBox(height: 24),
            Text(
              "Comments (${controller.comments.length})",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.comments.isEmpty) {
                return const Text("No comments yet.");
              }

              return Column(
                children: controller.comments.map((comment) {
                  return ListTile(
                    title: Text(comment.comment),
                    subtitle: Text("By: ${comment.user.name}"),
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
