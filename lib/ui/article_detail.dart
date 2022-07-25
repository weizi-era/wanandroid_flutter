import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({Key? key, required this.url}) : super(key: key);

  final url;
  @override
  State<ArticleDetail> createState() => _ArticleDetailState(url);
}

class _ArticleDetailState extends State<ArticleDetail> {
  var url;

  /// 控制正在加载的显示
  bool _isHidden = true;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _ArticleDetailState(this.url);

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
        title: Text("文章详情"),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
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
            offstage: !_isHidden,
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
              },
            ),
          )
        ],
      )
    );
  }
}
