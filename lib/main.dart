import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wanandroid_flutter/ui/tabs_page.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  SPUtil.perInit();
  EasyLoading.instance.userInteractions = false;  // false：不允许用户操作 类似EasyLoading拿到焦点
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home:TabsPage(),
      builder: EasyLoading.init(),
    );
  }

}
