import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';
import 'package:ipl_fantasy/models/table_team.dart';
import 'package:ipl_fantasy/models/team.dart';

class TableTile extends StatelessWidget {
  final TableTeam team;
  const TableTile(this.team, {Key? key}) : super(key: key);

  Team getTeamDetails() {
    return AppConstants.teams.firstWhere((element) => element.name == team.team,
        orElse: () => Team.none());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: team.team == ''
                    ? [Colors.black, Colors.black]
                    : [
                        getTeamDetails().color,
                        Color(0xFF1C4670),
                      ])),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                // flex: 2,
                child: Text(
                  team.team == '' ? '' : team.pos,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                // flex: 2,
                child: team.team == ''
                    ? Container()
                    : Image.network(
                        getTeamDetails().logo,
                        height: 30,
                      ),
              ),
              Expanded(
                  // flex: 2,
                  child: Text(
                team.team == '' ? '' : getTeamDetails().code,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              )),
              // const Spacer(
              //   flex: 2,
              // ),

              Expanded(
                // flex: 2,
                child: Text(
                  team.team == '' ? 'M' : team.matches,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Text(
                  team.team == '' ? 'W' : team.won,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Text(
                  team.team == '' ? 'L' : team.lost,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Text(
                  team.team == '' ? 'T' : team.tie,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Text(team.team == '' ? 'P' : team.points,
                    textAlign: TextAlign.center,
                    style: AppConstants.textStyles['bold']),
              ),
              Expanded(
                // flex: 2,
                child: Text(team.team == '' ? 'NRR' : team.nrr,
                    textAlign: TextAlign.center,
                    style: AppConstants.textStyles['body']),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
