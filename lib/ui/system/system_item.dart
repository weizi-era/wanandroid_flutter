import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';

class SystemItem extends StatelessWidget {
  SystemItem({Key? key, required this.itemData, required this.flag}) : super(key: key);

  final itemData;

  final int flag;

  List _child = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemData["name"],
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: flow(),
          ),
        ],
      ),
    );
  }

  Widget flow() {
    if (flag == Api.SYSTEM_FLAG) {
      _child = itemData["children"];
    } else {
      _child = itemData["articles"];
    }

    return Wrap(
      spacing: 10.0,
      // runSpacing: 5.0,
      alignment: WrapAlignment.start,
      //delegate: MyFlowDelegate(margin: const EdgeInsets.all(5)),
      children: List.generate(_child.length, (index) {
        return oval(_child[index]);
      }),
    );
  }

  Widget oval(var child) {
    return InkWell(
      onTap: () {
        print(child["name"]);
      },
      child: Chip(
          backgroundColor: Colors.grey[300],
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          // avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text(
            flag == Api.SYSTEM_FLAG ? child["name"] : child["title"],
            style: TextStyle(
              color: Colors.grey[700],
            ),
          ),
        ),
    );
  }
}

class MyFlowDelegate extends FlowDelegate {
  EdgeInsets? margin;
  double width = 0;
  double height = 0;

  MyFlowDelegate({this.margin = EdgeInsets.zero});

  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin!.left;
    var y = margin!.top;

    for (int i = 0; i < context.childCount; i++) {
      var width = context.getChildSize(i)!.width + x + margin!.right;
      if (width < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x = width + margin!.left;
      } else {
        x = margin!.left;
        y += context.getChildSize(i)!.height + margin!.top + margin!.bottom;
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
        x += context.getChildSize(i)!.width + margin!.left + margin!.right;
      }
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return this != oldDelegate;
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return const Size(double.infinity, 200);
  }
}
