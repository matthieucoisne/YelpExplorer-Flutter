import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';

class GetBusinessDetailsUseCaseImpl implements GetBusinessDetailsUseCase {
  final BusinessRepository repository;

  GetBusinessDetailsUseCaseImpl(this.repository);

  @override
  Future<Business> execute(String businessId) async {
    return await repository.getBusinessDetailsWithReviews(businessId);
  }
}
