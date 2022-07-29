import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/system/system_item.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({Key? key, required this.flag}) : super(key: key);

  final int flag;

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  List _systemList = [];

  ScrollController _controller = ScrollController();

  bool _isHidden = true;

  @override
  void initState() {
    super.initState();

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
          child: ListView.builder(
            itemBuilder: (context, i) => _itemBuilder(i),
            controller: _controller,
            itemCount: _systemList.length + 1,
          )
        )
      ],
    );
  }

  Widget _itemBuilder(int i) {
    var itemData = _systemList[i];
    print(itemData);
    return SystemItem(
      itemData: itemData,
      flag: widget.flag,
    );
  }

  _getSystemTree() async {
    var data = await Api.getSystemTree();
    if (data != null) {
      _systemList.clear();
      _systemList.addAll(data["data"]);
    }

    setState(() {

    });
  }

  Future<void> _pullToRefresh() async {
    Iterable<Future> futures = [_getSystemTree()];

    await Future.wait(futures);

    _isHidden = false;

    setState(() {

    });

    return;
  }
}
