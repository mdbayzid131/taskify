import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/to_do_model.dart';

class TaskDetails extends StatefulWidget {

  const TaskDetails({super.key, });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late bool isReadOnly;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late ToDoModel task;

  @override
  void didChangeDependencies() {
    task = Get.arguments as ToDoModel;
    isReadOnly = true;
    titleController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  toggleEditOrSave() async {
    if (isReadOnly) {
      // Enable editing
      setState(() => isReadOnly = false);
    } else {
      // Save mode
      setState(() => isReadOnly = true);

      try {
        // ✅ Firestore update call
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(task.id)
            .update({
          'title': titleController.text.trim(),
          'description': descriptionController.text.trim(),
        });

        Get.snackbar(
          'Success',
          'Task updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(milliseconds: 1200),
        );

        // ✅ Return updated data to UI
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back(result: {
          'title': titleController.text.trim(),
          'description': descriptionController.text.trim(),
        });
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update task: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Task Details",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.calendar_month_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              readOnly: isReadOnly,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: "Task Title",
                hintStyle: const TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderSide:  BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              readOnly: isReadOnly,
              maxLines: 7,
              style: const TextStyle(fontSize: 16, height: 1.4),
              decoration: InputDecoration(
                hintText: "Description",
                alignLabelWithHint: true,
                hintStyle: const TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide:  BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: toggleEditOrSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: isReadOnly ? Theme.of(context).colorScheme.primary : Colors.green,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(
                isReadOnly ? Icons.edit : Icons.save,
                color: Colors.white,
              ),
              label: Text(
                isReadOnly ? 'Edit Task' : 'Save Changes',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
