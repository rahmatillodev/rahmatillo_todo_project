import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/notes/presentation/bloc/color_filter_service.dart';
import 'package:todo/feature/notes/presentation/bloc/note_storage_service.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';
import 'package:todo/feature/notes/data/models/todo_item_model.dart';
import 'package:todo/feature/notes/presentation/widgets/edit_color_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class AddToDoPage extends StatefulWidget {
  final Note? note;
  final bool isEditing;

  const AddToDoPage({super.key, this.note, this.isEditing = false});

  @override
  State<AddToDoPage> createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final TextEditingController _taskInputController = TextEditingController();
  List<TodoItem> tasks = [];
  Color? selectedColor;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    if (widget.isEditing && widget.note != null) {
      try {
        final jsonList = jsonDecode(widget.note!.content) as List<dynamic>;
        tasks = jsonList.map((e) => TodoItem.fromJson(e)).toList();
      } catch (_) {
        tasks = [];
      }

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

  void _addTask() {
    final text = _taskInputController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        tasks.add(TodoItem(text: text));
        _taskInputController.clear();
      });
    }
  }

  void _toggleCheckbox(int index, bool? value) {
    setState(() {
      tasks[index] = tasks[index].copyWith(isDone: value ?? false);
    });
  }

  void _updateTaskText(int index, String value) {
    setState(() {
      tasks[index] = tasks[index].copyWith(text: value);
    });
  }

  Future<void> _saveTodoIfNeeded() async {
    if (tasks.isEmpty || tasks.every((t) => t.text.trim().isEmpty)) return;

    final jsonTasks = jsonEncode(tasks.map((t) => t.toJson()).toList());

    final noteColorHex =
        '#${(selectedColor ?? Colors.white).value.toRadixString(16).substring(2).toUpperCase()}';
    final allNotes = await NoteStorageService.loadNotes();

    if (widget.isEditing && widget.note != null) {
      final index = allNotes.indexWhere((n) => n.id == widget.note!.id);
      if (index != -1) {
        allNotes[index] = Note(
          id: widget.note!.id,
          title: '',
          content: jsonTasks,
          createdAt: widget.note!.createdAt,
          color: noteColorHex,
          isTodo: true,
        );
      }
    } else {
      final note = Note(
        id: const Uuid().v4(),
        title: "",
        content: jsonTasks,
        createdAt: DateTime.now(),
        color: noteColorHex,
        isTodo: true,
      );
      debugPrint(note.isTodo.toString());
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _saveTodoIfNeeded();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
            onPressed: () async {
              await _saveTodoIfNeeded();
              context.pop();
            },
          ),
          title: Text(
            widget.isEditing ? 'Edit To-do' : 'Add To-do',
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
                      if (mounted) context.pop();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add, size: 24.sp, color: AppColors.grey),
                  12.horizontalSpace,
                  Expanded(
                    child: TextField(
                      controller: _taskInputController,
                      onSubmitted: (_) => _addTask(),
                      decoration: const InputDecoration(
                        hintText: "Type something...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Expanded(
                child: ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => 4.verticalSpace,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return SizedBox(
                      height: 40.h,
                      child: Row(
                        children: [
                          Checkbox(
                            value: task.isDone,
                            onChanged: (val) => _toggleCheckbox(index, val),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: task.text)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(offset: task.text.length),
                                ),
                              onChanged: (value) =>
                                  _updateTaskText(index, value),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                fontSize: 16.sp,
                                decoration: task.isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: task.isDone ? Colors.grey : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
