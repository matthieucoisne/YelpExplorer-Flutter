import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/data/model/rest/user_data_model.dart';

class ReviewListDataModel extends Equatable {
  final List<ReviewDataModel> reviews;

  ReviewListDataModel({
    @required this.reviews,
  });

  @override
  List<Object> get props => [reviews];

  factory ReviewListDataModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonReviews = json["reviews"];
    final List<ReviewDataModel> reviews = jsonReviews.map((jsonReviews) {
      return ReviewDataModel.fromJson(jsonReviews);
    }).toList();

    return ReviewListDataModel(
      reviews: reviews,
    );
  }
}

class ReviewDataModel extends Equatable {
  final UserDataModel user;
  final String text;
  final int rating;
  final String timeCreated;

  ReviewDataModel({
    @required this.user,
    @required this.text,
    @required this.rating,
    @required this.timeCreated,
  });

  @override
  List<Object> get props => [user, text, rating, timeCreated];

  factory ReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ReviewDataModel(
      user: UserDataModel.fromJson(json["user"]),
      text: json["text"],
      rating: json["rating"],
      timeCreated: json["time_created"],
    );
  }
}
