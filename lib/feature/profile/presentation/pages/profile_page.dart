import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/core/constants/app_images.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/feature/profile/presentation/widgets/confirm_logout_modal.dart';
import 'package:todo/feature/profile/presentation/widgets/profile_menu_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDarkMode = true;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? 'User';
      userEmail = prefs.getString('email') ?? 'example@email.com';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Me",
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  32.verticalSpace,
                  Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(AppImages.profile),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 18.sp,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            userEmail ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            48.verticalSpace,
            Divider(height: 1.h, color: AppColors.text),
            24.verticalSpace,

            Center(
              child: Container(
                width: context.screenWidth * 0.75,
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          size: 24.sp,
                          color: Colors.black,
                        ),
                        24.horizontalSpace,
                        Text(
                          isDarkMode ? "Dark Mode" : "Light Mode",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            isDarkMode = value;
                          });
                        },
                        activeColor: AppColors.primary,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ProfileMenuItem(
              icon: Icons.archive,
              label: "Archive notes",
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.settings,
              label: "Settings",
              onTap: () => context.push('/settings'),
            ),
            ProfileMenuItem(
              icon: Icons.info,
              label: "About",
              onTap: () => context.push('/about'),
            ),
            ProfileMenuItem(
              icon: Icons.lock,
              label: "Reset Password",
              onTap: () => context.push('/forgot'),
            ),
            32.verticalSpace,

            // Logout Button
            Center(
              child: SizedBox(
                width: context.screenWidth * 0.85,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const ConfirmLogoutModal(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.logout, size: 36.sp),
                      12.horizontalSpace,
                      Text(
                        "LOG OUT",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
