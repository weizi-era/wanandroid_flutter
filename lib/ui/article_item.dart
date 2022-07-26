

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/article_detail.dart';

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
      itemData['title'],
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

    return InkWell(  /// 自带水波纹效果
      child: Card(
        elevation: 4.0,
        child: column,
      ),
      onTap: () {
        Navigator.push(context, PageRouteBuilder(pageBuilder:
            (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
          return FadeTransition(  /// 淡入动画
            opacity: animation,
            child: SlideTransition(   /// 平移动画
              position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                  .animate(animation),
              child: ArticleDetail(itemData),
            ),
          );
          // return SlideTransition(  /// 平移动画
          //     position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
          //         .animate(animation),
          // child: ArticleDetail(url: itemData["link"]),);
          //return ArticleDetail(url: itemData["link"]);
        }));
        debugPrint("点击了第${itemData["link"]}得数据");
      },
    );
  }
}
