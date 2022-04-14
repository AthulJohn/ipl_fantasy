class TableTeam {
  late String pos;
  late String team, won, lost, tie, points, nrr, matches;
  TableTeam(
      {required this.pos,
      required this.team,
      required this.won,
      required this.lost,
      required this.tie,
      required this.points,
      required this.nrr});

  TableTeam.fromJson(dynamic rank, dynamic l) {
    pos = rank;
    team = l['Team'];
    won = l['Won'];
    lost = l['Lost'];
    tie = l['Tied'];
    points = l['Points'];
    nrr = l['Net Run Rate'];
    matches = l['Matches'];
  }

  TableTeam.none() {
    team = '';
    won = '';
    lost = '';
    tie = '';
    points = '';
    nrr = '';
    matches = '';
  }
}
