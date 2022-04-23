import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';
import 'package:ipl_fantasy/services/ipl_api.dart';
import 'package:ipl_fantasy/views/info.dart';
import 'package:ipl_fantasy/views/loading.dart';
import 'package:ipl_fantasy/views/table.dart';

import '../components/match_tiles/team_tile.dart';
import '../components/match_tiles/live_match_tile.dart';
import '../models/fixture.dart';
import 'score_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getFixtures() async {
    Map<String, dynamic> fixtures = await getFixtures();

    return fixtures;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _getFixtures(),
        builder: (context, snapshot) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'Cricbie',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                backgroundColor: Color(0xff1C4670),
                actions: [
                  // TextButton(
                  //   onPressed: () {
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => InfoPage(),
                  //     //   ),
                  //     // );
                  //   },
                  //   child: const Text('Fantasy'),
                  //   style: ButtonStyle(
                  //       backgroundColor:
                  //           MaterialStateProperty.all(Colors.green)),
                  // ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Info()));
                    },
                  ),
                ],
              ),
              body: snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? snapshot.data!['fixtures'].isEmpty
                          ? const Loading(
                              text:
                                  "Looks like your internet connection is not stable!")
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Color(0xff1C4670),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(20))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          snapshot
                                                      .data!['fixtures'][
                                                          snapshot.data![
                                                              'MatchNumber']]
                                                      .current ==
                                                  'live'
                                              ? "Current Match"
                                              : snapshot
                                                          .data!['fixtures'][
                                                              snapshot.data![
                                                                  'MatchNumber']]
                                                          .current ==
                                                      'match-ended'
                                                  ? "Recent Match"
                                                  : "Upcoming Match",
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      LiveMatchTile(
                                        fixture: snapshot.data!['fixtures']
                                            [snapshot.data!['MatchNumber']],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: DefaultTabController(
                                    length: 3,
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TabBar(tabs: [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Results',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Fixture',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Table',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            )
                                          ]),
                                        ),
                                        Expanded(
                                            child: TabBarView(children: [
                                          ListView.builder(
                                            itemBuilder: (context, ind) {
                                              return TeamTile(
                                                fixture: snapshot
                                                    .data!['fixtures']![snapshot
                                                        .data!['MatchNumber'] -
                                                    1 -
                                                    ind],
                                              );
                                            },
                                            itemCount:
                                                snapshot.data!['MatchNumber'],
                                          ),
                                          ListView.builder(
                                            itemBuilder: (context, ind) {
                                              return TeamTile(
                                                fixture: snapshot
                                                    .data!['fixtures']![snapshot
                                                        .data!['MatchNumber'] +
                                                    ind],
                                              );
                                            },
                                            itemCount: snapshot
                                                    .data!['fixtures']!.length -
                                                snapshot.data!['MatchNumber'],
                                          ),
                                          const PointsTable()
                                        ])),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                      : const Loading(text: 'Some Final Touches...')
                  : const Loading(
                      text: 'Fetching Data',
                    ));
        });
  }
}
