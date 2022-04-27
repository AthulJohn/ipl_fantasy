import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/fixture.dart';

import '../components/innings_view/innings_view.dart';
import '../components/innings_view/live_innings_view.dart';
import '../models/innings_score.dart';
import '../models/score_board.dart';
import '../services/ipl_api.dart';

class ScoreBoardView extends StatelessWidget {
  final Fixture fixture;
  const ScoreBoardView(this.fixture, {Key? key}) : super(key: key);

  Future<ScoreBoard> _getScoreBoard() async {
    // while (true) {
    //   await Future.delayed(const Duration(seconds: 3));
    ScoreBoard sc = await getMatchScore(fixture.link);
    return sc;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ScoreBoard>(
        initialData: ScoreBoard.none(),
        future: _getScoreBoard(),
        builder: ((context, snapshot) => snapshot.hasData
            ? DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TabBar(tabs: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(fixture.home.code,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(fixture.away.code,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp)),
                        )
                      ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      for (int i = 0; i < 2; i++)
                        if (snapshot.data!.innings.length < i + 1)
                          InningsView(InningsScore())
                        else if (snapshot.data!.innings[i].overs != '' &&
                            snapshot.data!.innings[i].overs != '20')
                          LiveInningsView(
                            link: fixture.link,
                          )
                        else
                          InningsView(snapshot.data!.innings[i])
                    ])),
                  ],
                ),
              )
            : CircularProgressIndicator()));
  }
}
