import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wanandroid_flutter/network/api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanandroid_flutter/ui/mine/mine.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  late TextEditingController _accountController;
  late TextEditingController _passwordController;

  late AnimationController _controller;

  var passwordVisiable;

  @override
  void initState() {
    super.initState();
    passwordVisiable = false;
    _accountController = TextEditingController();
    _passwordController = TextEditingController();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("登录"),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Image.asset(
              "images/flutter.png",
              width: 64,
              height: 64,
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                      child: TextField(
                        controller: _accountController,
                        decoration: InputDecoration(
                          hintText: "手机号/用户名/邮箱",
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _accountController.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !passwordVisiable,
                        decoration: InputDecoration(
                          hintText: "密码",
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisiable = !passwordVisiable;
                              });
                            },
                            icon: Icon(passwordVisiable
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0))),
                          ),
                          onPressed: () {
                            _login();
                          },
                          child: Text("登录")),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              //   return RegisterPage();
                              // }));
                            },
                            child: Text("立即注册")),
                        TextButton(onPressed: () {}, child: Text("忘记密码")),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  _login() async {
    EasyLoading.show(status: "登录中...");
    var username = _accountController.text.toString();
    var password = _passwordController.text.toString();

    var loginResult = await Api.getLogin(username, password);

    SPUtil().setValue("username", username);
    SPUtil().setValue("password", password);

    print("loginResult :${loginResult}");

    if (loginResult["data"] == null) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(
          msg: "账号密码不匹配！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      EasyLoading.dismiss();
      Navigator.pop(context, loginResult["data"]);
    }
  }
}
