import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/feature/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {

        return MaterialApp.router(
          title: 'HaBIT Note',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.orange,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Roboto"
          ),
          routerConfig: router,
        );
      },
    );
  }
}
