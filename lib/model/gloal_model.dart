import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalModel with ChangeNotifier {

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  void switchTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
