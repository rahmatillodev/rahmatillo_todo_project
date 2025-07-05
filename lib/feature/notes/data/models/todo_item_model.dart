class TodoItem {
  final String text;
  final bool isDone;

  TodoItem({required this.text, this.isDone = false});

  TodoItem copyWith({String? text, bool? isDone}) {
    return TodoItem(text: text ?? this.text, isDone: isDone ?? this.isDone);
  }

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(text: json['text'], isDone: json['isDone'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isDone': isDone};
  }
}
