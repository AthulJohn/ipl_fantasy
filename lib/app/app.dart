import 'package:flutter/material.dart';

import '../views/home_page.dart';

class IPLFantasy extends StatelessWidget {
  const IPLFantasy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IPL Fantasy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
