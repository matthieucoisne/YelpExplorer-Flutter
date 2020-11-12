import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';

class GetBusinessListGraphQLUseCase implements GetBusinessListUseCase {
  final BusinessGraphQLRepository repository;

  GetBusinessListGraphQLUseCase(this.repository);

  @override
  Future<List<Business>> execute(
    String term,
    String location,
    String sortBy,
    int limit,
  ) async {
    return await repository.getBusinessList(term, location, sortBy, limit);
  }
}
