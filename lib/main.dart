import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/ui/note_details/note_details.dart';
import 'package:notes/ui/notes/notes_list.dart';
import 'package:notes/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/notesList',
      routes: {
        Routes.NoteDetails: (context) => const NoteDetails(),
        Routes.NotesList: (context) => const NotesList(),
      },
    );
  }
}
