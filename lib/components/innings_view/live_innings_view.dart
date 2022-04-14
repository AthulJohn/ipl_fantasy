import 'package:flutter/material.dart';
import 'package:ipl_fantasy/services/ipl_api.dart';
import 'package:ipl_fantasy/views/loading.dart';

import '../../models/innings_score.dart';
import 'innings_view.dart';

class LiveInningsView extends StatelessWidget {
  final String link;
  const LiveInningsView({required this.link, Key? key}) : super(key: key);

  Stream<InningsScore> getInnings(innlink) async* {
    String over = '';
    while (true) {
      Map<String, dynamic> mp = await getLiveInningsScore(innlink, over);
      InningsScore inn = mp['innings'];
      over = inn.overs;
      yield inn;

      await Future.delayed(const Duration(seconds: 15));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<InningsScore>(
      builder: ((context, snapshot) => snapshot.hasData
          ? InningsView(snapshot.data ?? InningsScore())
          : const Loading()),
      stream: getInnings(link),
    );
  }
}
