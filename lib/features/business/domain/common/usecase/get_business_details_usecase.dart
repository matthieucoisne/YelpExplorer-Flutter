import 'package:yelpexplorer/features/business/domain/common/model/business.dart';

abstract class GetBusinessDetailsUseCase {
  Future<Business> execute(String businessId);
}
