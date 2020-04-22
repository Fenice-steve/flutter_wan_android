//class Article {
//
//  String apkLink;
//  int audit;
//  String author;
//  bool canEdit;
//  int chapterId;
//  String chapterName;
//  bool collect;
//  int courseId;
//  String desc;
//  String descMd;
//  String envelopePic;
//  bool fresh;
//  int id;
//  String link;
//  String niceDate;
//  String niceShareDate;
//  String origin;
//  String prefix;
//  String projectLink;
//  int publishTime;
//  int selfVisible;
//  int shareDate;
//  String shareUser;
//  int superChapterId;
//  String superChapterName;
//  List<Tags> tags;
//  String title;
//  int type;
//  int userId;
//  int visible;
//  int zan;
//
//	Article.fromJsonMap(Map<String, dynamic> map):
//		apkLink = map["apkLink"],
//		audit = map["audit"],
//		author = map["author"],
//		canEdit = map["canEdit"],
//		chapterId = map["chapterId"],
//		chapterName = map["chapterName"],
//		collect = map["collect"],
//		courseId = map["courseId"],
//		desc = map["desc"],
//		descMd = map["descMd"],
//		envelopePic = map["envelopePic"],
//		fresh = map["fresh"],
//		id = map["id"],
//		link = map["link"],
//		niceDate = map["niceDate"],
//		niceShareDate = map["niceShareDate"],
//		origin = map["origin"],
//		prefix = map["prefix"],
//		projectLink = map["projectLink"],
//		publishTime = map["publishTime"],
//		selfVisible = map["selfVisible"],
//		shareDate = map["shareDate"],
//		shareUser = map["shareUser"],
//		superChapterId = map["superChapterId"],
//		superChapterName = map["superChapterName"],
//		tags = List<Tags>.from(map["tags"].map((it) => Tags.fromJsonMap(it))),
//		title = map["title"],
//		type = map["type"],
//		userId = map["userId"],
//		visible = map["visible"],
//		zan = map["zan"];
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['apkLink'] = apkLink;
//		data['audit'] = audit;
//		data['author'] = author;
//		data['canEdit'] = canEdit;
//		data['chapterId'] = chapterId;
//		data['chapterName'] = chapterName;
//		data['collect'] = collect;
//		data['courseId'] = courseId;
//		data['desc'] = desc;
//		data['descMd'] = descMd;
//		data['envelopePic'] = envelopePic;
//		data['fresh'] = fresh;
//		data['id'] = id;
//		data['link'] = link;
//		data['niceDate'] = niceDate;
//		data['niceShareDate'] = niceShareDate;
//		data['origin'] = origin;
//		data['prefix'] = prefix;
//		data['projectLink'] = projectLink;
//		data['publishTime'] = publishTime;
//		data['selfVisible'] = selfVisible;
//		data['shareDate'] = shareDate;
//		data['shareUser'] = shareUser;
//		data['superChapterId'] = superChapterId;
//		data['superChapterName'] = superChapterName;
//		data['tags'] = tags != null ?
//			this.tags.map((v) => v.toJson()).toList()
//			: null;
//		data['title'] = title;
//		data['type'] = type;
//		data['userId'] = userId;
//		data['visible'] = visible;
//		data['zan'] = zan;
//		return data;
//	}
//}
//
//class Tags {
//
//	String name;
//	String url;
//
//	Tags.fromJsonMap(Map<String, dynamic> map):
//				name = map["name"],
//				url = map["url"];
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['name'] = name;
//		data['url'] = url;
//		return data;
//	}
//}

import 'package:wanandroidflutter/utils/string_utils.dart';

class Article {
	String apkLink;
	String author;
	/// 2019.10.13 添加分享人,author可能为空
	String shareUser;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String envelopePic;
	bool fresh;
	int id;
	String link;
	String niceDate;
	String origin;
	int originId;
	String prefix;
	String projectLink;
	int publishTime;
	int superChapterId;
	String superChapterName;
	List<TagsBean> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;



	static Article fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		Article articleBean = Article();
		articleBean.apkLink = map['apkLink'];
		articleBean.author = map['author'];
		articleBean.shareUser = map['shareUser'];
		articleBean.chapterId = map['chapterId'];
//    articleBean.chapterName = map['chapterName'];
		articleBean.chapterName = StringUtils.urlDecoder(map["chapterName"]);
		articleBean.collect = map['collect'];
		articleBean.courseId = map['courseId'];
//    articleBean.desc = map['desc'];
		articleBean.desc = StringUtils.urlDecoder(map["desc"]);
		articleBean.envelopePic = map['envelopePic'];
		articleBean.fresh = map['fresh'];
		articleBean.id = map['id'];
		articleBean.link = map['link'];
		articleBean.niceDate = map['niceDate'];
		articleBean.origin = map['origin'];
		articleBean.originId = map['originId'];
		articleBean.prefix = map['prefix'];
		articleBean.projectLink = map['projectLink'];
		articleBean.publishTime = map['publishTime'];
		articleBean.superChapterId = map['superChapterId'];
//    articleBean.superChapterName = map['superChapterName'];
		articleBean.superChapterName = StringUtils.urlDecoder(map["superChapterName"]);
		articleBean.tags = List()
			..addAll((map['tags'] as List ?? []).map((o) => TagsBean.fromMap(o)));
		articleBean.title = StringUtils.urlDecoder(map["title"]);
		articleBean.type = map['type'];
		articleBean.userId = map['userId'];
		articleBean.visible = map['visible'];
		articleBean.zan = map['zan'];
		return articleBean;
	}

	Map toJson() => {
		"apkLink": apkLink,
		"author": author,
		"shareUser": shareUser,
		"chapterId": chapterId,
		"chapterName": chapterName,
		"collect": collect,
		"courseId": courseId,
		"desc": desc,
		"envelopePic": envelopePic,
		"fresh": fresh,
		"id": id,
		"link": link,
		"niceDate": niceDate,
		"origin": origin,
		"originId": originId,
		"prefix": prefix,
		"projectLink": projectLink,
		"publishTime": publishTime,
		"superChapterId": superChapterId,
		"superChapterName": superChapterName,
		"tags": tags,
		"title": title,
		"type": type,
		"userId": userId,
		"visible": visible,
		"zan": zan,
	};
}

class TagsBean {
	String name;
	String url;

	static TagsBean fromMap(Map<String, dynamic> map) {
		if (map == null) return null;
		TagsBean tagsBean = TagsBean();
		tagsBean.name = map['name'];
		tagsBean.url = map['url'];
		return tagsBean;
	}

	Map toJson() => {
		"name": name,
		"url": url,
	};
}
