import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? title;
  String? description;
  Timestamp? date;
  String? id;

  NoteModel({this.title, this.description, this.date, this.id});

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'date': date};
  }

  factory NoteModel.fromJson(Map<String, dynamic> json, String id) {
    return NoteModel(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      id: id,
    );
  }
}
