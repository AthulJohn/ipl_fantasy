class BatterScore {
  late String name;
  String runs = '',
      balls = '',
      strikeRate = '',
      fours = '',
      sixes = '',
      status = '';
  bool stricker = false, batting = false;

  BatterScore(this.name,
      {this.runs = '',
      this.balls = '',
      this.strikeRate = '',
      this.fours = '',
      this.sixes = ''});

  BatterScore.fromJson(Map l) {
    name = l['Name'];

    // if (l['Score'] != '') {
    runs = l['Runs'] ?? '';
    balls = l['Balls'] ?? '';
    // }
    strikeRate = l['SR'];
    fours = l['Fours'];
    sixes = l['Sixes'];
    status = l['Status'] ?? '';
    stricker = l['Stricker'] ?? false;
    batting = l['Current Batter'] ?? false;
  }

  void updateScore(String runs, String balls, String strikeRate, String fours,
      String sixes) {
    this.runs = runs;
    this.balls = balls;
    this.strikeRate = strikeRate;
    this.fours = fours;
    this.sixes = sixes;
  }
}
