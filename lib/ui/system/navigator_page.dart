import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/system/system_item.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key, required this.flag}) : super(key: key);

  final int flag;

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> with AutomaticKeepAliveClientMixin {
  List _navigatorList = [];

  ScrollController _controller = ScrollController();

  bool _isHidden = true;

  @override
  void initState() {
    super.initState();

    _pullToRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Offstage(
          offstage: !_isHidden,
          child: Center(child: CircularProgressIndicator(),),
        ),
        Offstage(
            offstage: _isHidden,
            child: ListView.builder(
              itemBuilder: (context, i) => _itemBuilder(i),
              controller: _controller,
              itemCount: _navigatorList.length + 1,
            )
        )
      ],
    );
  }

  Widget _itemBuilder(int index) {
    if (index == _navigatorList.length) {
      return Container();
    }

    return SystemItem(
      itemData: _navigatorList[index],
      flag: widget.flag,
    );
  }

  _getNavigatorTree() async {
    var data = await Api.getNavigatorTree();
    if (data != null) {
      _navigatorList.clear();
      _navigatorList.addAll(data["data"]);
    }

    setState(() {

    });
  }

  Future<void> _pullToRefresh() async {
    Iterable<Future> futures = [_getNavigatorTree()];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {

    });

    return;
  }

  @override
  bool get wantKeepAlive => true;
}
