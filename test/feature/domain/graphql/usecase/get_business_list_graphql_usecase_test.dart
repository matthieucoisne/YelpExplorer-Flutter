import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';
import 'package:yelpexplorer/features/business/domain/graphql/usecase/get_business_list_graphql_usecase.dart';

class BusinessMockRepository extends Mock implements BusinessGraphQLRepository {}

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
    hours: null,
    reviews: null,
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness, fakeBusiness, fakeBusiness];

  setUp(() {
    mockRepository = BusinessMockRepository();
    usecase = GetBusinessListGraphQLUseCase(mockRepository);
  });

  test(
    "should get the business list from the GetBusinessListGraphQLUseCase",
    () async {
      // Arrange
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 20;
      when(mockRepository.getBusinessList(any, any, any, any)).thenAnswer(
        (_) async => fakeBusinesses,
      );

      // Act
      final result = await usecase.execute(
        term: term,
        location: location,
        sortBy: sortBy,
        limit: limit,
      );

      // Assert
      expect(result, fakeBusinesses);
      verify(mockRepository.getBusinessList(term, location, sortBy, limit));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
