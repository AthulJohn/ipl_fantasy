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
  bool live = false;
  InningsScore();
  InningsScore.fromJson(Map l, String over) {
    if (over.compareTo((l['Overs'] ?? '')) < 0 ||
        over.startsWith('1') && (l['Overs'] ?? '').startsWith('1')) {
      updated = true;
      target = 0;
      score = (l['Score'] ?? '');
      extras = l['Extras'] ?? '';
      overs = (l['Overs'] ?? '');
      runRate = l['Runrate'] ?? '';
      team = l['Team'] ?? '';
      if (!score.contains('/10') && overs != '20') live = true;
      if (overs == '') return;

      batterscores = [
        for (Map p in l['Batting']) BatterScore.fromJson(p),
      ];
      bowlerscores = [
        for (Map p in l['Bowling']) BowlerScore.fromJson(p),
      ];
      balls = [];
    } else {
      updated = false;
    }
  }

  InningsScore.fromJsonlive(Map l, String over) {
    live = true;
    if (over.compareTo((l['BatScore'] ?? ' (').split(' (')[1].split(')')[0]) <
            0 ||
        over.startsWith('1') &&
            (l['BatScore'] ?? ' (')
                .split(' (')[1]
                .split(')')[0]
                .startsWith('9')) {
      updated = true;
      target = l['BowlScore'] == ''
          ? 0
          : int.tryParse(l['BowlScore'].split(' ')[2].split('/')[0]) ?? 0;
      score = l['BatScore'].split(' ')[2];
      extras = '';
      if ((l['BatScore']).contains(' (')) {
        overs = (l['BatScore']).split(' (')[1].split(')')[0];
      }
      runRate = l['CRR'] ?? '';
      team = l['BatScore'].split(' ')[0] ?? '';
      if (overs == '') return;
      for (Map bat in l['Batting']) {
        bat['Current Batter'] = true;
      }
      batterscores = [
        for (Map p in l['Batting']) BatterScore.fromJson(p),
      ];
      bowlerscores = [
        for (Map p in l['Bowling']) BowlerScore.fromJson(p),
      ];
      balls = [];
      for (String s in l['Commentry']) {
        if (s.split(' ')[0].contains(':')) l['Commentry'].remove(s);
      }
      for (int i = 0; i < l['Balls'].length; i++) {
        if (i < l['Commentry'].length) {
          String basc = l['Commentry'][i].split(',')[0];
          balls.add(Bowl(
              over: basc.split(' ')[0],
              ball: l['Balls'][i].toString(),
              basic: basc,
              commentary: (l['Commentry'][i])
                  .toString()
                  .replaceFirst(basc + ', ', '')));
        } else {
          balls.add(Bowl(
              over: '',
              ball: l['Balls'][i].toString(),
              basic: '',
              commentary: ''));
        }
      }
    } else {
      updated = false;
    }
  }
  // Queue<
}
