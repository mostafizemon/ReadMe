import 'dart:convert';
import 'package:blog/constraints/app_constraint.dart';
import 'package:blog/controllers/home_controller.dart';
import 'package:blog/models/blog_model.dart';
import 'package:blog/models/comment_model.dart';
import 'package:blog/services/sharedpreferences_service.dart';
import 'package:blog/widgets/custom_snakbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BlogDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;

  DateTime? _entryTime;
  Duration stayDuration = Duration.zero;

  late BlogModel blog;
  @override
  void onInit() {
    blog = Get.arguments as BlogModel;
    _entryTime = DateTime.now();
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

  Future<void> addComment(String comment) async {
    final String url = "$baseUrl/api/blogs/${blog.id}/comments";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization":
              "Bearer ${SharedPreferencesService().getAccessToken()}",
        },
        body: {'comment': comment},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        fetchComments(blog.id);
      }
    } catch (e) {
      CustomSnakbar.show(title: "Failed", message: "Something Went Wrong");
    }
  }

  @override
  void onClose() async {
    if (_entryTime != null) {
      stayDuration = DateTime.now().difference(_entryTime!);
      final int durationInSeconds = stayDuration.inSeconds;
      try {
        final String url = '$baseUrl/api/blogs/${blog.id}/track-read';
        final response = await http.post(
          Uri.parse(url),
          body: {'time_spent': durationInSeconds.toString()},
        );
        if (response.statusCode == 200) {
          final HomeController homeController = Get.find<HomeController>();
          homeController.fetchBlogs();
        }
      } catch (e) {
        print(e.toString());
      }
    }
    super.onClose();
  }
}
