import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  String fName, lName, emaile, id, sourceImageAvatar;
  InfoCard(
      {required this.fName,
      required this.lName,
      required this.emaile,
      required this.id,
      required this.sourceImageAvatar});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(sourceImageAvatar),
                  ),
                  SizedBox(height: 10),
                  Text(fName + " " + lName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text(emaile,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
