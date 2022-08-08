import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/login.dart';
import 'package:wanandroid_flutter/ui/mine/score_page.dart';
import 'package:wanandroid_flutter/ui/mine/settings.dart';

class Mine extends StatefulWidget {
  const Mine({Key? key,}) : super(key: key);

  //late userinfo;

  @override
  State<Mine> createState() => _MineState();
}

class _MineState extends State<Mine> with TickerProviderStateMixin {
  bool isDark = false;

  var userinfo;
  var scoreInfo;

  late AnimationController controller;
  late Animation<Offset> animate;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    animate = Tween(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
        .animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animate,
      child: Scaffold(
        body: Column(
          children: [
            InkWell(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "images/background1.jpeg",
                    color: Colors.green,
                  ),
                  Positioned(
                    child: avator(),
                    left: 10.0,
                  ),
                ],
              ),
              onTap: () async {
                userinfo = await Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                    ///开启动画
                  controller.forward();
                  return SlideTransition(
                      position:
                          Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation),
                      child: Login(),
                    );
                }));

                _getScoreInfo();

              },
            ),
            bodys(),
          ],
        ),
      ),
    );
  }

  _getScoreInfo() async {
    /// 反向执行动画
    controller.reverse();
    EasyLoading.show(status: "加载中...");
    var data = await Api.getScoreInfo();
    if (data != null) {
      scoreInfo = data["data"];
    }
    EasyLoading.dismiss();

    setState(() {

    });
  }

  Widget avator() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            child: Image.asset("images/avator.png"),
            maxRadius: 40.0,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userinfo == null
                  ? "点我登录"
                  : (userinfo["nickname"].toString().isEmpty
                      ? userinfo["username"]
                      : userinfo["nickname"]),
              // widget.userinfo["nickname"].toString().isEmpty
              //     ? widget.userinfo["username"]
              //     : widget.userinfo["nickname"],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "id：${userinfo == null ? "—" : userinfo["id"]}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    "排名：${scoreInfo == null ? "—" : scoreInfo["rank"]}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget bodys() {
    Color _textColor = Colors.black;
    Color _appBarColor = Color.fromRGBO(36, 41, 46, 1);
    Color _scaffoldBgcolor = Colors.white;
    return Column(
      children: [
        SizedBox(
          height: 20.0,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  Icons.score,
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("积分排行"),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Text(
                      "我的积分：${userinfo == null ? "—" : userinfo["coinCount"]}",
                      style: TextStyle(color: Colors.grey[500]),
                    )),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) {

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                          .animate(animation), child: ScorePage(),),
                  );
                }));

          },
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("我的收藏"),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {},
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("我的分享"),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {},
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  Icons.style,
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("色彩主题"),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                Icons.light_mode,
                color: Colors.red,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text("黑夜模式"),
                ),
              ),
              FlutterSwitch(
                  width: 45.0,
                  height: 25.0,
                  value: isDark,
                  borderRadius: 30.0,
                  padding: 1.0,
                  activeToggleColor: Color(0xFF6E40C9),
                  inactiveToggleColor: Color(0xFF2F363D),
                  activeSwitchBorder: Border.all(
                    color: Color(0xFF3C1E70),
                    width: 1.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: Color(0xFFD1D5DA),
                    width: 1.0,
                  ),
                  activeColor: Color(0xFF271052),
                  inactiveColor: Colors.white,
                  activeIcon: Icon(
                    Icons.nightlight_round,
                    color: Color(0xFFF8E3A1),
                  ),
                  inactiveIcon: Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFDF5D),
                  ),
                  onToggle: (value) {
                    setState(() {
                      isDark = value;

                      if (value) {
                        _textColor = Colors.white;
                        _appBarColor = Color.fromRGBO(22, 27, 34, 1);
                        _scaffoldBgcolor = Color(0xFF0D1117);
                      } else {
                        _textColor = Colors.black;
                        _appBarColor = Color.fromRGBO(36, 41, 46, 1);
                        _scaffoldBgcolor = Colors.white;
                      }
                    });
                  })
            ],
          ),
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.red,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("系统设置"),
                  ),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Settings();
            }));
          },
        ),
      ],
    );
  }


}
