import 'package:yelpexplorer/features/business/data/datasource/remote/rest/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/mapper/rest/business_mapper.dart';
import 'package:yelpexplorer/features/business/data/mapper/rest/review_mapper.dart';
import 'package:yelpexplorer/features/business/data/model/rest/business_data_model.dart';
import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/repository/rest/business_rest_repository.dart';

class BusinessRestDataRepository implements BusinessRestRepository {
  final BusinessRestDataSource remoteDataSource;

  BusinessRestDataRepository(this.remoteDataSource);

  @override
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit) async {
    BusinessListDataModel response = await remoteDataSource.getBusinessList(
      term,
      location,
      sortBy,
      limit,
    );
    return response.businesses.toDomainModel();
  }

  @override
  Future<Business> getBusinessDetails(String businessId) async {
    BusinessDataModel response = await remoteDataSource.getBusinessDetails(businessId);
    return response.toDomainModel();
  }

  @override
  Future<List<Review>> getBusinessReviews(String businessId) async {
    ReviewListDataModel response = await remoteDataSource.getBusinessReviews(businessId);
    return response.reviews.toDomainModel();
  }
}
