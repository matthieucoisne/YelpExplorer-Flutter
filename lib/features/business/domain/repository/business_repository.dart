import 'package:yelpexplorer/features/business/domain/model/business.dart';

abstract class BusinessRepository {
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit);
  Future<Business> getBusinessDetailsWithReviews(String businessId);
}
