// lib/UI/home/data/models/technician_model.dart
class Technician {
  final String id;
  final String name;
  final String phone;
  final String city;
  final String specialty;


  Technician({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.specialty,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "city": city,
        "specialty": specialty,
      };

  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json["id"].toString(),
      name: json["name"] ?? '',
      phone: json["phone"] ?? '',
      city: json["city"] ?? '',
      specialty: json["specialty"] ?? '',
    );
  }
}
