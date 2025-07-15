import 'package:flutter/material.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/ui/theme/colors.dart';

class NoteListItem extends StatelessWidget {
  final List<NoteModel>? items;
  final int index;
  const NoteListItem({super.key, required this.items, required this.index});


  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
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
                        color: AppColors.text,
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
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}