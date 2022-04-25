import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../views/home_page.dart';

class IPLFantasy extends StatelessWidget {
  const IPLFantasy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_) {
          return MaterialApp(
            useInheritedMediaQuery: true,
            title: 'IPL Fantasy',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage(),
          );
        });
  }
}
