import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/project/project_item.dart';
class ProjectPage extends StatefulWidget {

   const ProjectPage({Key? key, required this.id}) : super(key: key);
   final id;

   @override
   State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin {

  bool _isHidden = true;


  List articles = [];

  /// 总页数
  var totalPages = 0;
  /// 当前页数
  var curPage = 0;

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
        _getProjectList(widget.id);
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
    super.build(context);
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

    return ProjectItem(itemData: articles[index],);
  }

  /// 下拉刷新
  Future<void> _pullToRefresh() async {
    curPage = 1;
    Iterable<Future> futures = [_getProjectList(widget.id)];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {});
    return;
  }

  _getProjectList(int cid) async {

    var data = await Api.getProjectList(curPage, cid);
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

  @override
  bool get wantKeepAlive => true;
}

