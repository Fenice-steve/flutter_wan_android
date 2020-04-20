//class WechatTree {
//
//  List<Object> children;
//  int courseId;
//  int id;
//  String name;
//  int order;
//  int parentChapterId;
//  bool userControlSetTop;
//  int visible;
//
//	WechatTree.fromJsonMap(Map<String, dynamic> map):
//		children = map["children"],
//		courseId = map["courseId"],
//		id = map["id"],
//		name = map["name"],
//		order = map["order"],
//		parentChapterId = map["parentChapterId"],
//		userControlSetTop = map["userControlSetTop"],
//		visible = map["visible"];
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['children'] = children;
//		data['courseId'] = courseId;
//		data['id'] = id;
//		data['name'] = name;
//		data['order'] = order;
//		data['parentChapterId'] = parentChapterId;
//		data['userControlSetTop'] = userControlSetTop;
//		data['visible'] = visible;
//		return data;
//	}
//}


import 'package:wanandroidflutter/utils/string_utils.dart';

class WechatTree {
	List<WechatTree> children;
	int courseId;
	int id;
	String name;
	int order;
	int parentChapterId;
	bool userControlSetTop;
	int visible;

	WechatTree.fromJsonMap(Map<String, dynamic> map)
			: children =
	List<WechatTree>.from(map["children"].map((it) => WechatTree.fromJsonMap(it))),
				courseId = map["courseId"],
				id = map["id"],
				name = StringUtils.urlDecoder(map["name"]),
				order = map["order"],
				parentChapterId = map["parentChapterId"],
				userControlSetTop = map["userControlSetTop"],
				visible = map["visible"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['children'] =
		children != null ? children.map((v) => v.toJson()).toList() : null;
		data['courseId'] = courseId;
		data['id'] = id;
		data['name'] = name;
		data['order'] = order;
		data['parentChapterId'] = parentChapterId;
		data['userControlSetTop'] = userControlSetTop;
		data['visible'] = visible;
		return data;
	}
}