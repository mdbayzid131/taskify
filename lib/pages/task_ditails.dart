import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/task_details_controller.dart';


class TaskDetails extends StatelessWidget {
  TaskDetails({super.key});

  final TaskDetailsController controller = Get.put(TaskDetailsController());

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
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.titleController,
                  readOnly: controller.isReadOnly.value,
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
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.descriptionController,
                  readOnly: controller.isReadOnly.value,
                  maxLines: 7,
                  style: const TextStyle(fontSize: 16, height: 1.4),
                  decoration: InputDecoration(
                    hintText: "Description",
                    alignLabelWithHint: true,
                    hintStyle: const TextStyle(color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: controller.toggleEditOrSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isReadOnly.value
                        ? Theme.of(context).colorScheme.primary
                        : Colors.green,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: Icon(
                    controller.isReadOnly.value ? Icons.edit : Icons.save,
                    color: Colors.white,
                  ),
                  label: Text(
                    controller.isReadOnly.value ? 'Edit Task' : 'Save Changes',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
              ),
      ),
    );
  }
}
