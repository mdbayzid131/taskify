import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskify/route/route.dart';
import '../widgets/to_do _list.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Taskify ToDo List', style: TextStyle(fontSize: 20)),
        actions: [
          Icon(Icons.calendar_month_outlined, size: 25),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(children: [ToDoList()]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          Get.toNamed(RoutePages.addTask);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
