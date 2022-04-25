import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/batter_score.dart';
import 'package:ipl_fantasy/models/innings_score.dart';

import '../../models/bowler_score.dart';
import '../player_tile.dart';
import '../score_tile.dart';

class InningsView extends StatelessWidget {
  final InningsScore inn;
  const InningsView(this.inn, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text('  Batsmen',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
      for (BatterScore batter in inn.batterscores)
        BatterTile(
          batter,
        ),
      ScoreTile(
        score: inn.score,
        overs: inn.overs,
        extras: inn.extras,
        rate: inn.runRate,
      ),
      Text('  Bowlers',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
      BowlerTile(BowlerScore('')),
      for (BowlerScore bowler in inn.bowlerscores)
        BowlerTile(
          bowler,
        ),
    ]);
  }
}
