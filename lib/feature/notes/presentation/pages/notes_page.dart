import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';
import 'package:todo/feature/notes/presentation/bloc/color_filter_service.dart';
import 'package:todo/feature/notes/presentation/bloc/note_storage_service.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';
import 'package:todo/feature/notes/presentation/widgets/add_note_bottom_sheet.dart';
import 'package:todo/feature/notes/presentation/widgets/color_filter_modal.dart';
import 'package:todo/feature/notes/presentation/widgets/note_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool viewNote = true;
  Color? selectedColor;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadColorAndNotes();
  }

  Future<void> _loadColorAndNotes() async {
    final allNotes = await NoteStorageService.loadNotes();
    final color = await ColorFilterService.loadSelectedColor();
    final filtered = color == null
        ? allNotes
        : allNotes.where((note) {
            final hex =
                '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
            return note.color == hex;
          }).toList();
    setState(() {
      selectedColor = color;
      notes = filtered.reversed.toList();
    });
  }

  void _openNoteDetail(Note note) async {
    // debugPrint(note.isTodo.toString());
    if (note.isTodo) {
      await context.push('/addTodo', extra: note);
    } else {
      await context.push('/addNote', extra: note);
    }
    await _loadColorAndNotes();
  }

  void _navigateToAddNote() async {
    await context.push("/addNote");
    await _loadColorAndNotes();
  }

  void _navigateToAddTodo() async {
    await context.push("/addTodo");
    await _loadColorAndNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 35.sp),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens, color: AppColors.text, size: 30.sp),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return StatefulBuilder(
                    builder: (context, setDialogState) {
                      return ColorFilterModalDialog(
                        onColorSelected: (color) async {
                          await ColorFilterService.saveSelectedColor(color);
                          await _loadColorAndNotes();
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          16.horizontalSpace,
          IconButton(
            icon: Icon(
              viewNote ? Icons.grid_view : Icons.splitscreen,
              color: AppColors.text,
              size: 30.sp,
            ),
            onPressed: () {
              setState(() {
                viewNote = !viewNote;
              });
            },
          ),
          16.horizontalSpace,
        ],
      ),
      body: notes.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Center(child: SvgPicture.asset(AppImages.notes, width: 210.w)),
                26.verticalSpace,
                Text(
                  'Create your first note!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Spacer(flex: 3),
              ],
            )
          : Padding(
              padding: EdgeInsets.all(16.r),
              child: viewNote
                  ? ListView.separated(
                      itemCount: notes.length,
                      separatorBuilder: (_, __) => 24.verticalSpace,
                      itemBuilder: (context, index) {
                        final note = notes[index];
                        return NoteCard(
                          note: note,
                          isGrid: false,
                          onTap: () => _openNoteDetail(note),
                        );
                      },
                    )
                  : SingleChildScrollView(
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        children: notes.map((note) {
                          return NoteCard(
                            note: note,
                            isGrid: true,
                            onTap: () => _openNoteDetail(note),
                          );
                        }).toList(),
                      ),
                    ),
            ),
      floatingActionButton: SizedBox(
        width: 70.w,
        height: 70.h,
        child: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              isScrollControlled: true,
              builder: (context) => AddNoteBottomSheet(
                navigateToAddNote: _navigateToAddNote,
                navigateToAddTodo: _navigateToAddTodo,
              ),
            );
          },
          shape: const CircleBorder(),
          child: Icon(Icons.add, size: 36.sp, color: AppColors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
