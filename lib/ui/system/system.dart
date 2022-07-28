import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/system/system_page.dart';

class System extends StatefulWidget {
  const System({Key? key}) : super(key: key);

  @override
  State<System> createState() => _SystemState();
}

class _SystemState extends State<System> with TickerProviderStateMixin {
  List<Widget> _tabs = [
    Tab(
      text: "体系",
    ),
    Tab(
      text: "导航",
    ),
  ];

  late TabController _tabController;

  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: _tabs,
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        body: TabBarView(
          children: [
            SystemPage(),
            SystemPage(),
          ],
          controller: _tabController,
        ));
  }
}
