import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../services/sharedpreferences_service.dart';

class DrawerListview extends StatelessWidget {
  const DrawerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.deepOrange),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                SharedPreferencesService().getUserName().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 4),
              Text(
                SharedPreferencesService().getUserEmail().toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {
            Get.toNamed(AppRoutes.userProfileScreen);
          },
          leading: Icon(Icons.person),
          title: Text("Profile"),
        ),
        ListTile(
          onTap: () => Get.toNamed(AppRoutes.userBlogScreen),
          leading: Icon(Icons.post_add),
          title: Text("Your Blog"),
        ),
        ListTile(
          onTap: () {
            SharedPreferencesService().clearAuthToken();
            Get.offAllNamed(AppRoutes.homeScreen);
          },
          leading: Icon(Icons.logout),
          title: Text('Logout'),
        ),
      ],
    );
  }
}
