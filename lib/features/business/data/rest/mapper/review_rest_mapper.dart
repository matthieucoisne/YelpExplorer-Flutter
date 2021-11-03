import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';

extension ReviewListMapper on List<ReviewRestModel> {
  List<Review> toDomainModels() {
    return map((review) => review.toDomainModel()).toList();
  }
}

extension ReviewMapper on ReviewRestModel {
  Review toDomainModel() {
    final User user = User(
      name: this.user.name,
      photoUrl: this.user.photoUrl ?? "",
    );

    return Review(
      user: user,
      text: this.text,
      rating: this.rating,
      timeCreated: this.timeCreated.substring(0, 10),
    );
  }
}
