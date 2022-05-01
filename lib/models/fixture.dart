import 'package:ipl_fantasy/models/team.dart';

import 'constants.dart';

class Fixture {
  late String description;
  late Team home;
  late Team away, winner = Team.none();
  late DateTime date;
  late String venue;
  late String status;
  late String scorea = '', scoreh = '', overa = '(20/20)', overh = '(20/20)';

  late String link = '';
  late String current;

  Fixture({
    required this.status,
    required this.scorea,
    required this.scoreh,
    required this.current,
    required this.description,
    required this.home,
    required this.away,
    required this.date,
    required this.venue,
    required this.link,
  });
  Fixture.none()
      : description = '',
        home = Team.none(),
        away = Team.none(),
        date = DateTime.now(),
        status = '',
        scorea = '',
        scoreh = '',
        current = '',
        link = '',
        venue = '';
  Fixture withNewScore(dynamic m) {
    if (home.code == m['Team H'].toString()) {
      scorea = m['Score Team A'] ?? '';
      scoreh = m['Score Team H'] ?? '';
      overa = m['Overs Team A'] ?? '';
      overh = m['Overs Team H'] ?? '';
      if (m['Status'] != '') {
        status = m['Status'];
      }
    } else {
      scorea = m['Score Team H'] ?? '';
      scoreh = m['Score Team A'] ?? '';
      overa = m['Overs Team H'] ?? '';
      overh = m['Overs Team A'] ?? '';
      if (m['Status'] != '') status = m['Status'];
    }
    return this;
  }

  Fixture.fromJson(Map f) {
    description = f['Description'].toString(); //
    venue = f['Venue'].toString();
    link = f['Full Scoreboard'].toString(); //
    date = DateTime.tryParse(f['Date']) ?? DateTime(2022, 3, 26); //
    home = AppConstants.byName(f['Team H'].toString()); //
    away = AppConstants.byName(f['Team A'].toString()); //
    current = f['Current'].toString(); //
    status = f['Score']['Status']; //
    if (current != 'upcoming') {
      scorea = f['Score']['Score Team A'];
      scoreh = f['Score']['Score Team H'];
      overa = f['Score']['Overs Team A'];
      overh = f['Score']['Overs Team H'];
    }
    for (Team t in AppConstants.teams) {
      if (status.startsWith(t.name)) {
        winner = t;
      }
    }
  }
}
