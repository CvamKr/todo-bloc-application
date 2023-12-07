import 'package:equatable/equatable.dart';
class Todo extends Equatable {
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

  Todo copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
