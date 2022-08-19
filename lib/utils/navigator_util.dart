
import 'package:flutter/material.dart';

class NavigatorUtils {

  static navigate(BuildContext context, Widget child) {
    Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation), child: child,),
          );
        }));
  }
}