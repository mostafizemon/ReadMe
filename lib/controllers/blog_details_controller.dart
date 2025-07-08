import 'dart:convert';
import 'package:blog/constraints/app_constraint.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/models/comment_model.dart';
import 'package:blog/services/sharedpreferences_service.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;
  late SharedPreferencesService sharedPreferencesService =
      SharedPreferencesService();

  late BlogModel blog;
  @override
  void onInit() {
    blog = Get.arguments as BlogModel;
    fetchComments(blog.id);
    super.onInit();
  }



  Future<void> fetchComments(int blogId) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/blogs/$blogId/comments'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        comments.value = List<CommentModel>.from(
          data['data'].map((item) => CommentModel.fromJson(item)),
        );
      } else {
        CustomSnakbar.show(title: "Failed", message: "Something Went Wrong");
      }
    } catch (e) {
      CustomSnakbar.show(title: "Failed", message: "Something Went Wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
