class ToDoModel {
  final String id;
   String title;
   String description;
  final bool isDone;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  // Convert data when receiving from Firebase
  factory ToDoModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ToDoModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  // Convert data when sending to Firebase

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
