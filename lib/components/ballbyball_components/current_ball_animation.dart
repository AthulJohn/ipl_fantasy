import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/bowl_detail.dart';
import 'package:ipl_fantasy/models/constants.dart';

class CurrentBallView extends StatefulWidget {
  final Bowl ball;
  final bool animate;
  const CurrentBallView(this.ball, this.animate, {Key? key}) : super(key: key);

  @override
  State<CurrentBallView> createState() => _CurrentBallViewState();
}

class _CurrentBallViewState extends State<CurrentBallView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('images/ground.png'),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text(
                    widget.ball.basic,
                    textAlign: TextAlign.center,
                    style: AppConstants.textStyles['focus'],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.ball.commentary,
                      style: AppConstants.textStyles['body'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      duration: const Duration(seconds: 1),
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
    if (ball.contains('W') && !ball.contains('d')) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.withOpacity(0.8),
              ),
              child: Text('WICKET ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic))),
          Text(
            '\nAnd the batsman has to depart!',
            style: AppConstants.textStyles['full bold']!
                .copyWith(color: Colors.red),
          )
        ],
      );
    } else if (ball.contains('4')) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.withOpacity(0.8),
              ),
              child: Text('FOUR! ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic))),
          Text(
            '\nWhat a lovely shot!',
            style: AppConstants.textStyles['full bold']!
                .copyWith(color: Colors.blue),
          )
        ],
      );
    } else if (ball.contains('6')) {
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.withOpacity(0.8),
              ),
              child: Text('SIX! ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic))),
          Text(
            '\nBOOM! BANG! SIX!',
            style: AppConstants.textStyles['full bold']!
                .copyWith(color: Colors.green),
          )
        ],
      );
    } else {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Text(' $ball ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 80.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic)));
    }
  }
}


/*
Prepare with python

Make short note: might be 3 4 months gap

Fast negative feedback

Bring Laptop, 
if not available, share
Find another way for exams

Make batchwise whatsapp group
Venues will change, so key on miss table, take it, open class, set projector, make students assemble by 8:45 (before 9)
All things needed by trainer (chalks, waterbottle, pens, etc)
Close door,switch off everything, and give key to miss
attendance mandatory, strict at start

utilise trainer


 */