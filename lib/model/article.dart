class Article {

  String apkLink;
  int audit;
  String author;
  bool canEdit;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc;
  String descMd;
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String niceShareDate;
  String origin;
  String prefix;
  String projectLink;
  int publishTime;
  int selfVisible;
  int shareDate;
  String shareUser;
  int superChapterId;
  String superChapterName;
  List<Tags> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

	Article.fromJsonMap(Map<String, dynamic> map): 
		apkLink = map["apkLink"],
		audit = map["audit"],
		author = map["author"],
		canEdit = map["canEdit"],
		chapterId = map["chapterId"],
		chapterName = map["chapterName"],
		collect = map["collect"],
		courseId = map["courseId"],
		desc = map["desc"],
		descMd = map["descMd"],
		envelopePic = map["envelopePic"],
		fresh = map["fresh"],
		id = map["id"],
		link = map["link"],
		niceDate = map["niceDate"],
		niceShareDate = map["niceShareDate"],
		origin = map["origin"],
		prefix = map["prefix"],
		projectLink = map["projectLink"],
		publishTime = map["publishTime"],
		selfVisible = map["selfVisible"],
		shareDate = map["shareDate"],
		shareUser = map["shareUser"],
		superChapterId = map["superChapterId"],
		superChapterName = map["superChapterName"],
		tags = List<Tags>.from(map["tags"].map((it) => Tags.fromJsonMap(it))),
		title = map["title"],
		type = map["type"],
		userId = map["userId"],
		visible = map["visible"],
		zan = map["zan"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['apkLink'] = apkLink;
		data['audit'] = audit;
		data['author'] = author;
		data['canEdit'] = canEdit;
		data['chapterId'] = chapterId;
		data['chapterName'] = chapterName;
		data['collect'] = collect;
		data['courseId'] = courseId;
		data['desc'] = desc;
		data['descMd'] = descMd;
		data['envelopePic'] = envelopePic;
		data['fresh'] = fresh;
		data['id'] = id;
		data['link'] = link;
		data['niceDate'] = niceDate;
		data['niceShareDate'] = niceShareDate;
		data['origin'] = origin;
		data['prefix'] = prefix;
		data['projectLink'] = projectLink;
		data['publishTime'] = publishTime;
		data['selfVisible'] = selfVisible;
		data['shareDate'] = shareDate;
		data['shareUser'] = shareUser;
		data['superChapterId'] = superChapterId;
		data['superChapterName'] = superChapterName;
		data['tags'] = tags != null ? 
			this.tags.map((v) => v.toJson()).toList()
			: null;
		data['title'] = title;
		data['type'] = type;
		data['userId'] = userId;
		data['visible'] = visible;
		data['zan'] = zan;
		return data;
	}
}

class Tags {

	String name;
	String url;

	Tags.fromJsonMap(Map<String, dynamic> map):
				name = map["name"],
				url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['url'] = url;
		return data;
	}
}