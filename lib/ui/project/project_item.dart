import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/article_detail.dart';
import 'package:wanandroid_flutter/utils/util.dart';

class ProjectItem extends StatefulWidget {
  final itemData;

  const ProjectItem({
    Key? key,
    required this.itemData,
  }) : super(key: key);

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool isCollect = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 4.0,
        child: itemView(),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ArticleDetail(itemData: widget.itemData);
        }));
      },
    );
  }

  Widget itemView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: top(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: middle(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: bottom(),
        ),
      ],
    );
  }

  Widget top() {
    return Row(
      children: [
        Expanded(
            child: Text(
          (widget.itemData["author"] as String).isEmpty
              ? widget.itemData["shareUser"]
              : widget.itemData["author"],
        )),
        Text(widget.itemData["niceDate"]),
      ],
    );
  }

  Widget middle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  Util.parseHtmlString(widget.itemData["title"]),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  Util.parseHtmlString(widget.itemData["desc"]),
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
            ],
          ),
        ),
        Image.network(
          widget.itemData["envelopePic"],
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget bottom() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(widget.itemData["chapterName"])),
        IconButton(
            onPressed: () {
              setState(() {
                isCollect = !isCollect;
              });
            },
            icon: Icon(isCollect ? Icons.star : Icons.star_border, color: Colors.red,)),
      ],
    );
  }
}
