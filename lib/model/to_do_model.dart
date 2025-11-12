class ToDoModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isDone = false,
  });

  // 🔸 Firebase থেকে ডাটা পাওয়ার সময় কনভার্ট করতে
  factory ToDoModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ToDoModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  // 🔸 Firebase এ ডাটা পাঠানোর সময় কনভার্ট করতে
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
