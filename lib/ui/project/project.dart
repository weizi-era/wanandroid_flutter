import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/network/http_manager.dart';
import 'package:wanandroid_flutter/ui/project/project_item.dart';
import 'package:wanandroid_flutter/ui/project/project_page.dart';

class Project extends StatefulWidget {
  const Project({Key? key}) : super(key: key);

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> with TickerProviderStateMixin {
  List _tabs = [];

  List<Widget> _tabsName = [];

  late TabController _tabController;

  var _currentIndex = 0;

  String? selectedValue;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 0, vsync: this);

    _getProjectTab();
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
        tabs: _tabsName,
        controller: _tabController,
        isScrollable: true,
      )),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((item) {
          return ProjectPage(id: item["id"]);
        }).toList(),
      ),
    );
  }

  _getProjectTab() async {
    var data = await Api.getProjectTab();

    if (data != null) {
      _tabs.addAll(data["data"]);
    }

    _tabsName = _tabs.map((item) {
      return Tab(
        text: item["name"],
      );
    }).toList();

   // _tabsName.add(dd());

    setState(() {
      _tabController = TabController(length: _tabsName.length, vsync: this);
    });

    _tabController.addListener(() {
      _onTabChanged();
    });
  }

  Widget dd() {
    return DropdownButton(
      items: _tabs.map((item) {
        return DropdownMenuItem<String>(
          value: item["name"],
          child: Text(
            item["name"],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value as String?;
        });
      },
      value: selectedValue,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
