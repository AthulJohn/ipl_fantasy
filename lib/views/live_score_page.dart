import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/fixture.dart';
import 'package:ipl_fantasy/models/innings_score.dart';
import 'package:ipl_fantasy/models/score_board.dart';
import 'package:ipl_fantasy/views/scoreboard_view.dart';

import 'ball_by_ball.dart';

class LiveScorePage extends StatefulWidget {
  final Fixture fixture;
  final String teamAorB;
  const LiveScorePage(this.fixture, this.teamAorB, {Key? key})
      : super(key: key);

  @override
  State<LiveScorePage> createState() => _LiveScorePageState();
}

class _LiveScorePageState extends State<LiveScorePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Cricbie',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp),
          ),
          backgroundColor: Color(0xff1C4670),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff1C4670),
          currentIndex: index,
          onTap: (ind) {
            setState(() {
              index = ind;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: 'Scoreboard',
            ),
          ],
          selectedItemColor: Color(0xff1DC690),
          unselectedItemColor: Colors.blueGrey,
        ),
        body: [
          BallbyBallView(widget.fixture),
          ScoreBoardView(widget.fixture),
        ].elementAt(index)
//       StreamBuilder<InningsScore>(builder: (context, snap) {
//         return  DefaultTabController(
//                                 length: 2,
//                                 child: Column(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: TabBar(tabs: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(widget.fixture.home.code,
//                                               style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 20)),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(widget.fixture.away.code,
//                                               style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 20)),
//                                         )
//                                       ]),
//                                     ),
//                                     Expanded(
//                                         child: TabBarView(children: [
//                                       for (int i = 0; i < 2; i++)
//                                         if (snapshot.data!.innings.length <
//                                             i + 1)
//                                           InningsView(InningsScore())
//                                         else if (snapshot
//                                                     .data!.innings[i].overs !=
//                                                 '' &&
//                                             snapshot.data!.innings[i].overs !=
//                                                 '20.0 ov')
//                                           LiveInningsView(
//                                             link: widget.fixture.link,
//                                           )
//                                         else
//                                           InningsView(snapshot.data!.innings[i])
//                                     ])),]),);

//
        );
  }
}
