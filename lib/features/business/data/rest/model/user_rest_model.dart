import 'package:equatable/equatable.dart';

class UserRestModel extends Equatable {
  final String name;
  final String? photoUrl;

  UserRestModel({
    required this.name,
    required this.photoUrl,
  });

  @override
  List<Object?> get props => [name, photoUrl];

  factory UserRestModel.fromJson(Map<String, dynamic> json) {
    return UserRestModel(
      name: json["name"],
      photoUrl: json["image_url"],
    );
  }
}
