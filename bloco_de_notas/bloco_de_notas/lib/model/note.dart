class Note {
    String id;
    String noteName;
    String noteText;
    String userId;

    Note({
        required this.id,
        required this.noteName,
        required this.noteText,
        required this.userId,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"].toString(),
        noteName: json["noteName"].toString(),
        noteText: json["noteText"].toString(),
        userId: json["userId"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "noteName": noteName,
        "noteText": noteText,
        "userId" : userId,
    };
}
