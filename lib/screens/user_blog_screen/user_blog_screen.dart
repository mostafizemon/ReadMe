import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_blog_controller.dart';

class UserBlogScreen extends StatelessWidget {
  const UserBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserBlogController>();
    return Scaffold(
      appBar: AppBar(title: Text("Your Blogs")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.blogs.isEmpty) {
            return const Center(
              child: Text(
                "You have no blog",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final blog = controller.blogs[index];
              return ListTile(
                title: Text(
                  blog.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.blue),
                              title: Text("Update"),
                              onTap: () {
                                Get.back();
                              },
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.red),
                              title: Text("Delete"),
                              onTap: () {
                                controller.deleteBlog(blog.id);
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.more_horiz),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: controller.blogs.length,
          );
        }),
      ),
    );
  }
}
