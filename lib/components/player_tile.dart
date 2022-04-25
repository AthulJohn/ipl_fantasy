import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/batter_score.dart';

import '../models/bowler_score.dart';

class BatterTile extends StatelessWidget {
  final BatterScore batter;
  const BatterTile(this.batter, {Key? key}) : super(key: key);

  bool isbatting() {
    return (['not out', 'Batting'].contains(batter.status));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isbatting()
                    ? [
                        Color(0xff1DC690),
                        Color(0xff278AB0),
                      ]
                    : batter.status == ''
                        ? [
                            Colors.grey,
                            Colors.blueGrey,
                          ]
                        : [
                            Color(0xFF1C4670),
                            Color(0xFF278AB0),
                          ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          if (batter.stricker)
                            Icon(Icons.play_arrow, color: Colors.white),
                          Expanded(
                            child: Text(
                              batter.name,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        batter.status,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        batter.runs + ' ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                      if (batter.balls != '')
                        Text(
                          "(${batter.balls})",
                          style: const TextStyle(color: Colors.white),
                        ),
                    ],
                  )),
                ],
              ),
              if (batter.status != '')
                const Divider(
                  color: Colors.grey,
                ),
              if (batter.status != '')
                Row(children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "4's : ${batter.fours}    6's : ${batter.sixes}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Text(
                        'SR: ${batter.strikeRate}',
                        style: const TextStyle(color: Colors.white),
                      )),
                ]),
            ],
          ),
        ),
      ),
    );
  }
}

class BowlerTile extends StatelessWidget {
  final BowlerScore bowler;
  const BowlerTile(this.bowler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: bowler.name == ''
                    ? [Colors.black, Colors.black]
                    : const [
                        Color(0xFF1C4670),
                        Color(0xFF278AB0),
                      ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        bowler.name == '' ? "Name" : bowler.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                  // const Spacer(
                  //   flex: 2,
                  // ),
                  Expanded(
                      child: Text(
                    bowler.name == '' ? 'R' : bowler.runs,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Colors.white),
                  )),
                  Expanded(
                    // flex: 2,
                    child: Text(
                      bowler.name == '' ? 'W' : bowler.wickets,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Text(
                      bowler.name == '' ? 'O' : bowler.over,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Text(
                      bowler.name == '' ? 'E' : bowler.economy,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Text(
                      bowler.name == '' ? 'M' : bowler.maiden,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
