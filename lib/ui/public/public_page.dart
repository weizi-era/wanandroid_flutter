import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/public/public_item.dart';

class PublicPage extends StatefulWidget {
  const PublicPage({Key? key, required this.id}) : super(key: key);

  final id;

  @override
  State<PublicPage> createState() => _PublicPageState(id);
}

class _PublicPageState extends State<PublicPage> {

  var id;

  _PublicPageState(this.id);

  bool _isHidden = true;


  List articles = [];

  /// 总页数
  var totalPages = 0;
  /// 当前页数
  var curPage = 0;

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      /// 获得ScrollController监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      /// 获得当前位置的像素值
      var pixels = _controller.position.pixels;

      ///当前滑动位置到达底部，同时还有更多数据
      if (maxScroll == pixels && curPage < totalPages) {
        ///加载更多
        _getPublicList(id);
      }
    });

    _pullToRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          offstage: !_isHidden,
          child: Center(child: CircularProgressIndicator(),),
        ),
        Offstage(
          offstage: _isHidden,
          child: RefreshIndicator(
            onRefresh: _pullToRefresh,
            child: ListView.builder(
              itemCount: articles.length + 1,
              itemBuilder: (context, i) => _itemBuilder(i),
              controller: _controller,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _pullToRefresh() async {

    curPage = 1;

    Iterable<Future> futures = [_getPublicList(id)];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {

    });

    return;

  }

  _getPublicList(int id) async {

    var data = await Api.getPublicList(curPage, id);
    if (data != null) {
      var map = data["data"];
      var datas = map["datas"];

      totalPages = map["pageCount"];

      if(curPage == 1) {
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);

      setState(() {

      });
    }
  }

  _itemBuilder(int i) {
    var itemArticle = articles[i];
    return PublicItem(itemData: itemArticle,);
  }
}
