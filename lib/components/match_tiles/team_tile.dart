import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';

import '../../models/fixture.dart';
import '../../views/live_score_page.dart';
import '../../views/score_page.dart';

class TeamTile extends StatelessWidget {
  final Fixture fixture;
  final bool shouldPush;

  const TeamTile({Key? key, required this.fixture, this.shouldPush = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: shouldPush
          ? () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                if (fixture.current == 'live') {
                  if (fixture.overa == '20.0 ov' || fixture.overa == '') {
                    return LiveScorePage(fixture, "A");
                  } else {
                    return LiveScorePage(fixture, "H");
                  }
                } else {
                  return ScorePage(fixture);
                }
              }));
            }
          : null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: fixture.current == 'live'
                  ? [
                      Color(0xff09B27C),
                      Color(0xff278AB0),
                      // fixture.winner.color,
                      // fixture.winner.color,
                      // Colors.black54,
                      // fixture.winner.color,
                    ]
                  : fixture.current == 'match-ended'
                      ? [
                          Color(0xFF1C4670),
                          Color(0xFF278AB0),
                        ]
                      : [
                          // fixture.home.color,
                          // fixture.away.color,
                          Colors.blueGrey,
                          Color(0xFF278AB0),
                        ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 170,
          // decoration: BoxDecoration(
          // gradient: LinearGradient(colors: [
          //   fixture.home.color,
          //   Colors.black,
          //   fixture.away.color,
          // ]),
          // ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'images/dotpattern.png',
                  fit: BoxFit.fitHeight,
                  colorBlendMode: BlendMode.srcATop,
                  color: fixture.home.color.withOpacity(0.8),
                  alignment: Alignment.topLeft,
                ),
              ),
              // const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Transform.rotate(
                  angle: pi,
                  child: Image.asset(
                    'images/dotpattern.png',
                    fit: BoxFit.fitHeight,
                    colorBlendMode: BlendMode.srcATop,
                    color: fixture.away.color.withOpacity(0.8),
                    alignment: Alignment.topLeft,
                  ),
                ),
              ),
              //   ],
              // ),
              // Opacity(
              //   opacity: 1,
              //   child: Row(
              //     children: [
              //       const Spacer(),
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(fixture.description,
                        textAlign: TextAlign.center,
                        style: AppConstants.textStyles['body']),
                    Text(
                        "on   ${fixture.date.day} - ${fixture.date.month} - ${fixture.date.year}",
                        textAlign: TextAlign.center,
                        style: AppConstants.textStyles['body']),
                    Expanded(
                      child: Row(
                        children: [
                          Image.network(
                            fixture.home.logo,
                            height: fixture.current == "match-ended" &&
                                    fixture.winner.code == fixture.home.code
                                ? 60
                                : 50,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: fixture.current == "match-ended" &&
                                      fixture.winner.code == fixture.away.code
                                  ? 0.5
                                  : 1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(fixture.home.name,
                                      style: AppConstants.textStyles['bold']),
                                  if (fixture.current == "live" ||
                                      fixture.current == "match-ended")
                                    Text(fixture.scoreh,
                                        style:
                                            AppConstants.textStyles['focus']),
                                  if (fixture.current == "live" ||
                                      fixture.current == "match-ended")
                                    Text(fixture.overh,
                                        style: AppConstants.textStyles['body']),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: fixture.current == "match-ended" &&
                                      fixture.winner.code == fixture.home.code
                                  ? 0.5
                                  : 1,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(fixture.away.name,
                                      textAlign: TextAlign.right,
                                      style: AppConstants.textStyles['bold']),
                                  if (fixture.current == "live" ||
                                      fixture.current == "match-ended")
                                    Text(fixture.scorea,
                                        style:
                                            AppConstants.textStyles['focus']),
                                  if (fixture.current == "live" ||
                                      fixture.current == "match-ended")
                                    Text(fixture.overa,
                                        textAlign: TextAlign.right,
                                        style: AppConstants.textStyles['body']),
                                ],
                              ),
                            ),
                          ),
                          Image.network(
                            fixture.away.logo,
                            height: fixture.current == "match-ended" &&
                                    fixture.winner.code == fixture.away.code
                                ? 60
                                : 50,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Text(fixture.status,
                        textAlign: TextAlign.center,
                        style: AppConstants.textStyles['body']),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //       "${fixture.home.name} vs ${fixture.away.name}",
                    //       style: AppConstants.textStyles['body']),
                    // ),
                    // if (fixture.current == "Completed" ||
                    //     fixture.current == "Live")
                    //   Text("${fixture.scoreh}   -   ${fixture.scorea}",
                    //       style: AppConstants.textStyles['body']),
                    // if (fixture.current == "Live" ||
                    //     fixture.current == "Completed")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
