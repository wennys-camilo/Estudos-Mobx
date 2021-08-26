import 'dart:convert';

class Todo {
  int id;
  String title;
  bool done;
  Todo({
    this.id,
    this.title,
    this.done,
  });

  Todo copyWith({
    int id,
    String title,
    bool done,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      done: map['done'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() => 'Todo(id: $id, title: $title, done: $done)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.done == done;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;
}
