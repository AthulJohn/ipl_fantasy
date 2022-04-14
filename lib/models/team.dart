import 'package:flutter/material.dart';

class Team {
  String name, code, logo;
  Color color;

  Team(
      {required this.name,
      required this.code,
      required this.logo,
      required this.color});

  Team.none()
      : code = 'UNK',
        name = 'Unknown Team',
        logo =
            'http://www.clker.com/cliparts/4/6/e/e/11954452011850317220jean_victor_balin_unknown_blue.svg.med.png',
        color = Colors.black;
}
