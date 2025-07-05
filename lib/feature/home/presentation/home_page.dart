import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/constants/app_colors.dart';
import 'package:todo/feature/OCR/presentation/pages/image_to_text.dart';
import 'package:todo/feature/help/presentation/pages/help_page.dart';
import 'package:todo/feature/notes/presentation/pages/notes_page.dart';
import 'package:todo/feature/profile/presentation/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    NotesPage(),
    ImageToTextPage(),
    HelpPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(24.r),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.background,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.text,
          unselectedItemColor: AppColors.grey,
          selectedLabelStyle: TextStyle(fontSize: 18.sp),
          unselectedLabelStyle: TextStyle(fontSize: 18.sp),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_outlined, size: 36.sp),
              label: 'Notes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.image_search, size: 36.sp),
              label: 'OCR',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline_sharp, size: 36.sp),
              label: 'Help',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 36.sp),
              label: 'Me',
            ),
          ],
        ),
      ),
    );
  }
}
