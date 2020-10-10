import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import "package:yelpexplorer/domain/model/review.dart";
import 'package:yelpexplorer/utils/const.dart' as Const;

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

  factory Business.fromJson(Map<String, dynamic> json, bool detailed) {
    final List<dynamic> jsonCategories = json["categories"];
    final List<String> categories = jsonCategories.map((jsonCategory) => Category.fromJson(jsonCategory).title).toList();

    Map<int, List<String>> businessHours = {};
    List<Review> businessReviews = [];
    if (detailed) {
      final List<dynamic> jsonHours = json["hours"];
      if (jsonHours != null && jsonHours.isNotEmpty) {
        final List<dynamic> jsonOpeningHours = jsonHours[0]["open"];
        final List<Open> openingHours = jsonOpeningHours.map((jsonOpeningHour) => Open.fromJson(jsonOpeningHour)).toList();
        if (openingHours.isNotEmpty) {
          final DateFormat timeParser = DateFormat("HH:mm"); //Used to be Const.PATTERN_HOUR_MINUTE. See the comment below.
          final DateFormat timeFormatter = DateFormat(Const.PATTERN_TIME);

          final Map<int, List<Open>> openingHoursPerDay = groupBy(openingHours, (open) => open.day);
          businessHours = openingHoursPerDay.map(
            (day, openList) => MapEntry(
              day,
              openList.map((open) {
                // For some reason, parsing "1800" with "HHmm" does not work. Workaround: Inserted a ":" in between the hours and minutes and updated the pattern.
                final String start = timeFormatter.format(timeParser.parse("${open.start.substring(0, 2)}:${open.start.substring(2, 4)}")).toLowerCase();
                final String end = timeFormatter.format(timeParser.parse("${open.end.substring(0, 2)}:${open.end.substring(2, 4)}")).toLowerCase();
                return "$start - $end";
              }).toList(),
            ),
          );
        }
      }
    }

    return Business(
      json["id"],
      json["name"],
      json["image_url"],
      json["rating"] ?? 0.0,
      json["review_count"] ?? 0,
      json["location"]["address1"] + ", " + json["location"]["city"],
      json["price"] ?? "",
      categories,
      json["phone"],
      businessHours,
      businessReviews,
    );
  }
}

class Category {
  String title;

  Category(
    this.title,
  );

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json["title"],
    );
  }
}

class Open {
  String start;
  String end;
  int day;

  Open(
    this.start,
    this.end,
    this.day,
  );

  factory Open.fromJson(Map<String, dynamic> json) {
    return Open(
      json["start"],
      json["end"],
      json["day"],
    );
  }
}
