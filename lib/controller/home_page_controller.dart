import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/to_do_model.dart';

class HomePageController extends GetxController {
  RxList<ToDoModel> tasks = <ToDoModel>[].obs;
  StreamSubscription? _subscription;

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  void onInit() {
    super.onInit();
    _subscription = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => ToDoModel.fromMap(doc.data(), doc.id))
        .toList())
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  Future<void> toggleTask(String id, bool value) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .update({'isDone': !value});
  }

  void updateTaskInList(String id, Map<String, dynamic> updatedData) {
    int index = tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      tasks[index] = tasks[index].copyWith(
        title: updatedData['title'],
        description: updatedData['description'],
      );
      tasks.refresh();
    }
  }
}
