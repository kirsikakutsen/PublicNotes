import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/services/database_service.dart';
import 'package:notes/theme/colors.dart';
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Public Notes",
          style: TextStyle(color: AppColors.textColor),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
      ),
      body: FutureBuilder(
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.fabColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(color: AppColors.textColor),
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
            Text("No notes yet", style: TextStyle(color: AppColors.textColor)),
            SvgPicture.asset(
              'assets/icons/ic_missing_notes.svg',
              colorFilter: ColorFilter.mode(
                AppColors.textColor,
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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      items?[index].title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      items?[index].description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.NoteDetails,).then((_) {
          setState(() {
            _data = _getData();
          });
        });
      },
      backgroundColor: AppColors.fabColor,
      child: Icon(Icons.add, color: AppColors.backgroundColor),
    );
  }
}
