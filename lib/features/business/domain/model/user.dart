import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String imageUrl;

  User({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];
}
