import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ipl_fantasy/models/table_team.dart';

import '../models/fixture.dart';
import '../models/innings_score.dart';
import '../models/score_board.dart';

Future<Map<String, dynamic>> getFixtures() async {
  Uri? uri = Uri.tryParse('https://ipl-fantasy-api.herokuapp.com/');
  if (uri != null) {
    http.Response response;
    try {
      response = await http.get(uri, headers: {
        "Accept": "application/json",
      });
    } catch (e) {
      return {'fixtures': [], 'MatchNumber': 0};
    }
    if (response.statusCode == 200) {
      //print(response.body);
      Map m = jsonDecode(response.body);
      List<Fixture> fixtures = [];
      for (Map f in m['fixture']) {
        fixtures.add(Fixture.fromJson(f));
      }
      return {'fixtures': fixtures, 'MatchNumber': m['Live Match Number']};
    } else {
      return {'fixtures': [], 'MatchNumber': 0};
    }
  }
  return {'fixtures': [], 'MatchNumber': 0};
}

Future<ScoreBoard> getMatchScore(String link) async {
  Uri? uri =
      Uri.tryParse('https://ipl-fantasy-api.herokuapp.com/scoreboard/' + link);
  if (uri != null) {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map l = jsonDecode(response.body);
      return ScoreBoard.fromJson(l);
    }
  }
  return ScoreBoard.none();
}

Future<dynamic> getShortScore(String link) async {
  Uri? uri =
      Uri.tryParse('https://ipl-fantasy-api.herokuapp.com/short/' + link);
  if (uri != null) {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic l = jsonDecode(response.body);
      return l;
    }
  }
  return {
    "Overs Team A": "",
    "Overs Team H": "",
    "Score Team A": "",
    "Score Team H": "",
    "Status": "",
    "Team A": "",
    "Team H": ""
  };
}

Future<Map<String, dynamic>> getLiveInningsScore(link, String over) async {
  Uri? uri =
      Uri.tryParse('https://ipl-fantasy-api.herokuapp.com/livescore/' + link);
  if (uri != null) {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic l = jsonDecode(response.body);
      return {
        'Status': l['Status'],
        'innings': InningsScore.fromJson(l['innings'], over)
      };
    }
  }
  return {'Status': ' ', 'innings': InningsScore()};
}

Future<List<TableTeam>> getPointsTable() async {
  Uri? uri = Uri.tryParse('https://ipl-fantasy-api.herokuapp.com/table');
  if (uri != null) {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      dynamic l = jsonDecode(response.body);
      List<TableTeam> teams = [];
      for (dynamic k in l.keys.toList()) {
        teams.add(TableTeam.fromJson(k, l[k]));
      }
      return teams;
    }
  }
  return [];
}
