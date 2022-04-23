import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/batter_score.dart';
import 'package:ipl_fantasy/models/bowler_score.dart';
import 'package:ipl_fantasy/models/innings_score.dart';

import '../../models/bowl_detail.dart';
import 'current_ball_animation.dart';
import 'ball_info_circle.dart';

class BallsView extends StatelessWidget {
  final InningsScore inningsScore;
  const BallsView(this.inningsScore, {Key? key}) : super(key: key);

  String getStricker() {
    return inningsScore.batterscores
        .firstWhere(
          (element) => element.stricker,
          orElse: () => BatterScore(' '),
        )
        .name;
  }

  String getBowler() {
    return inningsScore.bowlerscores
        .firstWhere((element) => element.bowling,
            orElse: () => BowlerScore(' '))
        .name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: CurrentBallView(
                (inningsScore.balls.length > 1)
                    ? inningsScore.balls[0]
                    : Bowl(ball: '', over: '0.0 1'),
                inningsScore.lastStricker,
                inningsScore.lastBowler,
                // true),
                inningsScore.updated),
            flex: 8),
        Expanded(
          child: Container(
              color: Colors.black,
              child: ListView(
                children: [
                  if (inningsScore.balls.length > 1)
                    RecentBall(inningsScore.balls[0]),
                  for (int i = 1; i < inningsScore.balls.length; i++)
                    BallInfoCircle(inningsScore.balls[i]),
                ],
                scrollDirection: Axis.horizontal,
              )),
        ),
      ],
    );
  }
}

class RecentBall extends StatefulWidget {
  final Bowl ball;
  const RecentBall(this.ball, {Key? key}) : super(key: key);

  @override
  State<RecentBall> createState() => _RecentBallState();
}

class _RecentBallState extends State<RecentBall>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool runinnext = false, selector = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
    runAnimation();
  }

  void initAnimation() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
  }

  void runAnimation() {
    if (!runinnext && controller.isCompleted) {
      runinnext = true;
      return;
    }
    runinnext = false;
    controller.reset();
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.isAnimating) runAnimation();
    return Transform.scale(
      // scale: over ? 1 : 0,
      child: BallInfoCircle(widget.ball),
      // secondChild: BallInfoCircle(widget.ball),
      // crossFadeState:
      //     over ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      scale: animation.value,
    );
  }
}
