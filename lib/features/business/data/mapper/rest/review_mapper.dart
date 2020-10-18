import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';

extension ReviewListMapper on List<ReviewDataModel> {
  List<Review> toDomainModel() {
    return map((review) => review.toDomainModel()).toList();
  }
}

extension ReviewMapper on ReviewDataModel {
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
