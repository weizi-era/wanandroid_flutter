import 'package:wanandroid_flutter/network/http_manager.dart';

class Api {
  static const String baseUrl = "http://www.wanandroid.com/";

  static const String ARTICLE_LIST = "article/list/";

  static const String BANNER = "banner/json";

  static const String PROJECT_TAB = "project/tree/json";

  static const String PROJECT_LIST = "project/list/";

  static const String PUBLIC_TAB = "wxarticle/chapters/json";

  static const String PUBLIC_LIST = "wxarticle/list/";

  static const String SYSTEM_TREE = "tree/json";

  static const String NAVIGATOR_TREE = "navi/json";

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

  static getPublicTab() async {
    return HttpManager.getInstance().request(PUBLIC_TAB);
  }

  static getPublicList(int page, int id) async {
    return HttpManager.getInstance().request("$PUBLIC_LIST$id/$page/json");
  }

  static getSystemTree() async {
    return HttpManager.getInstance().request(SYSTEM_TREE);
  }

  static getNavigatorTree() async {
    return HttpManager.getInstance().request(NAVIGATOR_TREE);
  }

}
