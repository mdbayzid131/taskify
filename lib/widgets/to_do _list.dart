import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/controller/home_page_controller.dart';
import 'package:taskify/route/route.dart';
import '../model/to_do_model.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final _controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.tasks.isEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            const Center(
              child: Text(
                'No tasks available.',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ],
        );
      }

      final tasks = _controller.tasks;

      return ListView.builder(
        itemCount: tasks.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final task = tasks[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Card(
              color: task.isDone ? Colors.green.shade50 : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: task.isDone
                      ? Colors.greenAccent
                      : Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                title: Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Column(
                  children: [
                    SizedBox(height: 5),
                    Text(
                      task.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: task.isDone ? Colors.grey : Colors.black54,
                      ),
                    ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 2,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _controller.deleteTask(task.id),
                    ),
                    Checkbox(
                      activeColor: Colors.green,
                      value: task.isDone,
                      onChanged: (_) =>
                          _controller.toggleTask(task.id, task.isDone),
                    ),
                  ],
                ),
                onTap: () async {
                  final updatedData = await Get.toNamed(
                    RoutePages.taskDetails,
                    arguments: task,
                  );

                  if (updatedData != null) {
                    //  Update local UI
                    _controller.updateTaskInList(task.id, updatedData);
                  }
                },
              ),
            ),
          );
        },
      );
    });
  }
}
