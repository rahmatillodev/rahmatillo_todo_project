import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/feature/help/presentation/widgets/help_card.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Help",
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                24.verticalSpace,
                Container(
                  margin: EdgeInsets.only(left: 20.w, bottom: 40.h),
                  child: Text(
                    "User Guide",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),

          32.verticalSpace,
          SizedBox(
            width: context.screenWidth * 0.85,
            child: Column(
              children: [
                HelpCard(
                  icon: Icons.sticky_note_2_outlined,
                  title: 'Notes',
                  subtitle: 'Tap to view',
                  onTap: () {
                    debugPrint("Notes tapped");
                  },
                ),
                32.verticalSpace,
                HelpCard(
                  icon: Icons.image_search_outlined,
                  title: 'OCR',
                  subtitle: 'Tap to view',
                  onTap: () {
                    debugPrint("OCR tapped");
                  },
                ),
                32.verticalSpace,
                HelpCard(
                  icon: Icons.lock_outline,
                  title: 'Reset Password',
                  subtitle: 'Tap to view',
                  onTap: () {
                    debugPrint("Reset Password tapped");
                  },
                ),
              ],
            ),
          ),

          const Spacer(), // Faqat pastdan bo‘shliq bo‘lishi uchun
        ],
      ),
    );
  }
}
