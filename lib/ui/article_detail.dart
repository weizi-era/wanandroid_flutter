import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail(this.itemData, {Key? key}) : super(key: key);

  //final url;
  final itemData;
  @override
  State<ArticleDetail> createState() => _ArticleDetailState(itemData);
}

class _ArticleDetailState extends State<ArticleDetail> {
  var itemData;

  /// 控制正在加载的显示
  bool _isHidden = true;

  final _key = UniqueKey();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _ArticleDetailState(this.itemData);

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemData["title"]),
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: !_isHidden,
            child: Center(child: CircularProgressIndicator(),),
          ),
          Offstage(
            offstage: _isHidden,
            child: WebView(
              key: _key,
              initialUrl: itemData["link"],
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageStarted: (url) {
                print("开始加载：$url");
              },
              onPageFinished: (url) {
                print("加载完成：$url");
                _isHidden = false;
                setState(() {});
              },
            ),
          )
        ],
      )
    );
  }
}
