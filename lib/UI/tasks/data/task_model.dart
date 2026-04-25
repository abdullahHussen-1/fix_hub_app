// lib/UI/tasks/data/task_model.dart
class TaskModel {
  final String id;
  final String technicianId; // الربط
  final String userName;
  final String userImage;
  final String typeOfService;
  final String description;
  final String date;
  final String time;
  final String address;

  TaskModel({
    required this.id,
    required this.technicianId,
    required this.userName,
    required this.userImage,
    required this.typeOfService,
    required this.description,
    required this.date,
    required this.time,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "technicianId": technicianId,
        "userName": userName,
        "userImage": userImage,
        "typeOfService": typeOfService,
        "description": description,
        "date": date,
        "time": time,
        "address": address,
      };

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      technicianId: json["technicianId"],
      userName: json["userName"] ?? '',
      userImage: json["userImage"] ?? '',
      typeOfService: json["typeOfService"] ?? '',
      description: json["description"] ?? '',
      date: json["date"] ?? '',
      time: json["time"] ?? '',
      address: json["address"] ?? '',
    );
  }
}
