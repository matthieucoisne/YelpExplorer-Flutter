import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';

extension ReviewListMapper on List<ReviewRestModel> {
  List<Review> toDomainModel() {
    return map((review) => review.toDomainModel()).toList();
  }
}

extension ReviewMapper on ReviewRestModel {
  Review toDomainModel() {
    final User user = User(
      name: this.user.name,
      imageUrl: this.user.imageUrl ?? "",
    );

    return Review(
      user: user,
      text: this.text,
      rating: this.rating,
      timeCreated: this.timeCreated.toString().substring(0, 10),
    );
  }
}
