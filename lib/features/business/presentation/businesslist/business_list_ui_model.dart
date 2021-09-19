import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/presentation/helper/business_helper.dart' as BusinessHelper;

extension BusinessListUiMapper on List<Business> {
  List<BusinessListUiModel> toUiModels() {
    return map(
      (business) => BusinessListUiModel(
        id: business.id,
        name: business.name.toUpperCase(),
        imageUrl: business.imageUrl,
        ratingImage: BusinessHelper.getRatingImage(business.rating),
        reviewCount: business.reviewCount,
        address: business.address,
        priceAndCategories: BusinessHelper.formatPriceAndCategories(business.price, business.categories),
      ),
    ).toList();
  }
}

class BusinessListUiModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final AssetImage ratingImage;
  final int reviewCount;
  final String address;
  final String priceAndCategories;

  BusinessListUiModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ratingImage,
    required this.reviewCount,
    required this.address,
    required this.priceAndCategories,
  });

  @override
  List<Object> get props => [id, name, imageUrl, ratingImage, reviewCount, address, priceAndCategories];
}
