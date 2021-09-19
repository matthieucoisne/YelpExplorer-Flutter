import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';

extension BusinessListRestMapper on List<BusinessRestModel> {
  List<Business> toDomainModel() {
    return map((business) => business.toDomainModel()).toList();
  }
}

extension BusinessMapper on BusinessRestModel {
  Business toDomainModel() {
    final List<String> categories = this.categories.map((category) {
      return category.title;
    }).toList();

    final Map<int, List<String>> businessHours = {};
    if (this.hours?.isNotEmpty == true) {
      final List<OpenRestModel> openingHours = this.hours![0].opens; // Only care about regular hours, index 0
      if (openingHours.isNotEmpty) {
        final DateFormat timeParser = DateFormat("HH:mm"); // Used to be Const.PATTERN_HOUR_MINUTE. See the comment below.
        final DateFormat timeFormatter = DateFormat(Const.PATTERN_TIME);
        final Map<int, List<OpenRestModel>> openingHoursPerDay = groupBy(openingHours, (openModel) => openModel.day);
        businessHours.addAll(openingHoursPerDay.map(
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

    return Business(
      id: this.id,
      name: this.name,
      imageUrl: this.imageUrl,
      rating: this.rating,
      reviewCount: this.reviewCount,
      address: "${this.location.address}, ${this.location.city}",
      price: this.price ?? "",
      categories: categories,
      hours: businessHours,
      reviews: [],
    );
  }
}
