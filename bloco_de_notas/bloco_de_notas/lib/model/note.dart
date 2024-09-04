class Note {
  String? id;
  String? noteName;
  String? noteText;

  Note({this.id, this.noteName, this.noteText});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
    id: json['_id'] as String?,
    noteName: json['noteName'] as String?,
    noteText: json['noteText'] as String?,
  );}

  Map<String, dynamic> toJson() {
    return {
      'noteName' : noteName,
      'noteText' : noteText,
    };
  }
}
