
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/system/system_item_page.dart';

class SystemDetail extends StatefulWidget {
  const SystemDetail({Key? key, this.itemData, this.index}) : super(key: key);

  final itemData;

  final index;

  @override
  State<SystemDetail> createState() => _SystemDetailState();
}

class _SystemDetailState extends State<SystemDetail> with TickerProviderStateMixin {

  List<Widget> _tabsName = [];

  List _tabs = [];

  late TabController _tabController;

  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    getTabsName();

    _tabController = TabController(initialIndex: widget.index, length: _tabsName.length, vsync: this);

    _tabController.addListener(() {
      _onTabChanged();
    });

  }

  void getTabsName() {
    _tabs = widget.itemData["children"];

    _tabsName = _tabs.map((item) {
      return Tab(
        text: item["name"],
      );
    }).toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _onTabChanged() {
    if (_tabController.index.toDouble() == _tabController.animation?.value) {
      setState(() {
        _currentIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemData["name"]),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        bottom: TabBar(
          tabs: _tabsName,
          controller: _tabController,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((item) {
          return SystemItemPage(id: item["id"]);
        }).toList(),
      ),
    );
  }
}
