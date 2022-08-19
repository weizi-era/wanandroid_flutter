import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/ui/home/home_page.dart';
import 'package:wanandroid_flutter/ui/mine/mine_page.dart';
import 'package:wanandroid_flutter/ui/project/project.dart';
import 'package:wanandroid_flutter/ui/public/public.dart';
import 'package:wanandroid_flutter/ui/system/system.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {

  int currentIndex = 0;

  late PageController _pageController;

  final List<Widget> _tabs = [
    HomePage(),
    Project(),
    Public(),
    System(),
    MinePage(),
  ];

  @override
  void initState() {
    super.initState();
    //初始化页面控制器
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
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
          _pageController.jumpToPage(index);
        });
      },
      currentIndex: currentIndex,),
      body: PageView(
        // 禁用横向滑动切换
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _tabs,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

}
