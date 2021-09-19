import 'package:equatable/equatable.dart';

class UserRestModel extends Equatable {
  final String name;
  final String? imageUrl;

  UserRestModel({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  factory UserRestModel.fromJson(Map<String, dynamic> json) {
    return UserRestModel(
      name: json["name"],
      imageUrl: json["image_url"],
    );
  }
}
