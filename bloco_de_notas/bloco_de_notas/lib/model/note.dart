import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
    String? id;
    String noteName;
    String noteText;
    String? userId;

    Note({
        this.id,
        required this.noteName,
        required this.noteText,
        this.userId,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        noteName: json["noteName"],
        noteText: json["noteText"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "noteName": noteName,
        "noteText": noteText,
        "userId" : userId,
    };
}
