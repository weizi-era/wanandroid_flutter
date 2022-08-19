import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:wanandroid_flutter/ui/login.dart';
import 'package:wanandroid_flutter/ui/mine/collection_page.dart';
import 'package:wanandroid_flutter/ui/mine/score_page.dart';
import 'package:wanandroid_flutter/ui/mine/settings.dart';
import 'package:wanandroid_flutter/ui/mine/shared_page.dart';
import 'package:wanandroid_flutter/utils/navigator_util.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';
import 'package:wanandroid_flutter/utils/toast_util.dart';

class MinePage extends StatefulWidget {
  const MinePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  bool isDark = false;

  var userinfo;
  var scoreInfo;

  bool _isHidden = true;
  bool _ignore = false;

  late AnimationController controller;
  late Animation<Offset> animate;

  bool _login = false;
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    debugPrint("第一次调用initState");
    _brightness = Brightness.light;
    _login = SPUtil().getValue("login");
    if (_login != null && _login) {
      _getScoreInfo();
      setState(() {
        _isHidden = false;
        _ignore = true;
      });
    }
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
    super.build(context);
    _login = SPUtil().getValue("login");
    return SlideTransition(
      position: animate,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "images/background1.jpeg",
                  color: Colors.green,
                ),
                Positioned(
                  child: IgnorePointer(
                    ///使其具备或失去接收触摸事件的能力
                    child: InkWell(
                      child: avator(),
                      onTap: () async {
                        userinfo = await Navigator.of(context).push(
                            PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 300),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  ///开启动画
                                  controller.forward();
                                  return SlideTransition(
                                    position: Tween(
                                            begin: Offset(1.0, 0.0),
                                            end: Offset(0.0, 0.0))
                                        .animate(animation),
                                    child: Login(),
                                  );
                                }));

                        /// 反向执行动画
                        controller.reverse();
                        if (userinfo != null) {
                          _getScoreInfo();
                        }
                      },
                    ),
                    ignoring: _ignore,

                    /// false:可以接收触摸事件
                  ),
                  left: 10.0,
                ),
                Positioned(
                  child: Offstage(
                    /// 控制控件当显示和隐藏，隐藏后的控件不占据空间
                    offstage: _isHidden,

                    /// true:隐藏控件，false:展示控件
                    child: IconButton(
                        onPressed: () {
                          Api.logout();
                          setState(() {
                            SPUtil().remove("Cookie");
                            SPUtil().setValue("login", false);
                            userinfo = null;
                            scoreInfo = null;
                            _isHidden = true;
                            _ignore = false;
                          });
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 25.0,
                          color: Colors.white,
                        )),
                  ),
                  right: 15.0,
                  top: 40.0,
                ),
              ],
            ),
            bodys(),
          ],
        ),
      ),
    );
  }

  _getScoreInfo() async {
    EasyLoading.show(status: "加载中...");
    var data = await Api.getScoreInfo();
    if (data != null) {
      scoreInfo = data["data"];
    }
    EasyLoading.dismiss();

    setState(() {
      _isHidden = false;
      _ignore = true;
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
            _getNameWidget(_login),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      "id：${scoreInfo == null ? "—" : scoreInfo["userId"]}",
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
            ),
          ],
        )
      ],
    );
  }

  Widget _getNameWidget(bool login) {
    if (login) {
      return Text(
        SPUtil().getValue("username"),
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        userinfo == null
            ? "点我登录"
            : (userinfo["nickname"].toString().isEmpty
                ? userinfo["username"]
                : userinfo["nickname"]),
        style: TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
      );
    }
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
                      "我的积分：${scoreInfo == null ? "—" : scoreInfo["coinCount"]}",
                      style: TextStyle(color: Colors.grey[500]),
                    )),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          onTap: () {
            if (_login != null && _login) {
              NavigatorUtils.navigate(context, ScorePage());
            } else {
              ToastUtils.show("请先登录");
            }
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
          onTap: () {
            if (_login != null && _login) {
              NavigatorUtils.navigate(context, CollectionPage());
            } else {
              ToastUtils.show("请先登录");
            }
          },
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
          onTap: () {
            if (_login != null && _login) {
              NavigatorUtils.navigate(context, SharedPage());
            } else {
              ToastUtils.show("请先登录");
            }
          },
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
                  value: _brightness != Brightness.light,
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
                      //isDark = value;
                      value
                          ? _brightness = Brightness.dark
                          : _brightness = Brightness.light;
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
            NavigatorUtils.navigate(context, Settings());
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
