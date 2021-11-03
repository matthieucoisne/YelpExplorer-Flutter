import 'package:equatable/equatable.dart';

class UserGraphQLModel extends Equatable {
  final String name;
  final String? photoUrl;

  UserGraphQLModel({
    required this.name,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [name, photoUrl];

  factory UserGraphQLModel.fromJson(Map<String, dynamic> json) {
    return UserGraphQLModel(
      name: json["name"],
      photoUrl: json["image_url"],
    );
  }
}
