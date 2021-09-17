import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/review_graphql_model.dart';

class BusinessListGraphQLModel extends Equatable {
  final List<BusinessGraphQLModel> businesses;

  BusinessListGraphQLModel({
    @required this.businesses,
  });

  @override
  List<Object> get props => [businesses];

  factory BusinessListGraphQLModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonBusinesses = json["search"]["business"];
    final List<BusinessGraphQLModel> businesses = jsonBusinesses.map((jsonBusiness) {
      return BusinessGraphQLModel.fromJson(jsonBusiness);
    }).toList();

    return BusinessListGraphQLModel(
      businesses: businesses,
    );
  }
}

class BusinessDetailsGraphQLModel extends Equatable {
  final BusinessGraphQLModel business;

  BusinessDetailsGraphQLModel({
    @required this.business,
  });

  @override
  List<Object> get props => [business];

  factory BusinessDetailsGraphQLModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> jsonBusiness = json["business"];
    return BusinessDetailsGraphQLModel(
      business: BusinessGraphQLModel.fromJson(jsonBusiness),
    );
  }
}

class BusinessGraphQLModel extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int reviewCount;
  final List<CategoryGraphQLModel> categories;
  final double rating;
  final String price;
  final LocationGraphQLModel location;
  final List<HourGraphQLModel> hours;
  final List<ReviewGraphQLModel> reviews;

  BusinessGraphQLModel({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.reviewCount,
    @required this.categories,
    @required this.rating,
    @required this.price,
    @required this.location,
    @required this.hours,
    @required this.reviews,
  });

  @override
  List<Object> get props => [id, name, imageUrl, rating, reviewCount, location, price, categories, hours, reviews];

  factory BusinessGraphQLModel.fromJson(Map<String, dynamic> json) {
    final List<CategoryGraphQLModel> categories = [];
    final List<dynamic> jsonCategories = json["categories"];
    if (jsonCategories != null && jsonCategories.isNotEmpty) {
      jsonCategories.forEach((jsonCategory) {
        categories.add(CategoryGraphQLModel.fromJson(jsonCategory));
      });
    }

    final List<HourGraphQLModel> hours = [];
    final List<dynamic> jsonHours = json["hours"];
    if (jsonHours != null && jsonHours.isNotEmpty) {
      hours.add(HourGraphQLModel.fromJson(jsonHours[0]));
    }

    final List<ReviewGraphQLModel> reviews = [];
    final List<dynamic> jsonReviews = json["reviews"];
    if (jsonReviews != null && jsonReviews.isNotEmpty) {
      jsonReviews.forEach((jsonReview) {
        reviews.add(ReviewGraphQLModel.fromJson(jsonReview));
      });
    }

    return BusinessGraphQLModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["photos"][0],
      reviewCount: json["review_count"],
      categories: categories,
      rating: json["rating"].toDouble(),
      price: json["price"],
      location: LocationGraphQLModel.fromJson(json["location"]),
      hours: hours,
      reviews: reviews,
    );
  }
}

class CategoryGraphQLModel extends Equatable {
  final String title;

  CategoryGraphQLModel({
    @required this.title,
  });

  @override
  List<Object> get props => [title];

  factory CategoryGraphQLModel.fromJson(Map<String, dynamic> json) {
    return CategoryGraphQLModel(
      title: json["title"],
    );
  }
}

class LocationGraphQLModel extends Equatable {
  final String address;
  final String city;

  LocationGraphQLModel({
    @required this.address,
    @required this.city,
  });

  @override
  List<Object> get props => [address, city];

  factory LocationGraphQLModel.fromJson(Map<String, dynamic> json) {
    return LocationGraphQLModel(
      address: json["address1"],
      city: json["city"],
    );
  }
}

class HourGraphQLModel extends Equatable {
  final List<OpenGraphQLModel> opens;

  HourGraphQLModel({
    @required this.opens,
  });

  @override
  List<Object> get props => [opens];

  factory HourGraphQLModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonOpens = json["open"];
    final List<OpenGraphQLModel> opens = jsonOpens.map((jsonOpen) {
      return OpenGraphQLModel.fromJson(jsonOpen);
    }).toList();

    return HourGraphQLModel(
      opens: opens,
    );
  }
}

class OpenGraphQLModel extends Equatable {
  final String start;
  final String end;
  final int day;

  OpenGraphQLModel({
    @required this.start,
    @required this.end,
    @required this.day,
  });

  @override
  List<Object> get props => [start, end, day];

  factory OpenGraphQLModel.fromJson(Map<String, dynamic> json) {
    return OpenGraphQLModel(
      start: json["start"],
      end: json["end"],
      day: json["day"],
    );
  }
}
