import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/extensions/extensions.dart';

class AddNoteBottomSheet extends StatelessWidget {
  final VoidCallback? navigateToAddNote;
  final VoidCallback? navigateToAddTodo;

  const AddNoteBottomSheet({
    super.key,
    this.navigateToAddNote,
    this.navigateToAddTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: context.screenWidth,
        height: 190.h,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "New",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.text,
                ),
              ),
            ),
            20.verticalSpace,
            InkWell(
              onTap: () {
                context.pop();
                navigateToAddNote?.call();
              },
              child: Row(
                children: [
                  Icon(Icons.keyboard, color: AppColors.text, size: 36.sp),
                  20.horizontalSpace,
                  Text(
                    "Add note",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
            12.verticalSpace,
            InkWell(
              onTap: () {
                context.pop();
                navigateToAddTodo?.call();
              },
              child: Row(
                children: [
                  Icon(Icons.check_box, color: AppColors.text, size: 36.sp),
                  20.horizontalSpace,
                  Text(
                    "Add to-do",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
