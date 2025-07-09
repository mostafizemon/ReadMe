import 'package:blog/binding/add_new_blog_binding.dart';
import 'package:blog/binding/blog_details_binding.dart';
import 'package:blog/binding/home_binding.dart';
import 'package:blog/binding/login_binding.dart';
import 'package:blog/binding/signup_binding.dart';
import 'package:blog/binding/splash_binding.dart';
import 'package:blog/routes/app_routes.dart';
import 'package:blog/screens/add_new_blog/add_new_blog_screen.dart';
import 'package:blog/screens/blog_details_screen/blog_details_screen.dart';
import 'package:blog/screens/splash_screen/splash_screen.dart';
import 'package:get/get.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/signup_screen/signup_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.blogDetailsScreen,
      page: () => BlogDetailsScreen(),
      binding: BlogDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.addNewBlogScreen,
      page: () => AddNewBlogScreen(),
      binding: AddNewBlogBinding(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),
  ];
}
