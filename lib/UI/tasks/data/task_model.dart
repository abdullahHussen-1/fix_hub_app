class TaskModel {
  final String id;
  final String userName;
  final String userImage;
  final String description;
  final String address;

  TaskModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.description,
    required this.address,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      userName: json['userName'],
      userImage: json['userImage'],
      description: json['description'],
      address: json['address'],
    );
  }
}
