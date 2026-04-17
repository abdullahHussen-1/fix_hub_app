/// success : true
/// data : {"id":1,"name":"احمشتبمشنتبيمن أحمد محمد خلف الله","phone":"01012345678","national_id":"12345678901234","city":"القاهرة","image":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLn2vN-qAufnhM8t2e4OkZ6-m3Md6_Gk9B7g&s","user_type":"normal","profession":null,"remember_token":null,"created_at":"2026-04-13T10:35:49.000000Z","updated_at":"2026-04-13T12:46:58.000000Z"}

class UserResponse {
  UserResponse({
    this.success,
    this.data,
  });

  UserResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : 1
/// name : "احمشتبمشنتبيمن أحمد محمد خلف الله"
/// phone : "01012345678"
/// national_id : "12345678901234"
/// city : "القاهرة"
/// image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLn2vN-qAufnhM8t2e4OkZ6-m3Md6_Gk9B7g&s"
/// user_type : "normal"
/// profession : null
/// remember_token : null
/// created_at : "2026-04-13T10:35:49.000000Z"
/// updated_at : "2026-04-13T12:46:58.000000Z"

class Data {
  Data({
    this.id,
    this.name,
    this.phone,
    this.nationalId,
    this.city,
    this.image,
    this.userType,
    this.profession,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    nationalId = json['national_id'];
    city = json['city'];
    image = json['image'];
    userType = json['user_type'];
    profession = json['profession'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  int? id;
  String? name;
  String? phone;
  String? nationalId;
  String? city;
  String? image;
  String? userType;
  dynamic profession;
  dynamic rememberToken;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['national_id'] = nationalId;
    map['city'] = city;
    map['image'] = image;
    map['user_type'] = userType;
    map['profession'] = profession;
    map['remember_token'] = rememberToken;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
