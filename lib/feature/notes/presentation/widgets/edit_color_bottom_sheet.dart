import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/feature/notes/data/notes_colors.dart';

class EditColorBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final void Function(Color) onColorSelected;

  const EditColorBottomSheet({
    super.key,
    required this.onDelete,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 40.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(42.w, 32.h, 0.w, 32.h),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.delete_outline,
                size: 36.sp,
                color: AppColors.text,
              ),
              title: Text(
                'Delete note',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
            ),
          ),
          Container(
            color: AppColors.text,
            width: context.screenWidth,
            height: 1.h,
          ),
          16.verticalSpace,
          Center(
            child: Text(
              "Select Colour",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
            ),
          ),
          16.verticalSpace,
          Padding(
            padding: EdgeInsets.fromLTRB(42.w, 0.h, 42.w, 32.h),
            child: Center(
              child: Wrap(
                spacing: 24.w,
                runSpacing: 16.h,
                children: [
                  ...noteColors.map((noteColor) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onColorSelected(noteColor.color);
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: noteColor.color,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.text, width: 1.w),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
