import 'package:get/get.dart';

import '../controllers/add_new_blog_controller.dart';

class AddNewBlogBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewBlogController());
  }
}