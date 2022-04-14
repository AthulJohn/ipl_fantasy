import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/innings_score.dart';
import 'package:ipl_fantasy/models/score_board.dart';
import 'package:ipl_fantasy/services/ipl_api.dart';
import 'package:ipl_fantasy/views/scoreboard_view.dart';

import '../components/match_tiles/live_match_tile.dart';
import '../components/match_tiles/team_tile.dart';
import '../models/fixture.dart';

class ScorePage extends StatelessWidget {
  final Fixture fixture;
  const ScorePage(this.fixture, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Match Scorecard',
          ),
          elevation: 0,
          backgroundColor: Color(0xff1C4670),
          foregroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xff1C4670),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fixture.current == 'live'
                      ? LiveMatchTile(
                          fixture: fixture,
                          shouldPush: false,
                        )
                      : TeamTile(
                          fixture: fixture,
                          shouldPush: false,
                        ),
                ],
              ),
            ),
            Expanded(child: ScoreBoardView(fixture)),
          ],
        ));
    // ? Column(
    //     children: [
    //       Expanded(
    //         child: Container(
    //             decoration: const BoxDecoration(
    //               color: Color(0xff1C4670),
    //               borderRadius: BorderRadius.vertical(
    //                 bottom: Radius.circular(10),
    //               ),
    //             ),
    //             child: Column(
    //               children: [
    //                 Expanded(
    //                   child: Row(
    //                     children: [
    //                       Expanded(
    //                         child: Image.network(
    //                           fixture.home.logo,
    //                           width: 50,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 2,
    //                         child: Column(
    //                           crossAxisAlignment:
    //                               CrossAxisAlignment.start,
    //                           children: [
    //                             Text(fixture.home.name),
    //                             Text(snapshot
    //                                 .data!.innings[0].score),
    //                             Text(snapshot
    //                                 .data!.innings[0].overs),
    //                           ],
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 2,
    //                         child: Column(
    //                           crossAxisAlignment:
    //                               CrossAxisAlignment.end,
    //                           children: [
    //                             Text(fixture.away.name),
    //                             Text(snapshot
    //                                 .data!.innings[1].score),
    //                             Text(snapshot
    //                                 .data!.innings[1].overs),
    //                           ],
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Image.network(
    //                           fixture.away.logo,
    //                           width: 50,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Text(snapshot.data!.status),
    //               ],
    //             )),
    //       ),
    //       Expanded(flex: 3,
    //       child:ListView())
    //     ],
    //   )
  }
}
