
import 'package:flutter/material.dart';

class ProjectItem extends StatefulWidget {
  final itemData;

  ProjectItem({Key? key, this.itemData,}) : super(key: key);

  @override
  State<ProjectItem> createState() => _ProjectItemState(itemData);
}

class _ProjectItemState extends State<ProjectItem> {

  var itemData;

  _ProjectItemState(this.itemData);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 4.0,
        child: itemView(),
      ),
      onTap: () {

      },
    );
  }

  Widget itemView() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(8.0), child: top(),),
        Padding(padding: EdgeInsets.all(8.0), child: middle(),),
        Padding(padding: EdgeInsets.all(8.0), child: bottom(),),
      ],
    );
  }

  Widget top() {
    return Row(
      children: [
        Expanded(child: Text((itemData["author"] as String).isEmpty ? itemData["shareUser"] : itemData["author"],)),
        Expanded(child: Text(itemData["niceDate"])),
      ],
    );
  }

  Widget middle() {
    return Row(
      children: [
        Expanded(child: Column(
          children: [
            Text(itemData["title"]),
            Text(itemData["desc"]),
          ],
        ),),
        Expanded(child: Image.network(itemData["envelopePic"], )),
      ],
    );
  }

  Widget bottom() {
    return Row(
      children: [
        Expanded(child: Text(itemData["chapterName"])),
        //Expanded(child: Image.asset("name")),
      ],
    );
  }

}
