import 'package:flutter/material.dart';
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
                    for (TableTeam t in snapshot.data!) TableTile(t)
                  ],
                )
              : const Loading(text: "Fetching Current Points Table");
        });
  }
}
