
import 'package:flutter/material.dart';

class BaseState<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }

  @override
  bool get wantKeepAlive => true;
}
