import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  //创建工厂方法
  static SPUtil? _instance;
  factory SPUtil() => _instance ??= SPUtil._internal();
  SharedPreferences? _sp;

  //static SharedPreferences? instance;

  // static getInstance() async {
  //   return _sp ??= await SharedPreferences.getInstance();
  // }

  //创建命名构造函数
  SPUtil._internal() {
    //为什么在这里需要新写init方法 主要是在命名构造中不能使用async/await
    init();
  }

  //初始化SharedPreferences
  void init() async {
    _sp ??= await SharedPreferences.getInstance();
  }

  //到这里还没有完 有时候会遇到使用时提示 SharedPreferences 未初始化,所以还需要提供一个static 的方法
  static Future<SPUtil?> perInit() async {
    if (_instance == null) {
      //静态方法不能访问非静态变量所以需要创建变量再通过方法赋值回去
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = SPUtil._pre(preferences);
    }
    return _instance;
  }
  SPUtil._pre(SharedPreferences prefs) {
    _sp = prefs;
  }

  setValue(String key, Object value) async {
    switch (value.runtimeType) {
      case int:
        await _sp!.setInt(key, value as int);
        break;
      case bool:
        await _sp!.setBool(key, value as bool);
        break;
      case double:
        await _sp!.setDouble(key, value as double);
        break;
      case String:
        await _sp!.setString(key, value as String);
        break;
      case List:
        await _sp!.setStringList(key, value as List<String>);
        break;
      default:
        await _sp!.setString(key, value as String);
        break;
    }
  }

  T? getValue<T>(String key) {
    var result = _sp!.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }

  ///清除全部
  void clean() {
    _sp!.clear();
  }
  ///移除某一个
  void remove(String key) {
    _sp!.remove(key);
  }
}
