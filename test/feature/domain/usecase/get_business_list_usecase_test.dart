import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_list_usecase_impl.dart';

class BusinessMockRepository extends Mock implements BusinessRepository {}

void main() {
  late GetBusinessListUseCase usecase;
  late BusinessMockRepository mockRepository;

  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category"],
    hours: {},
    reviews: [],
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness, fakeBusiness, fakeBusiness];

  setUp(() {
    mockRepository = BusinessMockRepository();
    usecase = GetBusinessListUseCaseImpl(mockRepository);
  });

  test(
    "should get the business list from the GetBusinessListGraphQLUseCase",
    () async {
      // Arrange
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 20;
      when(() => mockRepository.getBusinessList(any(), any(), any(), any())).thenAnswer(
        (_) async => fakeBusinesses,
      );

      // Act
      final result = await usecase.execute(term, location, sortBy, limit);

      // Assert
      expect(result, fakeBusinesses);
      verify(() => mockRepository.getBusinessList(term, location, sortBy, limit));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
