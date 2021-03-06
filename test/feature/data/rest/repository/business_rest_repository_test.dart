import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/user_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/repository/business_rest_data_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';
import 'package:yelpexplorer/features/business/domain/rest/repository/business_rest_repository.dart';

class MockBusinessRestDataSource extends Mock implements BusinessRestDataSource {}

void main() {
  BusinessRestRepository repository;
  BusinessRestDataSource mockRemoteDataSource;

  // Data
  final BusinessRestModel fakeBusinessRestModel = BusinessRestModel(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    location: LocationRestModel(address: "address", city: "city"),
    price: "price",
    categories: [CategoryRestModel(title: "category")],
    hours: [
      HourRestModel(opens: [OpenRestModel(start: "1600", end: "2300", day: 1)])
    ],
    reviews: null,
  );
  final List<BusinessRestModel> fakeBusinessRestModels = [fakeBusinessRestModel, fakeBusinessRestModel];
  final BusinessListRestModel fakeBusinessListRestModel = BusinessListRestModel(businesses: fakeBusinessRestModels);
  final ReviewRestModel fakeReviewRestModel = ReviewRestModel(
    user: UserRestModel(
      name: "name",
      imageUrl: "imageUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "2020-01-01 13:37:00",
  );
  final List<ReviewRestModel> fakeReviewRestModels = [fakeReviewRestModel, fakeReviewRestModel, fakeReviewRestModel];
  final ReviewListRestModel fakeReviewListRestModel = ReviewListRestModel(reviews: fakeReviewRestModels);

  // Domain
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    address: "address, city",
    price: "price",
    categories: ["category"],
    hours: {
      1: ["4:00 pm - 11:00 pm"]
    },
    reviews: null,
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness];
  final Review fakeReview = Review(
    user: User(
      name: "name",
      imageUrl: "imageUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "2020-01-01",
  );
  final List<Review> fakeReviews = [fakeReview, fakeReview, fakeReview];

  setUp(() {
    mockRemoteDataSource = MockBusinessRestDataSource();
    repository = BusinessRestDataRepository(mockRemoteDataSource);
  });

  test(
    "should get the business list from the rest repository",
    () async {
      // Arrange
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 20;
      when(mockRemoteDataSource.getBusinessList(any, any, any, any)).thenAnswer(
        (_) async => fakeBusinessListRestModel,
      );

      // Act
      final result = await repository.getBusinessList(term, location, sortBy, limit);

      // Assert
      expect(result, fakeBusinesses);
      verify(mockRemoteDataSource.getBusinessList(term, location, sortBy, limit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );

  test(
    "should get the business details from the rest repository",
    () async {
      // Arrange
      final String businessId = "businessId";
      when(mockRemoteDataSource.getBusinessDetails(any)).thenAnswer(
        (_) async => fakeBusinessRestModel,
      );

      // Act
      final result = await repository.getBusinessDetails(businessId);

      // Assert
      expect(result, fakeBusiness);
      verify(mockRemoteDataSource.getBusinessDetails(businessId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );

  test(
    "should get the business reviews from the rest repository",
    () async {
      // Arrange
      final String businessId = "businessId";
      when(mockRemoteDataSource.getBusinessReviews(any)).thenAnswer(
        (_) async => fakeReviewListRestModel,
      );

      // Act
      final result = await repository.getBusinessReviews(businessId);

      // Assert
      expect(result, fakeReviews);
      verify(mockRemoteDataSource.getBusinessReviews(businessId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );
}
