import 'package:yelpexplorer/features/business/domain/common/model/business.dart';

abstract class GetBusinessListUseCase {
  Future<List<Business>> execute(
    String term,
    String location,
    String sortBy,
    int limit,
  );
}
