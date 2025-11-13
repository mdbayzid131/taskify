import 'package:get/get.dart';
import 'package:taskify/pages/add_task_page.dart';
import 'package:taskify/pages/homePage.dart';
import 'package:taskify/pages/task_ditails.dart';

import '../pages/login_page.dart';
import '../pages/sign_up_page.dart';
import '../pages/splash_page.dart';

class RoutePages{

  static String splashPage= '/';
  static String loginPage= '/loginPage';
  static String signUpPage= '/signUpPage';
  static String homePage= '/homePage';
  static String addTask= '/addTask';
  static String taskDetails= '/taskDetails';
}
final getPages=[
  GetPage(name: RoutePages.splashPage, page: ()=>SplashPage()),
  GetPage(name: RoutePages.loginPage, page: ()=>LoginPage()),
  GetPage(name: RoutePages.signUpPage, page: ()=>SignUpPage()),
  GetPage(name: RoutePages.homePage, page: ()=>Homepage()),
  GetPage(name: RoutePages.addTask, page: ()=>AddTaskPage()),
  GetPage(name: RoutePages.taskDetails, page: ()=>TaskDetails())
];