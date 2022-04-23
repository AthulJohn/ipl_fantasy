import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';
import 'package:ipl_fantasy/views/loading.dart';

import '../components/table_team_tile.dart';
import '../models/table_team.dart';
import '../services/ipl_api.dart';

class PointsTable extends StatelessWidget {
  const PointsTable({Key? key}) : super(key: key);

  Future<List<TableTeam>> getTable() async {
    List<TableTeam> table = await getPointsTable();
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TableTeam>>(
        future: getTable(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView(
                  children: [
                    TableTile(TableTeam.none()),
                    for (TableTeam t in snapshot.data!) TableTile(t),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: 'M',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Matches,  ',
                            style: AppConstants.textStyles['body black']),
                        TextSpan(
                            text: 'W',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Wins,  ',
                            style: AppConstants.textStyles['body black']),
                        TextSpan(
                            text: 'L',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Loses,  ',
                            style: AppConstants.textStyles['body black']),
                        TextSpan(
                            text: 'T',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Ties,  ',
                            style: AppConstants.textStyles['body black']),
                        TextSpan(
                            text: 'P',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Points,  ',
                            style: AppConstants.textStyles['body black']),
                        TextSpan(
                            text: 'NRR',
                            style: AppConstants.textStyles['bold black']),
                        TextSpan(
                            text: ': Net Run Rate',
                            style: AppConstants.textStyles['body black']),
                      ])),
                    )
                  ],
                )
              : const Loading(text: "Fetching Current Points Table");
        });
  }
}
