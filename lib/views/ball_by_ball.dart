import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/batter_score.dart';
import 'package:ipl_fantasy/models/constants.dart';
import 'package:ipl_fantasy/models/innings_score.dart';
import 'package:ipl_fantasy/views/loading.dart';

import '../components/ballbyball_components/balls_view.dart';
import '../models/bowler_score.dart';
import '../models/fixture.dart';
import '../models/team.dart';
import '../services/ipl_api.dart';

class BallbyBallView extends StatelessWidget {
  final Fixture fixture;
  const BallbyBallView(this.fixture, {Key? key}) : super(key: key);

  Stream<Map<String, dynamic>> getLiveScoreStream() async* {
    String over = '';
    while (true) {
      Map<String, dynamic> resp = await getLiveInningsScore(fixture.link, over);
      if (resp['innings'].updated) yield resp;
      over = (resp['innings'] ?? InningsScore()).overs;
      await Future.delayed(const Duration(seconds: 15));
    }
  }

  Team getBat(String team) {
    return fixture.home.name == team ? fixture.home : fixture.away;
  }

  Team getBowl(String team) {
    return fixture.home.name == team ? fixture.away : fixture.home;
  }

  BowlerScore getBowler(List<BowlerScore> bowlers) {
    for (BowlerScore bowler in bowlers) {
      if (bowler.bowling) {
        return bowler;
      }
    }
    if (bowlers.length > 0) {
      return bowlers[0];
    }
    return BowlerScore('');
  }

  List<BatterScore> getBatter(List<BatterScore> batters) {
    List<BatterScore> notouts = [];
    for (BatterScore batter in batters) {
      if (batter.batting) {
        notouts.add(batter);
      }
    }
    if (notouts.length < 2) {
      /// happens immediately after a wicket
      notouts.add(BatterScore(' '));
    }
    if (notouts.length < 2) {
      /// Incase these is no batsman batting, rare case!
      notouts.add(BatterScore(' '));
    }
    return notouts;
  }

  Map<String, String> targetFinder(String stat) {
    List<String> statsplit = stat.split(' ');
    return {
      'R': statsplit[statsplit.length - 8],
      'B': statsplit[statsplit.length - 5]
    };
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
        stream: getLiveScoreStream(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Column(children: [
                  Expanded(
                      flex: 10, child: BallsView(snapshot.data!['innings'])),
                  if (snapshot.data!['Status'].endsWith('rpo'))
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2)),
                            color: getBat(snapshot.data!['innings'].team).color,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                  child: Text(
                                      'Target: ${snapshot.data!['innings'].target}',
                                      style: AppConstants.adaptiveStyle(
                                          getBat(snapshot.data!['innings'].team)
                                              .color,
                                          'body'))),
                              VerticalDivider(
                                  color: AppConstants.adaptiveColor(
                                      getBat(snapshot.data!['innings'].team)
                                          .color)),
                              Center(
                                child: Text(
                                    "${getBat(snapshot.data!['innings'].team).code} needs  ",
                                    style: AppConstants.adaptiveStyle(
                                        getBat(snapshot.data!['innings'].team)
                                            .color,
                                        'body')),
                              ),
                              Container(
                                color: Colors.grey[300],
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "${targetFinder(snapshot.data!['Status'])['R']}",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              Center(
                                  child: Text(" runs in ",
                                      style: AppConstants.adaptiveStyle(
                                          getBat(snapshot.data!['innings'].team)
                                              .color,
                                          'body'))),
                              Container(
                                color: Colors.grey[300],
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  "${targetFinder(snapshot.data!['Status'])['B']}",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                              Center(
                                  child: Text(" balls",
                                      style: AppConstants.adaptiveStyle(
                                          getBat(snapshot.data!['innings'].team)
                                              .color,
                                          'body'))),
                            ],
                          )),
                    ),
                  Expanded(
                    flex: 3,
                    // Lower Score Part
                    child: Column(children: [
                      Expanded(
                        //  Batting Part
                        flex: 2,
                        child: Container(
                          color: getBat(snapshot.data!['innings'].team).color,
                          child: Row(
                            children: [
                              Expanded(
                                // Team Part
                                child: Column(
                                  children: [
                                    Expanded(
                                      // Team Logo and Score
                                      flex: 2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.symmetric(
                                                horizontal:
                                                    BorderSide(width: 2))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: Image.network(getBat(
                                                      snapshot.data!['innings']
                                                          .team)
                                                  .logo),
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.grey[300],
                                                child: Center(
                                                    child: Text(
                                                  snapshot
                                                      .data!['innings'].score,
                                                  style:
                                                      AppConstants.textStyles[
                                                          'focus black'],
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      // Team Name and overs
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: const BoxDecoration(
                                            // border: Border.symmetric(
                                            //     horizontal:
                                            //         BorderSide(width: 2)),
                                            color: Colors.black),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                getBat(snapshot
                                                        .data!['innings'].team)
                                                    .code,
                                                style: AppConstants
                                                    .textStyles['body'],
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data!['innings'].overs,
                                                style: AppConstants
                                                    .textStyles['body'],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  //Batters part
                                  flex: 2,
                                  child: Column(children: [
                                    for (BatterScore bat in getBatter(
                                        snapshot.data!['innings'].batterscores))
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.symmetric(
                                                  vertical:
                                                      BorderSide(width: 4),
                                                  horizontal:
                                                      BorderSide(width: 2))),
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Icon(
                                                  Icons.play_arrow,
                                                  color: bat.stricker
                                                      ? Colors.white70
                                                      : Colors.transparent,
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          bat.name,
                                                          style: AppConstants
                                                              .adaptiveStyle(
                                                                  getBat(snapshot
                                                                          .data![
                                                                              'innings']
                                                                          .team)
                                                                      .color,
                                                                  'full bold'),
                                                        ))),
                                                Expanded(
                                                    child: Container(
                                                  color: Colors.grey[300],
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        bat.runs,
                                                        style: AppConstants
                                                                .textStyles[
                                                            'full bold black'],
                                                      ),
                                                      Text(
                                                        ' (' + bat.balls + ')',
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                              ]),
                                        ),
                                      )
                                  ])),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        // Ballers part
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.symmetric(
                                horizontal: BorderSide(width: 2)),
                            color:
                                getBowl(snapshot.data!['innings'].team).color,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide(width: 4),
                                          horizontal: BorderSide(width: 0))),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            getBowler(snapshot.data!['innings']
                                                    .bowlerscores)
                                                .name,
                                            style: AppConstants.adaptiveStyle(
                                                getBowl(snapshot
                                                        .data!['innings'].team)
                                                    .color,
                                                'full bold'),
                                          ),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                                color: Colors.grey[300],
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    getBowler(snapshot
                                                                .data![
                                                                    'innings']
                                                                .bowlerscores)
                                                            .wickets +
                                                        ' /' +
                                                        getBowler(snapshot
                                                                .data![
                                                                    'innings']
                                                                .bowlerscores)
                                                            .runs,
                                                    style:
                                                        AppConstants.textStyles[
                                                            'full bold black'],
                                                  ),
                                                )),
                                            Center(
                                              child: Text(
                                                '   (' +
                                                    getBowler(snapshot
                                                            .data!['innings']
                                                            .bowlerscores)
                                                        .over +
                                                    ')',
                                                style:
                                                    AppConstants.adaptiveStyle(
                                                        getBowl(snapshot
                                                                .data![
                                                                    'innings']
                                                                .team)
                                                            .color,
                                                        'body'),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]),
                                ),
                              ),

                              // Expanded(
                              //   child: Container(
                              //     color: Colors.grey[300],
                              //     child: Text(snapshot.data!.score),
                              //   ),
                              // ),

                              Expanded(
                                child: Center(
                                  child: Text(
                                    getBowl(snapshot.data!['innings'].team)
                                        .code,
                                    style: AppConstants.adaptiveStyle(
                                        getBowl(snapshot.data!['innings'].team)
                                            .color,
                                        'full bold'),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Image.network(
                                    getBowl(snapshot.data!['innings'].team)
                                        .logo),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                ])
              : const Loading(
                  text: 'Fetching the live scores',
                );
        });
  }
}
