
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/article_detail.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({Key? key, this.itemData,}) : super(key: key);

  final itemData;

  @override
  Widget build(BuildContext context) {

    Row author = Row(
      children: <Widget>[
        Expanded(child: Text.rich(TextSpan(children: [
          TextSpan(text: "作者："),
          TextSpan(text: itemData["author"], style: TextStyle(
            color: Theme.of(context).primaryColor,
          ))
        ]))),
        Text(itemData["niceDate"])
      ],
    );

    ///标题
    Text title = Text(
      itemData['title'],
      style: new TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    ///章节名
    Text chapterName = new Text(itemData['chapterName'],
        style: new TextStyle(color: Theme.of(context).primaryColor));

    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0), child: author,),
        Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0), child: title,),
        Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0), child: chapterName,),
      ],
    );

    return GestureDetector(
      child: Card(
        elevation: 4.0,
        child: column,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ArticleDetail(url: itemData["link"],);
        }));
        debugPrint("点击了第${itemData["link"]}得数据");
      },
    );
  }
}
