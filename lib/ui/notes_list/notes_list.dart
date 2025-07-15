import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/services/database_service.dart';
import 'package:notes/ui/notes_list/note_list_item.dart';
import 'package:notes/ui/theme/colors.dart';
import 'package:notes/utils/routes.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  late Future<List<NoteModel>?> _data;
  Future<List<NoteModel>?> _getData() async {
    final service = DatabaseService();
    return await service.getNotes();
  }

  @override
  void initState() {
    _data = _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundNotesList,
      appBar: AppBar(
        title: const Text(
          "Public Notes",
          style: TextStyle(color: AppColors.text),
        ),
        centerTitle: true,
        backgroundColor: AppColors.topBarNotesList,
        surfaceTintColor: AppColors.topBarNotesList,
      ),
      body: FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.circularProgressIndicator,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: AppColors.text),
              ),
            );
          } else {
            return _buildNotesList(snapshot.data);
          }
        },
      ),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _buildNotesList(List<NoteModel>? items) {
    if (items?.isEmpty == true) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No notes yet", style: TextStyle(color: AppColors.text)),
            SvgPicture.asset(
              'assets/icons/ic_missing_notes.svg',
              colorFilter: ColorFilter.mode(
                AppColors.missingNoteIcon,
                BlendMode.srcIn,
              ),
              height: 32,
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: items?.length,
      itemBuilder: (context, index) {
        final double paddingBottom;
        if (index == (items?.length ?? 0) - 1) {
          paddingBottom = 90.0;
        } else {
          paddingBottom = 8.0;
        }
        return Padding(
          padding: EdgeInsets.only(
            right: 16.0,
            left: 16.0,
            top: 8.0,
            bottom: paddingBottom,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.NoteDetails,
                arguments: items?[index],
              ).then((_) {
                setState(() {
                  _data = _getData();
                });
              });
            },
            child: NoteListItem(items: items, index: index),
          ),
        );
      },
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.NoteDetails).then((_) {
          setState(() {
            _data = _getData();
          });
        });
      },
      backgroundColor: AppColors.fab,
      child: Icon(Icons.add, color: AppColors.fabIcon),
    );
  }
}
