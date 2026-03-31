class UserModel {
  final String name;
  final String phone;
  final String? email;
  final String? image;
  final String? bio;
  final String nationalId;
  final String city;
  final String address;
  final String? specialty;
  final String password;
  final String confrimPassword;
  final String? role;
  final String? tocken;

  UserModel({
    this.role,
    required this.name,
    required this.phone,
    this.email,
    this.image,
    this.bio,
    required this.nationalId,
    required this.city,
    required this.address,
    required this.specialty,
    required this.password,
    required this.confrimPassword,
    this.tocken,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      nationalId: json['nationalId'] ?? '',
      phone: json['phone'] ?? "",
      city: json['city'] ?? "",
      address: json['address'] ?? '',
      specialty: json['specialty'] ?? '',
      password: json['password'] ?? '',
      confrimPassword: json['confrimPassword'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      bio: json['bio'] ?? "",
      tocken: json['tocken'] ?? "",
      role: json['role'] ?? "",
    );
  }
}
