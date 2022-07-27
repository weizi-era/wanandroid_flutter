import 'package:wanandroid_flutter/network/http_manager.dart';

class Api {
  static const String baseUrl = "http://www.wanandroid.com/";

  static const String ARTICLE_LIST = "article/list/";

  static const String BANNER = "banner/json";

  static const String PROJECT_TAB = "project/tree/json";

  static const String PROJECT_LIST = "project/list/";

  static getArticleList(int page) async {
    return HttpManager.getInstance().request("$ARTICLE_LIST$page/json");
  }

  static getBanner() async {
    return HttpManager.getInstance().request(BANNER);
  }

  static getProjectTab() async {
    return HttpManager.getInstance().request(PROJECT_TAB);
  }

  static getProjectList(int page, int cid) async {
    return HttpManager.getInstance().request(
        "$PROJECT_LIST$page/json",
        queryParameters: {
          "cid": cid,
        });
  }
}
