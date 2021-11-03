import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_ui_model.dart';
import 'package:yelpexplorer/features/business/presentation/helper/business_helper.dart' as BusinessHelper;

extension BusinessDetailUiMapper on Business {
  BusinessDetailsUiModel toUiModel() {
    return BusinessDetailsUiModel(
      id: this.id,
      name: this.name.toUpperCase(),
      photoUrl: this.photoUrl,
      ratingImage: BusinessHelper.getRatingImage(this.rating),
      reviewCount: this.reviewCount,
      address: this.address,
      priceAndCategories: BusinessHelper.formatPriceAndCategories(this.price, this.categories),
      hours: this.hours,
      reviews: this.reviews.toUiModel(),
    );
  }
}

extension ReviewUiMapper on List<Review> {
  List<ReviewUiModel> toUiModel() {
    return map(
      (review) => ReviewUiModel(
        user: review.user.toUiModel(),
        text: review.text,
        ratingImage: BusinessHelper.getRatingImage(review.rating),
        timeCreated: review.timeCreated,
      ),
    ).toList();
  }
}

extension UserUiMapper on User {
  UserUiModel toUiModel() {
    return UserUiModel(
      name: this.name,
      photoUrl: this.photoUrl,
    );
  }
}
