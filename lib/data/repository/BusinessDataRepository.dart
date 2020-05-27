import 'package:yelpexplorer/domain/model/business.dart';
import 'package:yelpexplorer/utils/const.dart' as Const;
import 'package:yelpexplorer/utils/network.dart';

class BusinessDataRepository {
  Future<List<Business>> getBusinessList() async {
    String url = "${Const.URL_REST}/businesses/search?term=sushi&location=montreal&sortBy=rating&limit=10";
    dynamic json = await NetworkHelper(url).getData();

    List<Business> data = [];
    for (Map business in json["businesses"]) {
      data.add(Business.fromJson(business));
    }

    return data;
  }
}
