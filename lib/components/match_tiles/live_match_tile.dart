import 'package:flutter/material.dart';
import 'package:ipl_fantasy/components/match_tiles/team_tile.dart';

import '../../models/fixture.dart';
import '../../services/ipl_api.dart';

class LiveMatchTile extends StatelessWidget {
  final Fixture fixture;
  final bool shouldPush;
  Stream<Fixture> getScore(link) async* {
    while (true) {
      dynamic m = await getShortScore(link);
      Fixture f = fixture.withNewScore(m);
      yield f;

      await Future.delayed(const Duration(seconds: 15));
    }
  }

  const LiveMatchTile({Key? key, required this.fixture, this.shouldPush = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Fixture>(
      stream: getScore(fixture.link),
      builder: (context, snapshot) {
        return TeamTile(
          fixture: snapshot.data ?? fixture,
          shouldPush: shouldPush,
        );
      },
    );
  }
}
