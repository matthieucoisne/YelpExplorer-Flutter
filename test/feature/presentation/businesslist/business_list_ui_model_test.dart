import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_mapper.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_ui_model.dart';

void main() {
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    photoUrl: "photoUrl",
    rating: 4.5,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category#1, category#2"],
    hours: {},
    reviews: [],
  );
  final List<Business> fakeBusinesses = [fakeBusiness];

  final BusinessListUiModel fakeBusinessListUiModel = BusinessListUiModel(
    id: "id",
    name: "1. NAME",
    photoUrl: "photoUrl",
    ratingImage: AssetImage("assets/stars_small_4_half.png"),
    reviewCount: "1337 reviews",
    address: "address",
    priceAndCategories: "price  •  category#1, category#2",
  );
  final List<BusinessListUiModel> fakeBusinessListUiModels = [fakeBusinessListUiModel];

  test(
    "toUiModels()",
    () async {
      // Act
      final List<BusinessListUiModel> result = fakeBusinesses.toUiModels();

      // Assert
      expect(result, fakeBusinessListUiModels);
    },
  );
}
