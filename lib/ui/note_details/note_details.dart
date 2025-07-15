import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notes/dialog/confirm_dialog.dart';
import 'package:notes/models/notes_model.dart';
import 'package:notes/services/database_service.dart';
import 'package:notes/theme/colors.dart';
import 'package:notes/utils/routes.dart';

class NoteDetails extends StatefulWidget {
  const NoteDetails({super.key});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final service = DatabaseService();
  NoteModel? _noteData;
  var _isSaveBtnActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_noteData == null) {
      _noteData = ModalRoute.of(context)?.settings.arguments as NoteModel?;
      if (_noteData != null) {
        _titleController.text = _noteData!.title ?? '';
        _descriptionController.text = _noteData!.description ?? '';
      }
    }
  }

  void _sendData() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    showDialog(
      context: context,
      builder:
          (_) => const Center(
            child: CircularProgressIndicator(color: AppColors.fabColor),
          ),
      barrierDismissible: false,
    );

    try {
      await service.addNote(
        model: NoteModel(
          title: title,
          description: description,
          date: Timestamp.fromDate(DateTime.now()),
        ),
      );

      if (mounted) {
        Navigator.pop(context);
        Navigator.of(context).popUntil(ModalRoute.withName(Routes.NotesList));
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to save note: $e")));
      }
    }
  }

  void _updateData() async {
    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    _noteData?.title = title;
    _noteData?.description = description;
    _noteData?.date = Timestamp.fromDate(DateTime.now());

    showDialog(
      context: context,
      builder:
          (_) => const Center(
            child: CircularProgressIndicator(color: AppColors.fabColor),
          ),
      barrierDismissible: false,
    );

    try {
      final service = DatabaseService();
      if (_noteData != null) {
        await service.updateNote(model: _noteData!);
      }
      if (mounted) {
        Navigator.pop(context);
        Navigator.of(context).popUntil(ModalRoute.withName(Routes.NotesList));
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to update note: $e")));
      }
    }
  }

  void _updateSaveBtn(bool isTitle) {
    _isSaveBtnActive = true;

    String title = _titleController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isEmpty && description.isEmpty) {
      _isSaveBtnActive = false;
      return;
    }

    if (isTitle) {
      if (_noteData?.title == title) {
        _isSaveBtnActive = false;
      }
    } else {
      if (_noteData?.description == description) {
        _isSaveBtnActive = false;
      }
    }
  }

  void _deleteNote(String id) async {
    showConfirmDialog(
      context: context,
      onPositiveAction: () async {
        showDialog(
          context: context,
          builder:
              (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.fabColor),
              ),
          barrierDismissible: false,
        );

        try {
          final service = DatabaseService();
          await service.deleteNote(id);

          if (mounted) {
            Navigator.pop(context);
            Navigator.of(
              context,
            ).popUntil(ModalRoute.withName(Routes.NotesList));
          }
        } catch (e) {
          if (mounted) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("failed to delete note $e")));
          }
        }
      },
      onNegativeAction: () {
        Navigator.of(context).pop();
      },
      title: "Confirm Delete",
      description: "Are you sure you want to delete this note?",
      positiveActionTitle: "Delete",
      negativeActionTitle: "Cancel",
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(36, 40, 59, 1),
        appBar: _topAppBar(context, _isSaveBtnActive),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(child: _buildScreenContent()),
        ),
        floatingActionButton:
            _noteData == null
                ? const SizedBox()
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _deleteButton(_noteData?.id ?? ""),
                ),
      ),
    );
  }

  Widget _buildScreenContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: (value) {
            setState(() {
              _updateSaveBtn(true);
            });
          },
          controller: _titleController,
          cursorColor: AppColors.fabColor,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Title',
            hintStyle: TextStyle(color: AppColors.hintTextColor),
          ),
          maxLines: null,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 110),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                _updateSaveBtn(false);
              });
            },
            controller: _descriptionController,
            cursorColor: AppColors.fabColor,
            style: TextStyle(fontSize: 24, color: AppColors.textColor),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Start typing your note...',
              hintStyle: TextStyle(color: AppColors.hintTextColor),
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }

  AppBar _topAppBar(BuildContext context, bool isSaveBtnActive) {
    return AppBar(
      backgroundColor: AppColors.cardColor,
      surfaceTintColor: AppColors.cardColor,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: AppColors.fabColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: TextButton(
            onPressed: () {
              if (_isSaveBtnActive) {
                (_noteData == null ? _sendData : _updateData)();
              }
            },
            child: Text(
              "Save",
              style: TextStyle(
                color:
                    _isSaveBtnActive
                        ? AppColors.fabColor
                        : AppColors.hintTextColor,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _deleteButton(String id) {
    return FloatingActionButton(
      onPressed: () {
        _deleteNote(id);
      },
      backgroundColor: AppColors.fabColor,
      child: SvgPicture.asset("assets/icons/ic_delete.svg"),
    );
  }
}
