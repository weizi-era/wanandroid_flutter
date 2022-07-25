
import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/article_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {

  /// 滑动控制器
  ScrollController _controller = ScrollController();

  /// 控制正在加载的显示
  bool _isHidden = true;

  List articles = [];

  List banners = [];

  /// 总页数
  var totalPages = 0;
  /// 当前页数
  var curPage = 0;

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
        _getArticleList();
      }
    });

    /// 因为这一个方法就是去请求文章列表与banner图，下拉刷新需要重新请求
    /// 然而初始化数据也是请求相同的数据，所以在initState初始化数据的时候手动请求一次！
    _pullToRefresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  _getArticleList([bool update = true]) async {

    var data = await Api.getArticleList(curPage);

    if (data != null) {
      var map = data["data"];
      var datas = map["datas"];

      totalPages = map["pageCount"];

      if(curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);

      /// 更新 UI
      if(update) {
        setState(() {});
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      banners.clear();
      banners.addAll(data['data']);
      if (update) {
        setState(() {});
      }
    }
  }

  /// 下拉刷新
  Future<void> _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getArticleList(), _getBanner()];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }

  Widget _itemBuilder(int i) {
    if (i == 0) {
      return GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: _bannerView(),
        ),
      );
    }
    var itemData = articles[i - 1];
    return ArticleItem(itemData: itemData,);
  }

  Widget? _bannerView() {

    List<Widget> list = banners.map((item) {
      return Image.network(item["imagePath"], fit: BoxFit.cover,);
    }).toList();

    if (list.isNotEmpty) {
      return BannerView(
        list,
        intervalDuration: Duration(seconds: 3),
      );
    } else {
      return null;
    }
  }

}
