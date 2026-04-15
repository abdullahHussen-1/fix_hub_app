class UserModel {
  final int id;
  final String name;
  final String phone;
  final String? image;
  final String nationalId;
  final String city;
  final String ?address;
  final String? profession;
  final String? role;
  final String? token;

  UserModel({
    this.id = 0,
    this.role,
    required this.name,
    required this.phone,
    this.image,
    required this.nationalId,
    required this.city,
     this.address,
     this.profession,
    this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      nationalId: json['national_id']?.toString() ?? '',
      phone: json['phone']?.toString() ?? "",
      city: json['city']?.toString() ?? "",
      address: json['address']?.toString(),
      profession: json['profession']?.toString(),
      image: json['image']?.toString(),
      token: json['token']?.toString(),
      role: json['user_type']?.toString(),
    );
  }
}
