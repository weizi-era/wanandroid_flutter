import 'package:wanandroid_flutter/network/http_manager.dart';
import 'package:wanandroid_flutter/utils/sp_util.dart';


class Api {
  static const String baseUrl = "https://www.wanandroid.com";

  static const String ARTICLE_LIST = "/article/list/";

  static const String BANNER = "/banner/json";

  static const String PROJECT_TAB = "/project/tree/json";

  static const String PROJECT_LIST = "/project/list/";

  static const String PUBLIC_TAB = "/wxarticle/chapters/json";

  static const String PUBLIC_LIST = "/wxarticle/list/";

  static const String SYSTEM_TREE = "/tree/json";

  static const String NAVIGATOR_TREE = "/navi/json";

  static const String LOGIN = "/user/login";

  static const String SCORE_INFO = "/lg/coin/userinfo/json";

  static const String RANK_LIST = "/coin/rank/";

  static const String SCORE_LIST = "/lg/coin/list/";

  static const String MY_COLLECTION = "/lg/collect/list/";

  static const String MY_SHARED = "/user/lg/private_articles/";

  static const String LOGOUT = "/user/logout/json";

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
  
  static getLogin(String username, String password) async {
    return HttpManager.getInstance().request(LOGIN, method: "POST", queryParameters: {
      "username" : username,
      "password" : password,
    });
  }
  
  static getScoreInfo() async {
    return HttpManager.getInstance().request(SCORE_INFO, headers: {
      "Cookie" : SPUtil().getValue("Cookie"),
    });
  }

  static getScoreList(int page) async {
    return HttpManager.getInstance().request("$SCORE_LIST$page/json");
  }
  
  static getRankList(int page) async {
    return HttpManager.getInstance().request("$RANK_LIST$page/json");
  }

  static getCollectionList(int page) async {
    return HttpManager.getInstance().request("$MY_COLLECTION$page/json", headers: {
      "Cookie" : SPUtil().getValue("Cookie"),
    });
  }

  static getSharedList(int page) async {
    return HttpManager.getInstance().request("$MY_SHARED$page/json", headers: {
      "Cookie" : SPUtil().getValue("Cookie"),
    });
  }

  static logout() async {
    return HttpManager.getInstance().request(LOGOUT);
  }

  static const int SYSTEM_FLAG = 1;

  static const int NAVIGATOR_FLAG = 2;
}
