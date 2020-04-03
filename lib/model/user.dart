
class User {

  bool admin;
  List<Object> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;

	User.fromJsonMap(Map<String, dynamic> map): 
		admin = map["admin"],
		chapterTops = map["chapterTops"],
		collectIds = List<int>.from(map["collectIds"]),
		email = map["email"],
		icon = map["icon"],
		id = map["id"],
		nickname = map["nickname"],
		password = map["password"],
		publicName = map["publicName"],
		token = map["token"],
		type = map["type"],
		username = map["username"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['admin'] = admin;
		data['chapterTops'] = chapterTops;
		data['collectIds'] = collectIds;
		data['email'] = email;
		data['icon'] = icon;
		data['id'] = id;
		data['nickname'] = nickname;
		data['password'] = password;
		data['publicName'] = publicName;
		data['token'] = token;
		data['type'] = type;
		data['username'] = username;
		return data;
	}
}
