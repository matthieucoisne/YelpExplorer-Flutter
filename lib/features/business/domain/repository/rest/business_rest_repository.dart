import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';

abstract class BusinessRestRepository {
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit);
  Future<Business> getBusinessDetails(String businessId);
  Future<List<Review>> getBusinessReviews(String businessId);
}
