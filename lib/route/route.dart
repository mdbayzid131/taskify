import 'package:get/get.dart';
import 'package:taskify/pages/add_task_page.dart';
import 'package:taskify/pages/homePage.dart';
import 'package:taskify/pages/task_ditails.dart';

class RoutePages{

  static String homePage= '/';
  static String addTask= '/addTask';
  static String taskDetails= '/taskDetails';
}
final getPages=[
  GetPage(name: RoutePages.homePage, page: ()=>Homepage()),
  GetPage(name: RoutePages.addTask, page: ()=>AddTaskPage()),
  GetPage(name: RoutePages.taskDetails, page: ()=>TaskDetails())
];