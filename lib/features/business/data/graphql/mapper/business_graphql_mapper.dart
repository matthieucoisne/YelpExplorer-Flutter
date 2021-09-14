import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';

extension BusinessListGraphQLMapper on List<BusinessGraphQLModel> {
  List<Business> toDomainModel() {
    return map((business) => business.toDomainModel()).toList();
  }
}

extension BusinessGraphQLMapper on BusinessGraphQLModel {
  Business toDomainModel() {
    final List<String> categories = [];
    if (this.categories != null && this.categories.isNotEmpty) {
      this.categories.forEach((category) {
        if (category != null && category.title != null) {
          categories.add(category.title);
        }
      });
    }

    final Map<int, List<String>> businessHours = {};
    if (this.hours != null && this.hours.isNotEmpty) {
      final List<OpenGraphQLModel> openingHours = this.hours[0].opens;
      if (openingHours.isNotEmpty) {
        final DateFormat timeParser = DateFormat("HH:mm"); //Used to be Const.PATTERN_HOUR_MINUTE. See the comment below.
        final DateFormat timeFormatter = DateFormat(Const.PATTERN_TIME);
        final Map<int, List<OpenGraphQLModel>> openingHoursPerDay = groupBy(openingHours, (openModel) => openModel.day);
        businessHours.addAll(openingHoursPerDay.map(
          (day, openList) => MapEntry(
            day,
            openList.map((open) {
              // For some reason, parsing "1800" with "HHmm" does not work. Workaround: Inserted a ":" in between the hours and minutes and updated the pattern.
              final String start = timeFormatter.format(timeParser.parse("${open.start.substring(0, 2)}:${open.start.substring(2, 4)}")).toLowerCase();
              final String end = timeFormatter.format(timeParser.parse("${open.end.substring(0, 2)}:${open.end.substring(2, 4)}")).toLowerCase();
              return "$start - $end";
            }).toList(),
          ),
        ));
      }
    }

    final List<Review> reviews = [];
    if (this.reviews != null && this.reviews.isNotEmpty) {
      this.reviews.forEach((review) {
        final User user = User(
          name: review.user.name,
          imageUrl: review.user.imageUrl ?? "",
        );

        reviews.add(Review(
          user: user,
          text: review.text,
          rating: review.rating,
          timeCreated: review.timeCreated.toString().substring(0, 10),
        ));
      });
    }

    return Business(
      id: this.id,
      name: this.name,
      imageUrl: this.imageUrl ?? "",
      rating: this.rating ?? 0.0,
      reviewCount: this.reviewCount ?? 0,
      address: "${this.location.address}, ${this.location.city}",
      price: this.price ?? "",
      categories: categories,
      hours: businessHours,
      reviews: reviews,
    );
  }
}
