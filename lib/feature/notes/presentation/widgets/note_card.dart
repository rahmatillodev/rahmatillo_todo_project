import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NoteCard extends StatelessWidget {
  final Note note;
  final bool isGrid;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.isGrid,
    required this.onTap,
  });

  double getCardHeight(String text) {
    final int length = text.length;
    if (isGrid) {
      if (length < 10) return 150.h;
      if (length < 30) return 200.h;
      return 250.h;
    } else {
      if (length < 10) return 100.h;
      if (length < 30) return 130.h;
      return 160.h;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(
      int.parse(note.color?.replaceFirst('#', '0xFF') ?? '0xFFFFFFFF'),
    );
    final height = getCardHeight(
      note.title.trim().isNotEmpty ? note.title : note.content,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: height,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: AppColors.text),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.isTodo) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: note.todoItems.length > 4
                      ? 4
                      : note.todoItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = note.todoItems[index];
                    return Row(
                      children: [
                        Icon(
                          item.isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 18.sp,
                          color: AppColors.text,
                        ),
                        6.horizontalSpace,
                        Expanded(
                          child: Text(
                            item.text,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 16.sp,
                              decoration: item.isDone
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: AppColors.text,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ] else ...[
              // Regular note rendering
              Text(
                note.title.trim().isNotEmpty ? note.title : note.content,
                maxLines: height > 170 ? 6 : 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              const Spacer(),
            ],

            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timeago.format(note.createdAt),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
