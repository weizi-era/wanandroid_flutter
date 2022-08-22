import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/article_detail.dart';
import 'package:wanandroid_flutter/utils/navigator_util.dart';

class SharedItem extends StatefulWidget {
  const SharedItem({Key? key, this.itemData}) : super(key: key);

  final itemData;

  @override
  State<SharedItem> createState() => _SharedItemState();
}

class _SharedItemState extends State<SharedItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        child: itemView(),
        onTap: () {
          NavigatorUtils.navigate(
              context, ArticleDetail(title: widget.itemData["title"], link: widget.itemData["link"],));
        },
      ),
    );
  }

  Widget itemView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(10.0), child: Text(widget.itemData["title"], style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),),
        
        Padding(padding:  EdgeInsets.all(10.0), child: Text(widget.itemData["niceShareDate"], style: TextStyle(color: Colors.grey[600]),),),
      ],
    );
  }
}
