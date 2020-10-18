import 'package:flutter/foundation.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';

abstract class GetBusinessDetailsUseCase {
  Future<Business> execute({@required String businessId});
}
