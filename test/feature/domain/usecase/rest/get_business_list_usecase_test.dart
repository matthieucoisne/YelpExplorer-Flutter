import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/repository/rest/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/rest/get_business_list_rest_usecase.dart';

class BusinessMockRepository extends Mock implements BusinessRestRepository {}

void main() {
  GetBusinessListUseCase usecase;
  BusinessMockRepository mockRepository;
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category"],
    phone: "phone",
    hours: null,
    reviews: null,
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness, fakeBusiness, fakeBusiness];

  setUp(() {
    mockRepository = BusinessMockRepository();
    usecase = GetBusinessListRestUseCase(mockRepository);
  });

  test(
    "should get the business list from the repository",
    () async {
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 10;
      when(mockRepository.getBusinessList(any, any, any, any)).thenAnswer((_) async => fakeBusinesses);

      final result = await usecase.execute(
        term: term,
        location: location,
        sortBy: sortBy,
        limit: limit,
      );

      expect(result, fakeBusinesses);
      verify(mockRepository.getBusinessList(term, location, sortBy, limit));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
