import 'package:yelpexplorer/features/business/domain/common/model/business.dart';

abstract class BusinessGraphQLRepository {
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit);
  Future<Business> getBusinessDetails(String businessId);
}
