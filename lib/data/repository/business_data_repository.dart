import 'package:yelpexplorer/domain/model/business.dart';
import 'package:yelpexplorer/domain/model/review.dart';
import 'package:yelpexplorer/utils/const.dart' as Const;
import 'package:yelpexplorer/utils/network.dart';

class BusinessDataRepository {
  Future<List<Business>> getBusinessList() async {
    String url = "${Const.URL_REST}/businesses/search?term=sushi&location=montreal&sortBy=rating&limit=20";

    List<Business> businessList = [];
    try {
      dynamic json = await NetworkHelper(url).getData();
      for (Map business in json["businesses"]) {
        businessList.add(Business.fromJson(business, false));
      }
    } catch (e) {
      print(e);
    }

    return businessList;
  }

  Future<Business> getBusinessDetails(String businessId) async {
    String url = "${Const.URL_REST}/businesses/$businessId";
    dynamic json = await NetworkHelper(url).getData();

    Business businessDetails;
    try {
      businessDetails = Business.fromJson(json, true);
    } catch (e) {
      print(e);
    }

    return businessDetails;
  }

  Future<List<Review>> getBusinessReviews(String businessId) async {
    String url = "${Const.URL_REST}/businesses/$businessId/reviews";

    List<Review> reviews = [];
    try {
      dynamic json = await NetworkHelper(url).getData();
      for (Map review in json["reviews"]) {
        reviews.add(Review.fromJson(review));
      }
    } catch (e) {
      print(e);
    }

    return reviews;
  }
}
