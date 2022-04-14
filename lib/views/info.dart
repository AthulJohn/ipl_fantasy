import 'package:flutter/material.dart';
import 'package:ipl_fantasy/models/constants.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Info',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: const Color(0xff1C4670),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cricbie is a cricketing app that provides you with the latest scores from IPL.\n\n',
                style: AppConstants.textStyles['full bold black'],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Version: 1.0.1\n\n'),
                  Text('Developed by: Athul John, Twocent Apps\n\n'),
                  Text('Credits: timesofindia.indiatimes.com, espn.in'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Cricbie Fantasy',
                    style: TextStyle(
                        color: Color(0xff1C4670),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\nA unique non profit fantasy game where you can assemble the best team, and score points. Expecting release soon',
                    style: TextStyle(
                      color: Color(0xff1C4670),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
