import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/mapper/business_rest_mapper.dart';
import 'package:yelpexplorer/features/business/data/rest/mapper/review_rest_mapper.dart';
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';

class BusinessRestDataRepository implements BusinessRestRepository {
  final BusinessRestDataSource remoteDataSource;

  BusinessRestDataRepository(this.remoteDataSource);

  @override
  Future<List<Business>> getBusinessList(String term, String location, String sortBy, int limit) async {
    // TODO add try/catch - return Resource<List<Business>>
    BusinessListRestModel response = await remoteDataSource.getBusinessList(
      term,
      location,
      sortBy,
      limit,
    );
    return response.businesses.toDomainModel();
  }

  @override
  Future<Business> getBusinessDetails(String businessId) async {
    // TODO add try/catch - return Resource<Business>
    BusinessRestModel response = await remoteDataSource.getBusinessDetails(businessId);
    return response.toDomainModel();
  }

  @override
  Future<List<Review>> getBusinessReviews(String businessId) async {
    // TODO add try/catch - return Resource<List<Review>>
    ReviewListRestModel response = await remoteDataSource.getBusinessReviews(businessId);
    return response.reviews.toDomainModel();
  }
}
