import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanandroid_flutter/ui/article_page.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页", ),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "项目",),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "公众号"),
          BottomNavigationBarItem(icon: Icon(Icons.system_security_update), label: "体系"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ]),
        appBar: AppBar(
          title: Center(child: Text("首页",)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
        ),
        body: ArticlePage(),
      )
    );
  }
}