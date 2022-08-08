import 'package:flutter/material.dart';

class RankItem extends StatelessWidget {
  const RankItem({Key? key, required this.rankItem}) : super(key: key);

  final rankItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding: EdgeInsets.all(15.0), child: Text(rankItem["rank"]),),
            Padding(padding: EdgeInsets.all(15.0), child: Text(rankItem["username"]),),
            Padding(padding: EdgeInsets.all(15.0), child: Text(rankItem["coinCount"].toString()),),
          ],
        ),
        Divider(height: 1.0,indent: 15.0, endIndent: 15.0, color: Colors.green,),
      ],
    );
  }
}
