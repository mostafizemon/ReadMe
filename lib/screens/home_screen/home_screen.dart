import 'package:blog/controllers/home_controller.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/screens/home_screen/widgets/blogs_listview.dart';
import 'package:blog/services/sharedpreferences_service.dart';
import 'package:blog/widgets/app_name_custom_textstyle.dart';
import 'package:blog/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: AppNameCustomTextstyle(),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.line_weight_rounded, size: 32),
            );
          },
        ),
      ),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                controller.searchBlogs(value);
                controller.selectedFilter.value = "All";
              },
            ),
            const SizedBox(height: 16),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['All', 'Latest', 'Trending'].map((label) {
                  final isSelected = controller.selectedFilter.value == label;
                  return GestureDetector(
                    onTap: () => controller.setFilter(label),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 16),
            BlogsListview(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (SharedPreferencesService().isLoggedIn()) {
            Get.toNamed(AppRoutes.addNewBlogScreen);
          } else {
            Get.dialog(
              CustomAlertDialog(
                content: "You must be logged in to create a new blog.",
              ),
              barrierDismissible: false,
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
