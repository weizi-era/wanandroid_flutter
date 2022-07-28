import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/home.dart';
import 'package:wanandroid_flutter/ui/mine.dart';
import 'package:wanandroid_flutter/ui/project/project.dart';
import 'package:wanandroid_flutter/ui/public/public.dart';
import 'package:wanandroid_flutter/ui/system.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  int currentIndex = 0;

  List _tabs = [
    Home(),
    Project(),
    Public(),
    System(),
    Mine(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页", ),
            BottomNavigationBarItem(icon: Icon(Icons.toc), label: "项目",),
            BottomNavigationBarItem(icon: Icon(Icons.public), label: "公众号"),
            BottomNavigationBarItem(icon: Icon(Icons.architecture), label: "体系"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
          ],
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      currentIndex: currentIndex,),
      body: _tabs[currentIndex],
    );
  }
}
