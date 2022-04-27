class BowlerScore {
  late String name;
  String runs = '', wickets = '', over = '', maiden = '', economy = '';
  bool bowling = false;

  BowlerScore(this.name,
      {this.runs = '',
      this.economy = '',
      this.wickets = '',
      this.over = '',
      this.maiden = ''});

  BowlerScore.fromJson(Map l) {
    name = l['Name'];
    runs = l['Runs'];
    wickets = l['Wickets'] ?? l['Wicket'];
    over = l['Overs'] ?? l['Over'];
    maiden = l['Maiden'];
    double econ = (double.tryParse(runs) ?? 1) / (num.tryParse(over) ?? 1);
    economy = econ.toStringAsFixed(2);
    bowling = l['Bowler'] ?? false;
  }

  void updateScore(
      String runs, String wickets, String over, String maiden, String economy) {
    this.runs = runs;
    this.wickets = wickets;
    this.over = over;
    this.maiden = maiden;
    this.economy = economy;
  }
}
