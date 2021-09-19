import 'package:equatable/equatable.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';

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
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.address,
    required this.price,
    required this.categories,
    required this.hours,
    required this.reviews,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, reviewCount, address, price, categories, hours, reviews];

  Business copyWith({
    required List<Review> reviews,
  }) {
    return Business(
      id: this.id,
      name: this.name,
      imageUrl: this.imageUrl,
      rating: this.rating,
      reviewCount: this.reviewCount,
      address: this.address,
      price: this.price,
      categories: this.categories,
      hours: this.hours,
      reviews: reviews,
    );
  }
}
