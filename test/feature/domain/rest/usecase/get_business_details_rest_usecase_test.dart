import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';
import 'package:yelpexplorer/features/business/domain/rest/usecase/get_business_details_rest_usecase.dart';

class BusinessMockRepository extends Mock implements BusinessRestRepository {}

void main() {
  GetBusinessDetailsUseCase usecase;
  BusinessMockRepository mockRepository;

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
    rating: 5.0,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category"],
    hours: null,
    reviews: fakeReviews,
  );

  setUp(() {
    mockRepository = BusinessMockRepository();
    usecase = GetBusinessDetailsRestUseCase(mockRepository);
  });

  test(
    "should get the business details from the GetBusinessDetailsRestUseCase",
    () async {
      // Arrange
      final String businessId = "businessId";
      when(mockRepository.getBusinessDetails(any)).thenAnswer(
        (_) async => fakeBusiness,
      );
      when(mockRepository.getBusinessReviews(any)).thenAnswer(
        (_) async => fakeReviews,
      );

      // Act
      final result = await usecase.execute(businessId: businessId);

      // Assert
      expect(result, fakeBusiness);
      verify(mockRepository.getBusinessDetails(businessId));
      verify(mockRepository.getBusinessReviews(businessId));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
