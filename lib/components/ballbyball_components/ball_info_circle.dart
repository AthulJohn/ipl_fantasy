import 'package:flutter/material.dart';

import '../../models/bowl_detail.dart';

class BallInfoCircle extends StatelessWidget {
  final Bowl bowl;
  const BallInfoCircle(this.bowl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bowl.ball.contains('6')
                  ? Colors.green
                  : bowl.ball.contains('4')
                      ? Colors.indigo
                      : bowl.ball.contains('W')
                          ? Colors.red
                          : Colors.white),
          width: 50,
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: Center(
            child: Text(
              bowl.ball,
              style: TextStyle(
                  color: bowl.ball.contains('6') ||
                          bowl.ball.contains('4') ||
                          bowl.ball.contains('W')
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
        if (bowl.over.contains('.1 1'))
          Center(
            child: Text('Over ' + bowl.over.split('.')[0],
                style: TextStyle(color: Colors.white)),
          ),
        if (bowl.over.contains('.1 1'))
          VerticalDivider(
            color: Colors.white,
          )
      ],
    );
  }
}
