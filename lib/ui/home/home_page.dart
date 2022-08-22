import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/home/article_detail.dart';
import 'package:wanandroid_flutter/ui/home/article_item.dart';
import 'package:wanandroid_flutter/utils/cache_image.dart';
import 'package:wanandroid_flutter/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
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

  var maxScroll;

  var pixels;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      /// 获得ScrollController监听控件可以滚动的最大范围
      maxScroll = _controller.position.maxScrollExtent;

      debugPrint("maxScroll == $maxScroll");

      /// 获得当前位置的像素值
      pixels = _controller.position.pixels;

      debugPrint("pixels == $pixels");

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

      if (curPage == 0) {
        articles.clear();
      }
      curPage++;
      articles.addAll(datas);

      /// 更新 UI
      if (update) {
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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "首页",
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !_isHidden,
            child: Center(
              child: CircularProgressIndicator(),
            ),
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

  Widget _itemBuilder(int index) {
    if (index == 0) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: _bannerView(),
      );
    }

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

    return ArticleItem(
      itemData: articles[index - 1],
    );
  }

  Widget? _bannerView() {
    List<Widget> list = banners.map((item) {
      return InkWell(
        /// 能让我们快速添加各种触摸事件的Widget
        child: CacheImage(
          item["imagePath"],
          clearMemoryCacheWhenDispose: true,
        ),
        onTap: () {
          ///点击事件
          NavigatorUtils.navigate(
              context,
              ArticleDetail(
                title: item["title"],
                link: item["url"],
              ));
        },
      );
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

  @override
  bool get wantKeepAlive => true;
}
