import 'package:wanandroid_flutter/generated/json/base/json_field.dart';
import 'package:wanandroid_flutter/generated/json/article.g.dart';
import 'dart:convert';

@JsonSerializable()
class Article {

	ArticleData? data;
	int? errorCode;
	String? errorMsg;
  
  Article();

  factory Article.fromJson(Map<String, dynamic> json) => $ArticleFromJson(json);

  Map<String, dynamic> toJson() => $ArticleToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleData {

	int? curPage;
	List<ArticleDataDatas>? datas;
	int? offset;
	bool? over;
	int? pageCount;
	int? size;
	int? total;
  
  ArticleData();

  factory ArticleData.fromJson(Map<String, dynamic> json) => $ArticleDataFromJson(json);

  Map<String, dynamic> toJson() => $ArticleDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ArticleDataDatas {

	String? apkLink;
	int? audit;
	String? author;
	bool? canEdit;
	int? chapterId;
	String? chapterName;
	bool? collect;
	int? courseId;
	String? desc;
	String? descMd;
	String? envelopePic;
	bool? fresh;
	String? host;
	int? id;
	String? link;
	String? niceDate;
	String? niceShareDate;
	String? origin;
	String? prefix;
	String? projectLink;
	int? publishTime;
	int? realSuperChapterId;
	int? selfVisible;
	int? shareDate;
	String? shareUser;
	int? superChapterId;
	String? superChapterName;
	List<dynamic>? tags;
	String? title;
	int? type;
	int? userId;
	int? visible;
	int? zan;
  
  ArticleDataDatas();

  factory ArticleDataDatas.fromJson(Map<String, dynamic> json) => $ArticleDataDatasFromJson(json);

  Map<String, dynamic> toJson() => $ArticleDataDatasToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}