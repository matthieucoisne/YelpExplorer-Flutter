import "package:yelpexplorer/domain/model/review.dart";

class Business {
  String id;
  String name;
  String photoUrl;
  double rating;
  int reviewCount;
  String address;
  String price;
  List<String> categories;
  String phone;
  Map<int, List<String>> hours;
  List<Review> reviews;

  Business(
    this.id,
    this.name,
    this.photoUrl,
    this.rating,
    this.reviewCount,
    this.address,
    this.price,
    this.categories,
    this.phone,
    this.hours,
    this.reviews,
  );

  Business.fromJson(Map<String, dynamic> json) {
    List<String> categoryList = [];
    for (var category in json["categories"]) {
      categoryList.add(category["title"]);
    }

    Business(
      id = json["id"],
      name = json["name"],
      photoUrl = json["image_url"],
      rating = json["rating"],
      reviewCount = json["review_count"],
      address = json["location"]["address1"] + ", " + json["location"]["city"],
      price = json["price"] ?? "",
      categories = categoryList,
      phone = json["phone"],
      hours = null,
      reviews = null,
    );
  }
}
