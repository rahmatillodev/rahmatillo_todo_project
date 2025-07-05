import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/notes/presentation/bloc/note_storage_service.dart';
import 'package:todo/feature/notes/presentation/bloc/color_filter_service.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';
import 'package:todo/feature/notes/presentation/widgets/edit_color_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;
  final bool isEditing;

  const AddNotePage({super.key, this.note, this.isEditing = false});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // debugPrint(widget.note.toString());
    if (widget.isEditing && widget.note != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _titleController.text = widget.note!.title;
        _contentController.text = widget.note!.content;
      });

      selectedColor = Color(
        int.parse(
          widget.note!.color?.replaceFirst('#', '0xFF') ?? '0xFFFFFFFF',
        ),
      );
    } else {
      final color = await ColorFilterService.loadSelectedColor();
      selectedColor = color ?? Colors.white;
    }

    setState(() {});
  }

  Future<void> _saveNoteIfNeeded() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty && content.isEmpty) return;

    final noteColorHex =
        '#${(selectedColor ?? Colors.white).value.toRadixString(16).substring(2).toUpperCase()}';
    final allNotes = await NoteStorageService.loadNotes();

    if (widget.isEditing && widget.note != null) {
      final index = allNotes.indexWhere((n) => n.id == widget.note!.id);
      if (index != -1) {
        allNotes[index] = Note(
          id: widget.note!.id,
          title: title,
          content: content,
          createdAt: widget.note!.createdAt,
          color: noteColorHex,
        );
      }
    } else {
      final note = Note(
        id: const Uuid().v4(),
        title: title,
        content: content,
        createdAt: DateTime.now(),
        color: noteColorHex,
      );
      allNotes.add(note);
    }

    await NoteStorageService.saveNotes(allNotes);
  }

  Future<void> _deleteNote() async {
    if (widget.isEditing && widget.note != null) {
      final allNotes = await NoteStorageService.loadNotes();
      allNotes.removeWhere((n) => n.id == widget.note!.id);
      await NoteStorageService.saveNotes(allNotes);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _saveNoteIfNeeded();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
            onPressed: () async {
              await _saveNoteIfNeeded();
              context.pop();
            },
          ),
          title: Text(
            widget.isEditing ? 'Notes' : 'Add Note',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, color: AppColors.text, size: 28.sp),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  builder: (_) => EditColorBottomSheet(
                    onDelete: () async {
                      await _deleteNote();
                      if (mounted) context.pop(); // close modal
                    },
                    onColorSelected: (color) {
                      setState(() {
                        selectedColor = color;
                      });
                    },
                  ),
                );
              },
            ),
            12.horizontalSpace,
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w600),
                decoration: const InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
              ),
              12.verticalSpace,
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 18.sp),
                  decoration: const InputDecoration(
                    hintText: "Start typing...",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
