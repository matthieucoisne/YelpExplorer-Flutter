import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/network.dart';
import 'package:yelpexplorer/features/business/data/model/rest/business_data_model.dart';
import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';

class BusinessRestDataSource {
  final http.Client client;

  BusinessRestDataSource(this.client);

  Future<BusinessListDataModel> getBusinessList(String term, String location, String sortBy, int limit) {
    final String url = "${Const.URL_REST}/businesses/search?term=$term&location=$location&sortBy=$sortBy&limit=$limit";
    return client.getData(url, (json) => BusinessListDataModel.fromJson(json));
  }

  Future<BusinessDataModel> getBusinessDetails(String businessId) {
    String url = "${Const.URL_REST}/businesses/$businessId";
    return client.getData(url, (json) => BusinessDataModel.fromJson(json));
  }

  Future<ReviewListDataModel> getBusinessReviews(String businessId) {
    String url = "${Const.URL_REST}/businesses/$businessId/reviews";
    return client.getData(url, (json) => ReviewListDataModel.fromJson(json));
  }
}
