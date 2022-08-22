import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/mine/shared_item.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);

  @override
  State<SharedPage> createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {

  bool _isHidden = true;


  List articles = [];

  /// 总页数
  var totalPages = 0;
  /// 当前页数
  var curPage = 1;

  /// 滑动控制器
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      /// 获得ScrollController监听控件可以滚动的最大范围
      var maxScroll = _controller.position.maxScrollExtent;

      /// 获得当前位置的像素值
      var pixels = _controller.position.pixels;

      ///当前滑动位置到达底部，同时还有更多数据
      if (maxScroll == pixels && curPage < totalPages) {
        ///加载更多
        _getSharedList();
      }
    });

    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的分享"),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Stack(
        children: <Widget>[
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
      ),
    );
  }

  Future<void> _pullToRefresh() async {
    curPage = 1;
    Iterable<Future> futures = [_getSharedList()];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {});
    return;
  }

  _getSharedList() async {

    var data = await Api.getSharedList(curPage);
    if(data != null) {
      var map = data["data"];
      var datas = map["shareArticles"];
      var itemList = datas["datas"];

      totalPages = datas["pageCount"];

      if(curPage == 1) {
        articles.clear();
      }
      curPage++;
      articles.addAll(itemList);

      setState(() {

      });
    }
  }

  Widget _itemBuilder(int index) {
    if (index == articles.length) {
      if (curPage < totalPages) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: CircularProgressIndicator(strokeWidth: 2.0),
          ),
        );
      } else {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16.0),
          child: Text(
            "没有更多了",
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
    }

    return SharedItem(itemData: articles[index],);
  }

}
