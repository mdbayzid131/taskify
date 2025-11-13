import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/to_do_model.dart';

class HomePageController extends GetxController {
  ///<================home page==================>///

  RxList<ToDoModel> tasks = <ToDoModel>[].obs;
  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscription = FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ToDoModel.fromMap(doc.data(), doc.id))
              .toList(),
        )
        .listen((taskList) {
          tasks.assignAll(taskList);
        });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  Future<void> deleteTask(String id) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  Future<void> toggleTask(String id, bool currentValue) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'isDone': !currentValue,
    });
  }

  void updateTaskInList(String id, Map<String, dynamic> updatedData) {
    int index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(
        title: updatedData['title'],
        description: updatedData['description'],
      );
      tasks.refresh(); // 🔥 Obx এর জন্য refresh দরকার
    }
  }



///<================task details page==================>///
}
