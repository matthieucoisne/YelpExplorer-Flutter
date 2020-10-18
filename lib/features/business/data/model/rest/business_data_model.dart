import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';

class BusinessListDataModel extends Equatable {
  final List<BusinessDataModel> businesses;

  BusinessListDataModel({
    @required this.businesses,
  });

  @override
  List<Object> get props => [businesses];

  factory BusinessListDataModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonBusinesses = json["businesses"];
    final List<BusinessDataModel> businesses = jsonBusinesses.map((jsonBusiness) {
      return BusinessDataModel.fromJson(jsonBusiness);
    }).toList();

    return BusinessListDataModel(
      businesses: businesses,
    );
  }
}

class BusinessDataModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int reviewCount;
  final List<CategoryDataModel> categories;
  final double rating;
  final String price;
  final LocationDataModel location;
  final String phone;
  final List<HourDataModel> hours;
  final List<ReviewDataModel> reviews;

  BusinessDataModel({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.reviewCount,
    @required this.categories,
    @required this.rating,
    @required this.price,
    @required this.location,
    @required this.phone,
    @required this.hours,
    @required this.reviews,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, reviewCount, location, price, categories, phone, hours, reviews];

  factory BusinessDataModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonCategories = json["categories"];
    final List<CategoryDataModel> categories = jsonCategories.map((jsonCategory) {
      return CategoryDataModel.fromJson(jsonCategory);
    }).toList();

    final List<HourDataModel> hours = [];
    final List<dynamic> jsonHours = json["hours"];
    if (jsonHours != null && jsonHours.isNotEmpty) {
      hours.add(HourDataModel.fromJson(jsonHours[0]));
    }
    return BusinessDataModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["image_url"],
      reviewCount: json["review_count"],
      categories: categories,
      rating: json["rating"],
      price: json["price"],
      location: LocationDataModel.fromJson(json["location"]),
      phone: json["phone"],
      hours: hours,
      reviews: null,
    );
  }
}

class CategoryDataModel extends Equatable {
  final String title;

  CategoryDataModel({
    @required this.title,
  });

  @override
  List<Object> get props => [title];

  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    return CategoryDataModel(
      title: json["title"],
    );
  }
}

class LocationDataModel extends Equatable {
  final String address;
  final String city;

  LocationDataModel({
    @required this.address,
    @required this.city,
  });

  @override
  List<Object> get props => [address, city];

  factory LocationDataModel.fromJson(Map<String, dynamic> json) {
    return LocationDataModel(
      address: json["address1"],
      city: json["city"],
    );
  }
}

class HourDataModel extends Equatable {
  final List<OpenDataModel> opens;

  HourDataModel({
    @required this.opens,
  });

  @override
  List<Object> get props => [opens];

  factory HourDataModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonOpens = json["open"];
    final List<OpenDataModel> opens = jsonOpens.map((jsonOpen) {
      return OpenDataModel.fromJson(jsonOpen);
    }).toList();

    return HourDataModel(
      opens: opens,
    );
  }
}

class OpenDataModel extends Equatable {
  final String start;
  final String end;
  final int day;

  OpenDataModel({
    @required this.start,
    @required this.end,
    @required this.day,
  });

  @override
  List<Object> get props => [start, end, day];

  factory OpenDataModel.fromJson(Map<String, dynamic> json) {
    return OpenDataModel(
      start: json["start"],
      end: json["end"],
      day: json["day"],
    );
  }
}
