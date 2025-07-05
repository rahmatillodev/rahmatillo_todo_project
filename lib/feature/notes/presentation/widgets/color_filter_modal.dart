import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/notes/presentation/bloc/color_filter_service.dart';
import 'package:todo/feature/notes/data/notes_colors.dart';

class ColorFilterModalDialog extends StatelessWidget {
  final void Function(Color?) onColorSelected;

  const ColorFilterModalDialog({super.key, required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 70.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Filter by colour",
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400,color: AppColors.text),
                ),
              ),
              20.verticalSpace,
              SizedBox(
                width: 100.w,
                height: 40.h,
                child: OutlinedButton(
                  onPressed: () async {
                      Navigator.pop(context);
                      await ColorFilterService.saveSelectedColor(null);
                      onColorSelected(null);
                  },
                  child: Text('Reset', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400,color: AppColors.text)),
                ),
              ),
              24.verticalSpace,
              Wrap(
                spacing: 14.w,
                runSpacing: 24.h,
                children: [
                  ...noteColors.map((color) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await ColorFilterService.saveSelectedColor(color.color);
                        onColorSelected(color.color);
                      },
                      child: Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: color.color,
                          borderRadius: BorderRadius.circular(24.r),
                          border: Border.all(color: AppColors.text,width: 1.w)
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
