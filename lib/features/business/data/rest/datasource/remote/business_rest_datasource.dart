import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/network.dart';
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';

class BusinessRestDataSource {
  final http.Client client;

  BusinessRestDataSource(this.client);

  Future<BusinessListRestModel> getBusinessList(String term, String location, String sortBy, int limit) {
    // TODO add try/catch
    final String url = "${Const.URL_REST}/businesses/search?term=$term&location=$location&sortBy=$sortBy&limit=$limit";
    return client.getData(url, (json) => BusinessListRestModel.fromJson(json));
  }

  Future<BusinessRestModel> getBusinessDetails(String businessId) {
    // TODO add try/catch
    String url = "${Const.URL_REST}/businesses/$businessId";
    return client.getData(url, (json) => BusinessRestModel.fromJson(json));
  }

  Future<ReviewListRestModel> getBusinessReviews(String businessId) {
    // TODO add try/catch
    String url = "${Const.URL_REST}/businesses/$businessId/reviews";
    return client.getData(url, (json) => ReviewListRestModel.fromJson(json));
  }
}
