import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';

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
