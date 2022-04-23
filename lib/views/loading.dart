import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';

class Loading extends StatelessWidget {
  final String text;
  const Loading({this.text = '', Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'images/loadings/${Random().nextInt(10) + 1}.png'),
                  fit: BoxFit.contain)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(),
                Container(),
                Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: AppConstants.textStyles['bold'],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
