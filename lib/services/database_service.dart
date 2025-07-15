import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/models/notes_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addNote({required NoteModel model}) async {
    //loading started, show loader
    CollectionReference notes = FirebaseFirestore.instance.collection('notes');
    //loading stopped
    //check if happened error
    // if not error return some success e.g. boolean true and close screen
    // if error return error text and display it
    await notes.add(model.toJson());
  }

  Future<List<NoteModel>?> getNotes() async {
    QuerySnapshot querySnapshot =
        await _db.collection("notes").orderBy("date", descending: true).get();
    List<NoteModel> notes = [];
    for (var docSnapshot in querySnapshot.docs) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      final model = NoteModel.fromJson(data, docSnapshot.id);
      notes.add(model);
    }
    return notes;
  }

  Future<void> deleteNote(String id) async {
    await _db.collection('notes').doc(id).delete();
  }

  Future<void> updateNote({required NoteModel model}) async {
    await _db.collection('notes').doc(model.id).update(model.toJson());
  }
}
