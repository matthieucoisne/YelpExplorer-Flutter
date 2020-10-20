import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String name;
  final String imageUrl;

  User({
    @required this.name,
    @required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];
}
