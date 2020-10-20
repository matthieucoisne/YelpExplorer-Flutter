import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/user_graphql_model.dart';

class ReviewGraphQLModel extends Equatable {
  final UserGraphQLModel user;
  final String text;
  final int rating;
  final String timeCreated;

  ReviewGraphQLModel({
    @required this.user,
    @required this.text,
    @required this.rating,
    @required this.timeCreated,
  });

  @override
  List<Object> get props => [user, text, rating, timeCreated];

  factory ReviewGraphQLModel.fromJson(Map<String, dynamic> json) {
    return ReviewGraphQLModel(
      user: UserGraphQLModel.fromJson(json["user"]),
      text: json["text"],
      rating: json["rating"],
      timeCreated: json["time_created"],
    );
  }
}
