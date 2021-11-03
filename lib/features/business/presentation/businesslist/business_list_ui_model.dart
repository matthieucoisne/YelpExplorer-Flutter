import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BusinessListUiModel extends Equatable {
  final String id;
  final String name;
  final String photoUrl;
  final AssetImage ratingImage;
  final String reviewCount;
  final String address;
  final String priceAndCategories;

  BusinessListUiModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.ratingImage,
    required this.reviewCount,
    required this.address,
    required this.priceAndCategories,
  });

  @override
  List<Object> get props => [id, name, photoUrl, ratingImage, reviewCount, address, priceAndCategories];
}
