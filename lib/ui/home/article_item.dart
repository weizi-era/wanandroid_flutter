

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/article_detail.dart';
import 'package:wanandroid_flutter/utils/navigator_util.dart';
import 'package:wanandroid_flutter/utils/util.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({
    Key? key,
    this.itemData,
  }) : super(key: key);

  final itemData;

  @override
  Widget build(BuildContext context) {
    Row author = Row(
      children: <Widget>[
        Expanded(
            child: Text.rich(TextSpan(children: [
          TextSpan(text: "作者：", style: TextStyle(color: Colors.grey[600])),
          TextSpan(
              text: (itemData["author"] as String).isEmpty ? itemData["shareUser"] : itemData["author"],
              style: TextStyle(
                color: Colors.grey[600],
              ))
        ]))),
        Text(itemData["niceDate"], style: TextStyle(color: Colors.grey[600]))
      ],
    );

    ///标题
    Text title = Text(
      Util.parseHtmlString(itemData['title']),
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: new TextStyle(fontSize: 15.0, color: Colors.black, fontWeight: FontWeight.bold,),
      textAlign: TextAlign.left,
    );

    ///章节名
    Text chapterName = new Text(itemData['chapterName'],
        style: new TextStyle(color: Colors.grey[600]));

    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: author,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return Card(
        elevation: 4.0,
        child: InkWell(child: column, onTap: () {
          NavigatorUtils.navigate(context, ArticleDetail(itemData: itemData,));
        },),
      );
  }
}
