import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';

class GetBusinessListRestUseCase implements GetBusinessListUseCase {
  final BusinessRestRepository repository;

  GetBusinessListRestUseCase(this.repository);

  @override
  Future<List<Business>> execute({
    @required String term,
    @required String location,
    @required String sortBy,
    @required int limit,
  }) async {
    return await repository.getBusinessList(term, location, sortBy, limit);
  }
}
