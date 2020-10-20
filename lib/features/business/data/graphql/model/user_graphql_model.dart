import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserGraphQLModel extends Equatable {
  final String name;
  final String imageUrl;

  UserGraphQLModel({
    @required this.name,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];

  factory UserGraphQLModel.fromJson(Map<String, dynamic> json) {
    return UserGraphQLModel(
      name: json["name"],
      imageUrl: json["image_url"],
    );
  }
}
