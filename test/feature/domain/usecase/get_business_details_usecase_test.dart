import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/domain/repository/business_repository.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase_impl.dart';

class BusinessMockRepository extends Mock implements BusinessRepository {}

void main() {
  late GetBusinessDetailsUseCase usecase;
  late BusinessMockRepository mockRepository;

  final Review fakeReview = Review(
    user: User(
      name: "name",
      imageUrl: "imageUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "01-01-2020",
  );
  final List<Review> fakeReviews = [fakeReview, fakeReview, fakeReview, fakeReview];
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 4.5,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category"],
    hours: {},
    reviews: fakeReviews,
  );

  setUp(() {
    mockRepository = BusinessMockRepository();
    usecase = GetBusinessDetailsUseCaseImpl(mockRepository);
  });

  test(
    "should get the business details from the GetBusinessDetailsGraphQLUseCase",
    () async {
      // Arrange
      final String businessId = "businessId";
      when(() => mockRepository.getBusinessDetailsWithReviews(any())).thenAnswer(
        (_) async => fakeBusiness,
      );

      // Act
      final result = await usecase.execute(businessId);

      // Assert
      expect(result, fakeBusiness);
      verify(() => mockRepository.getBusinessDetailsWithReviews(businessId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
