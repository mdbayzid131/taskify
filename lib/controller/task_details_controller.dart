import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/to_do_model.dart';

class TaskDetailsController extends GetxController {
  final isReadOnly = true.obs;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late ToDoModel task;

  @override
  void onInit() {
    task = Get.arguments as ToDoModel;
    titleController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  toggleEditOrSave() async {
    if (isReadOnly.value) {
      // Enable editing
      isReadOnly.value = false;
    } else {
      // Save mode
      isReadOnly.value = true;

      try {
        String uid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('tasks')
            .doc(task.id)
            .update({
              'title': titleController.text.trim(),
              'description': descriptionController.text.trim(),
            });

        Get.snackbar(
          'Success',
          'Task updated successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 1200),
        );

        await Future.delayed(const Duration(milliseconds: 1000));
        Get.back(
          result: {
            'title': titleController.text.trim(),
            'description': descriptionController.text.trim(),
          },
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update task: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }
}
