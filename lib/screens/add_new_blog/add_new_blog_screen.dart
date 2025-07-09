import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/add_new_blog_controller.dart';

class AddNewBlogScreen extends StatelessWidget {
  const AddNewBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddNewBlogController>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Blog"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Let the world hear your story!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Fill out the details to publish a new blog.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Title field
              TextFormField(
                controller: titleController,
                maxLines: 2,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Enter blog title",
                  labelText: "Title",
                  prefixIcon: const Icon(Icons.title),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Title is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Description field
              TextFormField(
                controller: descriptionController,
                maxLines: 8,
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Write your blog content here...",
                  labelText: "Description",
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Icon(Icons.description),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Description is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.addNewBlog(
                      titleController.text.trim(),
                      descriptionController.text.trim(),
                    );
                  }
                },
                child: Center(
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send),
                            SizedBox(width: 4),
                            Text(
                              "Publish Blog",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
