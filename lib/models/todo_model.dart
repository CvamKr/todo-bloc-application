class Todo {
  int id;
  String title;
  bool isCompleted;

  Todo({
    this.id = 0,
    this.title = '',
    this.isCompleted = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': DateTime.now().millisecondsSinceEpoch,
      "id": id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}
