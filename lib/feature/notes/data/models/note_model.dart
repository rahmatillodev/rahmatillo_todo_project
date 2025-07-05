import 'dart:convert';

import 'package:todo/feature/notes/data/models/todo_item_model.dart';

class Note {
  final String id;
  final String title;
  final String content; // still JSON encoded string
  final DateTime createdAt;
  final String? color;
  final bool isTodo;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.color,
    this.isTodo = false,
  });

  Note copyWith({String? title, String? content, String? color, bool? isTodo}) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      color: color ?? this.color,
      isTodo: isTodo ?? this.isTodo,
    );
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      color: json['color'],
      isTodo: json['isTodo'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'color': color,
      'isTodo': isTodo,
    };
  }

  List<TodoItem> get todoItems {
    if (!isTodo) return [];
    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList.map((e) => TodoItem.fromJson(e)).toList();
  }

  static String encodeTodoItems(List<TodoItem> items) {
    return jsonEncode(items.map((e) => e.toJson()).toList());
  }
}
