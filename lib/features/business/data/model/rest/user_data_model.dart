import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserDataModel extends Equatable {
  final String name;
  final String imageUrl;

  UserDataModel({
    @required this.name,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json["name"],
      imageUrl: json["image_url"],
    );
  }
}
