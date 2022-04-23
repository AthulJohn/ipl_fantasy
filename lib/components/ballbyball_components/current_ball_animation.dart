import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/bowl_detail.dart';
import 'package:ipl_fantasy/models/constants.dart';

class CurrentBallView extends StatefulWidget {
  final String stricker, bowler;
  final Bowl ball;
  final bool animate;
  const CurrentBallView(this.ball, this.stricker, this.bowler, this.animate,
      {Key? key})
      : super(key: key);

  @override
  State<CurrentBallView> createState() => _CurrentBallViewState();
}

class _CurrentBallViewState extends State<CurrentBallView> {
  @override
  Widget build(BuildContext context) {
    print("fiest here");
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/ground.png'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.srcATop))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Expanded(
            flex: 2,
            child: Center(
              child: AnimatedBall(
                ball: widget.ball,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.ball.over.split(' ')[0],
                    style: AppConstants.textStyles['focus'],
                  ),
                  // Text(
                  //   "${widget.bowler} to ${widget.stricker}",
                  //   style: AppConstants.textStyles['full bold'],
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedBall extends StatefulWidget {
  const AnimatedBall({
    Key? key,
    required this.ball,
  }) : super(key: key);

  final Bowl ball;

  @override
  State<AnimatedBall> createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  bool runinnext = false;
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
        scale: animation.value, child: CurrentBall(widget.ball.ball, ''));
  }
}

class CurrentBall extends StatelessWidget {
  final String ball, stricker;
  const CurrentBall(this.ball, this.stricker, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (ball) {
      case 'W':
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withOpacity(0.8),
                ),
                child: const Text('WICKET ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))),
            Text(
              '\nAnd the batsman has to depart!',
              style: AppConstants.textStyles['full bold']!
                  .copyWith(color: Colors.red),
            )
          ],
        );
      case '4':
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.withOpacity(0.8),
                ),
                child: const Text('FOUR! ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))),
            Text(
              '\nWhat a lovely shot!',
              style: AppConstants.textStyles['full bold']!
                  .copyWith(color: Colors.blue),
            )
          ],
        );
      case '6':
        return Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green.withOpacity(0.8),
                ),
                child: const Text('SIX! ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))),
            Text(
              '\nBOOM! BANG! SIX!',
              style: AppConstants.textStyles['full bold']!
                  .copyWith(color: Colors.green),
            )
          ],
        );
      default:
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withOpacity(0.8),
            ),
            child: Text(' $ball ',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic)));
    }
  }
}
