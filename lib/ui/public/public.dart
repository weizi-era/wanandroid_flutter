import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/public/public_page.dart';

class Public extends StatefulWidget {
  const Public({Key? key}) : super(key: key);

  @override
  State<Public> createState() => _PublicState();
}

class _PublicState extends State<Public> with TickerProviderStateMixin {

  List _tabs = [];

  List<Tab> _tabsName = [];

  var _currentIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController =  TabController(length: 0, vsync: this);

    _getPublicTab();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TabBar(tabs: _tabsName,
        controller: _tabController,
        isScrollable: true,)
      ),
      body: TabBarView(controller: _tabController,children: _tabs.map((item) {
        return PublicPage(id: item["id"],);
      },).toList(),
      ),
    );
  }

  _getPublicTab() async {

    var data = await Api.getPublicTab();
    if (data != null) {
     _tabs.addAll(data["data"]);
    }

    _tabsName = _tabs.map((item) {
      return Tab(text: item["name"],);
    }).toList();


    setState(() {
      _tabController = TabController(length: _tabsName.length, vsync: this);
    });

    _tabController.addListener(() {
      _onTabChanged();
    });
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation?.value) {
      setState(() {
        _currentIndex = _tabController.index;
      });

      //_getProjectList(3);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

}
