import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/system/system_item.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({Key? key}) : super(key: key);

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
  List _systemList = [];

  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _getSystemTree();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) => _itemBuilder(i),
      controller: _controller,
      itemCount: _systemList.length + 1,
    );
    return Column(
      children: _systemList.map((item) {
        return SystemItem(
          itemData: item,
        );
      }).toList(),
    );
  }

  Widget _itemBuilder(int i) {
    var itemData = _systemList[i];
    return SystemItem(
      itemData: itemData,
    );
  }

  _getSystemTree() async {
    var data = await Api.getSystemTree();
    if (data != null) {
      _systemList.addAll(data["data"]);
    }

    setState(() {

    });
  }
}
