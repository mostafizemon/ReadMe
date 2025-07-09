import 'package:blog/controllers/user_blog_controller.dart';
import 'package:get/get.dart';

class UserBlogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserBlogController>(() => UserBlogController());
  }
}
