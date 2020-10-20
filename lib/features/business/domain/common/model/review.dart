import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';

class Review extends Equatable {
  final User user;
  final String text;
  final int rating;
  final String timeCreated;

  Review({
    @required this.user,
    @required this.text,
    @required this.rating,
    @required this.timeCreated,
  });

  @override
  List<Object> get props => [user, text, rating, timeCreated];
}
