class Note {
  int? id;
  String content;

  Note({this.id, required this.content});

  factory Note.fromMap(Map<String, dynamic> json) =>
      Note(id: json["id"] as int, content: json["content"] as String);

  Map<String, dynamic> toMap() => {"content": content};
}
