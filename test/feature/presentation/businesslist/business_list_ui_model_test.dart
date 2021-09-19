import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_ui_model.dart';

void main() {
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 4.5,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category#1, category#2"],
    hours: {},
    reviews: [],
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness];

  final BusinessListUiModel fakeBusinessListUiModel = BusinessListUiModel(
    id: "id",
    name: "NAME",
    imageUrl: "imageUrl",
    ratingImage: AssetImage("assets/stars_small_4_half.png"),
    reviewCount: 1337,
    address: "address",
    priceAndCategories: "price  •  category#1, category#2",
  );
  final List<BusinessListUiModel> fakeBusinessListUiModels = [fakeBusinessListUiModel, fakeBusinessListUiModel];

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
