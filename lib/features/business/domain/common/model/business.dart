import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';

class Business extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String address;
  final String price;
  final List<String> categories;
  final Map<int, List<String>> hours;
  final List<Review> reviews;

  Business({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.rating,
    @required this.reviewCount,
    @required this.address,
    @required this.price,
    @required this.categories,
    @required this.hours,
    @required this.reviews,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, reviewCount, address, price, categories, hours, reviews];

  Business copyWith({
    String id,
    String name,
    String imageUrl,
    double rating,
    int reviewCount,
    String address,
    String price,
    List<String> categories,
    String phone,
    Map<int, List<String>> hours,
    List<Review> reviews,
  }) {
    return Business(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      address: address ?? this.address,
      price: price ?? this.price,
      categories: categories ?? this.categories,
      hours: hours ?? this.hours,
      reviews: reviews ?? this.reviews,
    );
  }
}
