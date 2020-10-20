import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/data/rest/model/user_rest_model.dart';

class ReviewListRestModel extends Equatable {
  final List<ReviewRestModel> reviews;

  ReviewListRestModel({
    @required this.reviews,
  });

  @override
  List<Object> get props => [reviews];

  factory ReviewListRestModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonReviews = json["reviews"];
    final List<ReviewRestModel> reviews = jsonReviews.map((jsonReviews) {
      return ReviewRestModel.fromJson(jsonReviews);
    }).toList();

    return ReviewListRestModel(
      reviews: reviews,
    );
  }
}

class ReviewRestModel extends Equatable {
  final UserRestModel user;
  final String text;
  final int rating;
  final String timeCreated;

  ReviewRestModel({
    @required this.user,
    @required this.text,
    @required this.rating,
    @required this.timeCreated,
  });

  @override
  List<Object> get props => [user, text, rating, timeCreated];

  factory ReviewRestModel.fromJson(Map<String, dynamic> json) {
    return ReviewRestModel(
      user: UserRestModel.fromJson(json["user"]),
      text: json["text"],
      rating: json["rating"],
      timeCreated: json["time_created"],
    );
  }
}
