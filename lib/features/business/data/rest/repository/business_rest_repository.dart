import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/mapper/business_rest_mapper.dart';
import 'package:yelpexplorer/features/business/data/rest/mapper/review_rest_mapper.dart';
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';

class BusinessRestRepository implements BusinessRepository {
  final BusinessRestDataSource remoteDataSource;

  BusinessRestRepository(this.remoteDataSource);

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
  Future<Business> getBusinessDetailsWithReviews(String businessId) async {
    // TODO add try/catch - return Resource<List<Review>>
    Future<BusinessRestModel> futureBusinessRestModel = remoteDataSource.getBusinessDetails(businessId);
    Future<ReviewListRestModel> futureReviewListRestModel = remoteDataSource.getBusinessReviews(businessId);
    BusinessRestModel businessRestModel = await futureBusinessRestModel;
    ReviewListRestModel reviewListRestModel = await futureReviewListRestModel;

    Business business = businessRestModel.toDomainModel();
    List<Review> reviews = reviewListRestModel.reviews.toDomainModel();

    return business.copyWith(reviews: reviews);
  }
}
