class ToDoModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });


  factory ToDoModel.fromMap(Map<String, dynamic> map, String id) {
    return ToDoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  ToDoModel copyWith({
    String? title,
    String? description,
    bool? isDone,
  }) {
    return ToDoModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  //
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
