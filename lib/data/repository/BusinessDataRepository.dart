import 'package:yelpexplorer/utils/network.dart';

class BusinessDataRepository {
  
  Future<dynamic> getBusinessList() async {
    String url = "https://api.yelp.com/v3/businesses/search?term=sushi&location=montreal&sortBy=rating&limit=10";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getData();
  }
}
