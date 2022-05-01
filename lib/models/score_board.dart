import 'package:ipl_fantasy/models/innings_score.dart';

class ScoreBoard {
  late String status;
  late List<InningsScore> innings;
  ScoreBoard({
    required this.status,
    required this.innings,
  });
  ScoreBoard.none()
      : status = '',
        innings = [
          InningsScore(),
          InningsScore(),
        ];

  ScoreBoard.fromJson(Map l) {
    status = l['Status'];
    print('onee');
    innings = [
      for (Map m in l['innings']) InningsScore.fromJson(m, ''),
    ];
  }
}
