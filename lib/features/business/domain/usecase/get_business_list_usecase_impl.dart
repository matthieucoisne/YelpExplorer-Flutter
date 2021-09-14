import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';

class GetBusinessListUseCaseImpl implements GetBusinessListUseCase {
  final BusinessRepository repository;

  GetBusinessListUseCaseImpl(this.repository);

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
