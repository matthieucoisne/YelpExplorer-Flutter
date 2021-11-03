import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String photoUrl;

  User({
    required this.name,
    required this.photoUrl,
  });

  @override
  List<Object> get props => [name, photoUrl];
}
