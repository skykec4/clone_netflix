import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:netflix_clone/splash/splash.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'util/constant.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) => ResponsiveWrapper.builder(widget,
                  maxWidth: 1200,
                  minWidth: 360,
                  defaultScale: true,
                  breakpoints: [
                    const ResponsiveBreakpoint.resize(480, name: MOBILE),
                    const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                    const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                  ],
                  background: Container(color: const Color(0xFFF5F5F5))),
              title: 'netflix clone',
              theme: ThemeData(
                primarySwatch: Constant.colorMainMaterialColor,
              ),
              home: const Splash(),
              // home: const HomePage(title: 'FlutterScreenUtil Demo'),
            ));
  }
}
