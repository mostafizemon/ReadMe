import 'package:get/get.dart';

import '../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splashScreen();
  }

  Future<void> splashScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(AppRoutes.homeScreen);
  }
}
