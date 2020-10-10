import 'package:yelpexplorer/domain/model/user.dart';

class Review {
  User user;
  String text;
  int rating;
  String timeCreated;

  Review(
    this.user,
    this.text,
    this.rating,
    this.timeCreated,
  );

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      User.fromJson(json["user"]),
      json["text"],
      json["rating"],
      json["time_created"].toString().substring(0, 10),
    );
  }
}
