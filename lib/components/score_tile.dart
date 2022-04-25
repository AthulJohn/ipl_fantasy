import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ipl_fantasy/models/batter_score.dart';

class ScoreTile extends StatelessWidget {
  final String score, overs, extras, rate;
  const ScoreTile(
      {required this.score,
      required this.overs,
      required this.extras,
      required this.rate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "Extras: $extras",
              style: const TextStyle(color: Colors.white),
            )),
            // Expanded(
            //   flex: 3,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //     child: Text(
            //       "Overs: $overs",
            //       style: const TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Run Rate: $rate",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      score + ' ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                    Text(
                      "($overs)",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
