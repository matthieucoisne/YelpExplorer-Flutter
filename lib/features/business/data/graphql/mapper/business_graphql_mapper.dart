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
    final List<String> categories = this.categories.map((category) {
      return category.title;
    }).toList();

    final Map<int, List<String>> hours = {};
    if (this.hours?.isNotEmpty == true) {
      final List<OpenGraphQLModel> openingHours = this.hours![0].opens; // Only care about regular hours, index 0
      if (openingHours.isNotEmpty) {
        final DateFormat timeParser = DateFormat("HH:mm"); // Used to be Const.PATTERN_HOUR_MINUTE. See the comment below.
        final DateFormat timeFormatter = DateFormat(Const.PATTERN_TIME);
        final Map<int, List<OpenGraphQLModel>> openingHoursPerDay = groupBy(openingHours, (openModel) => openModel.day);
        hours.addAll(openingHoursPerDay.map(
          (day, openList) => MapEntry(
            day,
            openList.map((open) {
              // For some reason, parsing "1800" with "HHmm" does not work.
              // Workaround: Inserted a ":" in between the hours and minutes and updated the pattern.
              final String start = timeFormatter
                  .format(timeParser.parse("${open.start.substring(0, 2)}:${open.start.substring(2, 4)}"))
                  .toLowerCase();
              final String end = timeFormatter
                  .format(timeParser.parse("${open.end.substring(0, 2)}:${open.end.substring(2, 4)}"))
                  .toLowerCase();
              return "$start - $end";
            }).toList(),
          ),
        ));
      }
    }

    final List<Review>? reviews = this.reviews?.map((review) {
      final User user = User(
        name: review.user.name,
        imageUrl: review.user.imageUrl ?? "",
      );
      return Review(
        user: user,
        text: review.text,
        rating: review.rating,
        timeCreated: review.timeCreated.toString().substring(0, 10),
      );
    }).toList();

    return Business(
      id: this.id,
      name: this.name,
      imageUrl: this.imageUrl,
      rating: this.rating,
      reviewCount: this.reviewCount,
      address: "${this.location.address}, ${this.location.city}",
      price: this.price ?? "",
      categories: categories,
      hours: hours,
      reviews: reviews ?? [],
    );
  }
}
