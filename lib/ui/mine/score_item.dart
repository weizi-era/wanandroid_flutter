import 'package:flutter/material.dart';

class ScoreItem extends StatelessWidget {
  ScoreItem({Key? key, required this.scoreItem}) : super(key: key);

  final scoreItem;

  @override
  Widget build(BuildContext context) {

    String time = _getTime(scoreItem["date"]);

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: Text(scoreItem["reason"]),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                  child: Text(time.substring(0, time.length - 4)),
                ),
              ],
            ),
            Text(scoreItem["coinCount"] > 0
                ? "+${scoreItem["coinCount"].toString()}"
                : scoreItem["coinCount"].toString(), style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),),
          ],
        ),
      ),
    );
  }


  _getTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp).toString();
  }
}
