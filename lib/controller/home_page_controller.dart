import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/to_do_model.dart';

class HomePageController extends GetxController{
///<================home page==================>///
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



///<================task details page==================>///





}