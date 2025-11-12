import 'package:flutter/material.dart';

import '../model/to_do_model.dart';

class TaskDetails extends StatefulWidget {
  final ToDoModel task;
  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  late bool isReadOnly;
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    // ✅ Initialize values from passed task
    isReadOnly = true;
    titleController = TextEditingController(text: widget.task.title);
    descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

   toggleEditOrSave() {
    if (isReadOnly) {
      // 📝 Enable editing mode
      setState(() => isReadOnly = false);
    } else {
      // 💾 Save mode
      setState(() => isReadOnly = true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(' Task updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 800),
        ),
      );

      // 🕒 Pop back with updated data
      Future.delayed(const Duration(milliseconds: 600), () {
        Navigator.pop(context, {
         "title" : titleController.text.trim(),
          "description": descriptionController.text.trim(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final task =widget.task;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        title: Text(
          task.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
                labelText: "Task Title",
                labelStyle: const TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
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
                labelText: "Description",
                alignLabelWithHint: true,
                labelStyle: const TextStyle(color: Colors.blueGrey),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: toggleEditOrSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: isReadOnly ? Colors.blueAccent : Colors.green,
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
