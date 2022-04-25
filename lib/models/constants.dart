import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/team.dart';

abstract class AppConstants {
  static List<Team> teams = [
    Team(
        code: 'RR',
        name: 'Rajasthan Royals',
        logo: 'https://scores.iplt20.com/ipl/teamlogos/RR.png',
        color: const Color(0xFFE41B84)),
    Team(
        code: 'MI',
        name: 'Mumbai Indians',
        logo: 'https://scores.iplt20.com/ipl/teamlogos/MI.png',
        color: const Color(0xFF006BB5)),
    Team(
        code: 'CSK',
        name: 'Chennai Super Kings',
        logo: 'https://scores.iplt20.com/ipl/teamlogos/CSK.png',
        color: const Color(0xFFFCC807)),
    Team(
        code: 'PBKS',
        name: 'Punjab Kings',
        logo: 'https://scores.iplt20.com/ipl/teamlogos/PBKS.png',
        color: const Color(0xFFD51920)),
    Team(
        code: 'DC',
        name: 'Delhi Capitals',
        logo: 'https://scores.iplt20.com/ipl/teamlogos/DC.png',
        color: const Color(0xFF0177BC)),
    Team(
      code: 'KKR',
      name: 'Kolkata Knight Riders',
      logo: 'https://scores.iplt20.com/ipl/teamlogos/KKR.png',
      color: const Color(0xFF3D2261),
    ),
    Team(
      code: 'SRH',
      name: 'Sunrisers Hyderabad',
      logo: 'https://scores.iplt20.com/ipl/teamlogos/SRH.png',
      color: const Color(0xFFF16422),
    ),
    Team(
      code: 'RCB',
      name: 'Royal Challengers Bangalore',
      logo: 'https://scores.iplt20.com/ipl/teamlogos/RCB.png',
      color: const Color(0xFF696969),
    ),
    Team(
      code: 'GT',
      name: 'Gujarat Titans',
      logo: 'https://scores.iplt20.com/ipl/teamlogos/GT.png',
      color: const Color(0xFF133348),
    ),
    Team(
      code: 'LSG',
      name: 'Lucknow Super Giants',
      logo: 'https://scores.iplt20.com/ipl/teamlogos/LSG.png',
      color: const Color(0xFF9CD3DE),
    )
  ];
  static Team byName(String name) {
    for (Team t in teams) {
      if (t.name == name) {
        return t;
      }
    }
    return Team(
        code: 'UNK',
        name: 'Unknown Team',
        logo:
            'http://www.clker.com/cliparts/4/6/e/e/11954452011850317220jean_victor_balin_unknown_blue.svg.med.png',
        color: Colors.black);
  }

  static Map<String, TextStyle> textStyles = {
    "body": const TextStyle(color: Colors.white),
    "body black": const TextStyle(color: Colors.black),
    "focus": TextStyle(
        color: Colors.white, fontSize: 25.sp, fontWeight: FontWeight.bold),
    "focus black": TextStyle(
        color: Colors.black, fontSize: 25.sp, fontWeight: FontWeight.bold),
    "bold": TextStyle(
        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
    "bold black": TextStyle(
        color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.bold),
    "full bold": TextStyle(
        color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
    "full bold black": TextStyle(
        color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
  };

  static TextStyle adaptiveStyle(Color color, String key) {
    double grayscale =
        (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
    return grayscale > 180
        ? textStyles[key + ' black'] ?? const TextStyle(color: Colors.black)
        : textStyles[key] ?? const TextStyle(color: Colors.white);
  }

  static Color adaptiveColor(Color color) {
    double grayscale =
        (0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue);
    return grayscale > 180 ? Colors.black : Colors.white;
  }
}
