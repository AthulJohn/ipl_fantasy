import 'dart:collection';
import 'dart:developer';

import 'batter_score.dart';
import 'bowl_detail.dart';
import 'bowler_score.dart';

class InningsScore {
  String team = '';
  String score = '';
  String extras = '';
  String overs = '';
  String runRate = '';
  List<BatterScore> batterscores = [];
  List<BowlerScore> bowlerscores = [];
  List<Bowl> balls = [];

  //Only for live data
  int target = 0;
  bool updated = false;
  String lastStricker = '';
  String lastBowler = '';
  InningsScore();
  InningsScore.fromJson(Map l, String over) {
    if (over.compareTo((l['Score'] ?? '').split(' (')[1].split(')')[0]) < 0 ||
        over.startsWith('9')) {
      updated = true;
      target = l['Target'] ?? 0;
      score = (l['Score'] ?? '').split(' ')[0];
      extras = l['Extras'] ?? '';
      if ((l['Score'] ?? '').contains(' ('))
        overs = (l['Score'] ?? '').split(' (')[1].split(')')[0];
      runRate = l['Runrate'] ?? '';
      team = l['Team'] ?? '';

      batterscores = [
        for (Map p in l['Batting']) BatterScore.fromJson(p),
      ];
      bowlerscores = [
        for (Map p in l['Bowling']) BowlerScore.fromJson(p),
      ];
      balls = [];
      for (String p in l['Balls'].keys) {
        int cnt = 1;
        List<Bowl> temp = [];
        for (int i = 1; i <= l['Balls'][p].length; i++) {
          temp.insert(
              0,
              Bowl(
                  over: '${(int.tryParse(p.split(' ')[2]) ?? 1) - 1}.$cnt $i',
                  ball: l['Balls'][p][i - 1].toString()));
          if (l['Balls'][p][i - 1].contains('wd') ||
              l['Balls'][p][i - 1].contains('nb')) {
            continue;
          } else {
            cnt++;
          }
        }

        balls.addAll(temp);
      }
    } else {
      updated = false;
    }
  }
  // Queue<
}
