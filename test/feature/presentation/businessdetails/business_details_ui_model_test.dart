import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_mapper.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_ui_model.dart';

void main() {
  final User fakeUser = User(
    name: "name",
    photoUrl: "photoUrl",
  );

  final Review fakeReview = Review(
    user: fakeUser,
    text: "text",
    rating: 5,
    timeCreated: "01-01-2020",
  );

  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    photoUrl: "photoUrl",
    rating: 4.5,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category#1, category#2"],
    hours: {
      0: ["16:00 - 23:00"],
      1: ["11:00 - 14:00"],
    },
    reviews: [fakeReview, fakeReview],
  );

  final UserUiModel fakeUserUiModel = UserUiModel(
    name: "name",
    photoUrl: "photoUrl",
  );

  final ReviewUiModel fakeReviewUiModel = ReviewUiModel(
    user: fakeUserUiModel,
    text: "text",
    ratingImage: AssetImage("assets/stars_small_5.png"),
    timeCreated: "01-01-2020",
  );

  final BusinessDetailsUiModel fakeBusinessDetailsUiModel = BusinessDetailsUiModel(
    id: "id",
    name: "NAME",
    photoUrl: "photoUrl",
    ratingImage: AssetImage("assets/stars_small_4_half.png"),
    reviewCount: 1337,
    address: "address",
    priceAndCategories: "price  •  category#1, category#2",
    hours: {
      0: ["16:00 - 23:00"],
      1: ["11:00 - 14:00"],
    },
    reviews: [fakeReviewUiModel, fakeReviewUiModel],
  );

  test(
    "toUiModel()",
    () async {
      // Act
      final BusinessDetailsUiModel result = fakeBusiness.toUiModel();

      // Assert
      expect(result, fakeBusinessDetailsUiModel);
    },
  );
}
