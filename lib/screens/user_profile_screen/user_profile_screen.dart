import 'package:blog/services/sharedpreferences_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final nameController = TextEditingController(
      text: SharedPreferencesService().getUserName(),
    );
    final emailController = TextEditingController(
      text: SharedPreferencesService().getUserEmail(),
    );
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(prefixIcon: Icon(Icons.person)),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final regex = RegExp(
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                  );
                  if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
                decoration: InputDecoration(prefixIcon: Icon(Icons.email)),
              ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.updateProfile(
                      name: nameController.text.trim(),
                      email: emailController.text.trim(),
                    );
                  }
                },
                child: controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text(
                        "Update Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
