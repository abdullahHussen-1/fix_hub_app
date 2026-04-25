// lib/UI/home/data/models/review_model.dart
class ReviewModel {
  final String technicianId;
  final String userName;
  final double rating;
  final String comment;
  final String date;

  ReviewModel({
    required this.technicianId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        "technicianId": technicianId,
        "userName": userName,
        "rating": rating,
        "comment": comment,
        "date": date,
      };

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      technicianId: json["technicianId"],
      userName: json["userName"] ?? '',
      rating: (json["rating"] as num).toDouble(),
      comment: json["comment"] ?? '',
      date: json["date"] ?? '',
    );
  }
}
