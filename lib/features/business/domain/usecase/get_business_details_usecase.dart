import 'package:yelpexplorer/features/business/domain/model/business.dart';

abstract class GetBusinessDetailsUseCase {
  Future<Business> execute(String businessId);
}
