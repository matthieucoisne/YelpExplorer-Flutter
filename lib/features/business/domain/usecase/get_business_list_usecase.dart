import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';

abstract class GetBusinessListUseCase {
  Future<List<Business>> execute({
    @required String term,
    @required String location,
    @required String sortBy,
    @required int limit,
  });
}
