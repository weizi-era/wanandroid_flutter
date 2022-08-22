import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/article_detail.dart';
import 'package:wanandroid_flutter/utils/navigator_util.dart';
import 'package:wanandroid_flutter/utils/util.dart';

class PublicItem extends StatefulWidget {
  final itemData;
  const PublicItem({Key? key, required this.itemData}) : super(key: key);

  @override
  State<PublicItem> createState() => _PublicItemState();
}

class _PublicItemState extends State<PublicItem> {

  bool isCollect = false;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: InkWell(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 5), child: top(),),
            Padding(padding: EdgeInsets.fromLTRB(10, 5, 10, 5), child: middle(),),
            Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 5), child: bottom(),),
          ],
        ), onTap: () {
          NavigatorUtils.navigate(context, ArticleDetail(title: widget.itemData["title"], link: widget.itemData["link"],));
        },)
      );
  }

  Widget top() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(
          widget.itemData["author"],
          style: TextStyle(color: Colors.grey[600]),
        )),
        Text(
          widget.itemData["niceDate"],
          style: TextStyle(color: Colors.grey[600]),
        )
      ],
    );
  }

  Widget middle() {
    return Text(
      Util.parseHtmlString(widget.itemData["title"]),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),
    );
  }

  Widget bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Text.rich(
          TextSpan(children: [
            TextSpan(text: "公众号·", style: TextStyle(color: Colors.grey[600])),
            TextSpan(text: widget.itemData["author"], style: TextStyle(color: Colors.grey[600])),
          ]),
        )),
        IconButton(onPressed: () {
          setState(() {
            isCollect = !isCollect;
          });
        }, icon: Icon(isCollect? Icons.star : Icons.star_border, color: Colors.red,)),
      ],
    );
  }

}
