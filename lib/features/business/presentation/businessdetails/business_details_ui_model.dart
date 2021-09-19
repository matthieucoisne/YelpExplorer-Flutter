import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/presentation/helper/business_helper.dart' as BusinessHelper;

extension BusinessDetailUiMapper on Business {
  BusinessDetailsUiModel toUiModel() {
    return BusinessDetailsUiModel(
      id: this.id,
      name: this.name.toUpperCase(),
      imageUrl: this.imageUrl,
      ratingImage: BusinessHelper.getRatingImage(this.rating),
      reviewCount: this.reviewCount,
      address: this.address,
      priceAndCategories: BusinessHelper.formatPriceAndCategories(this.price, this.categories),
      hours: this.hours,
      reviews: this.reviews.toUiModel(),
    );
  }
}

extension ReviewUiMapper on List<Review> {
  List<ReviewUiModel> toUiModel() {
    return map(
      (review) => ReviewUiModel(
        user: review.user.toUiModel(),
        text: review.text,
        ratingImage: BusinessHelper.getRatingImage(review.rating),
        timeCreated: review.timeCreated,
      ),
    ).toList();
  }
}

extension UserUiMapper on User {
  UserUiModel toUiModel() {
    return UserUiModel(
      name: this.name,
      imageUrl: this.imageUrl,
    );
  }
}

class BusinessDetailsUiModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final AssetImage ratingImage;
  final int reviewCount;
  final String address;
  final String priceAndCategories;
  final Map<int, List<String>> hours;
  final List<ReviewUiModel> reviews;

  BusinessDetailsUiModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ratingImage,
    required this.reviewCount,
    required this.address,
    required this.priceAndCategories,
    required this.hours,
    required this.reviews,
  });

  @override
  List<Object> get props => [id, name, imageUrl, ratingImage, reviewCount, address, priceAndCategories, hours, reviews];
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
  final String imageUrl;

  UserUiModel({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];
}
