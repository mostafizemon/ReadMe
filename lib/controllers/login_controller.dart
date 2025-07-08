import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isObsecureText = true.obs;

  void obsecureToggleButton() {
    isObsecureText.value = !isObsecureText.value;
  }
}
