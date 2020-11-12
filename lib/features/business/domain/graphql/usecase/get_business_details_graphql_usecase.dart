import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';

class GetBusinessDetailsGraphQLUseCase implements GetBusinessDetailsUseCase {
  final BusinessGraphQLRepository repository;

  GetBusinessDetailsGraphQLUseCase(this.repository);

  @override
  Future<Business> execute(String businessId) async {
    return await repository.getBusinessDetails(businessId);
  }
}
