import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/to_do_model.dart';
import '../pages/task_ditails.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Stream<List<ToDoModel>> getTasks() {
    return FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ToDoModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }

  void toggleTask(String id, bool currentValue) {
    FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'isDone': !currentValue,
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDoModel>>(
      stream: getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks available.'));
        }

        final tasks = snapshot.data!;

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
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: task.isDone
                        ? Colors.greenAccent
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.isDone
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    task.description,
                    style: TextStyle(
                      color: task.isDone ? Colors.grey : Colors.black54,
                    ),
                  ),
                  trailing: Wrap(
                    spacing: 2,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () => deleteTask(task.id),
                      ),
                      Checkbox(
                        activeColor: Colors.green,
                        value: task.isDone,
                        onChanged: (_) => toggleTask(task.id, task.isDone),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final updatedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            TaskDetails(task: task),
                      ),
                    );
                    if (updatedData != null) {
                      // Firestore update
                      await FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(task.id) // task এর id ব্যবহার
                          .update({
                            'title': updatedData['title'],
                            'description': updatedData['description'],
                          });
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
