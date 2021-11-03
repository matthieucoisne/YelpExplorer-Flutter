import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BusinessDetailsUiModel extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final AssetImage ratingImage;
  final int reviewCount;
  final String address;
  final String priceAndCategories;
  final Map<int, List<String>> hours;
  final List<ReviewUiModel> reviews;

  BusinessDetailsUiModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.ratingImage,
    required this.reviewCount,
    required this.address,
    required this.priceAndCategories,
    required this.hours,
    required this.reviews,
  });

  @override
  List<Object> get props => [id, name, photoUrl, ratingImage, reviewCount, address, priceAndCategories, hours, reviews];
}

class ReviewUiModel extends Equatable {
  final UserUiModel user;
  final String text;
  final AssetImage ratingImage;
  final String timeCreated;

  ReviewUiModel({
    required this.user,
    required this.text,
    required this.ratingImage,
    required this.timeCreated,
  });

  @override
  List<Object> get props => [user, text, ratingImage, timeCreated];
}

class UserUiModel extends Equatable {
  final String name;
  final String photoUrl;

  UserUiModel({
    required this.name,
    required this.photoUrl,
  });

  @override
  List<Object> get props => [name, photoUrl];
}
