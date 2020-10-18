import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/repository/rest/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';

class GetBusinessDetailsRestUseCase implements GetBusinessDetailsUseCase {
  final BusinessRestRepository repository;

  GetBusinessDetailsRestUseCase(this.repository);

  @override
  Future<Business> execute({@required String businessId}) async {
    Business business = await repository.getBusinessDetails(businessId);
    List<Review> reviews = await repository.getBusinessReviews(businessId);
    return business.copyWith(reviews: reviews);
  }
}
