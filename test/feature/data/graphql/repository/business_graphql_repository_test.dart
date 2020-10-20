import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/review_graphql_model.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/user_graphql_model.dart';
import 'package:yelpexplorer/features/business/data/graphql/repository/business_graphql_data_repository.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';
import 'package:yelpexplorer/features/business/domain/graphql/repository/business_graphql_repository.dart';

class MockBusinessGraphQLDataSource extends Mock implements BusinessGraphQLDataSource {}

void main() {
  BusinessGraphQLRepository repository;
  BusinessGraphQLDataSource mockRemoteDataSource;

  // Data
  final ReviewGraphQLModel fakeReviewGraphQLModel = ReviewGraphQLModel(
    user: UserGraphQLModel(
      name: "name",
      imageUrl: "imageUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "2020-01-01 13:37:00",
  );
  final List<ReviewGraphQLModel> fakeReviewGraphQLModels = [fakeReviewGraphQLModel, fakeReviewGraphQLModel, fakeReviewGraphQLModel];
  final BusinessGraphQLModel fakeBusinessGraphQLModel = BusinessGraphQLModel(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    location: LocationGraphQLModel(address: "address", city: "city"),
    price: "price",
    categories: [CategoryGraphQLModel(title: "category")],
    hours: [
      HourGraphQLModel(opens: [OpenGraphQLModel(start: "1600", end: "2300", day: 1)])
    ],
    reviews: fakeReviewGraphQLModels,
  );
  final List<BusinessGraphQLModel> fakeBusinessGraphQLModels = [fakeBusinessGraphQLModel, fakeBusinessGraphQLModel];
  final BusinessListGraphQLModel fakeBusinessListGraphQLModel = BusinessListGraphQLModel(businesses: fakeBusinessGraphQLModels);
  final BusinessDetailsGraphQLModel fakeBusinessDetailsGraphQLModel = BusinessDetailsGraphQLModel(business: fakeBusinessGraphQLModel);

  // Domain
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
    reviews: fakeReviews,
  );
  final List<Business> fakeBusinesses = [fakeBusiness, fakeBusiness];

  setUp(() {
    mockRemoteDataSource = MockBusinessGraphQLDataSource();
    repository = BusinessGraphQLDataRepository(mockRemoteDataSource);
  });

  test(
    "should get the business list from the graphql repository",
    () async {
      // Arrange
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 10;
      when(mockRemoteDataSource.getBusinessList(any, any, any, any)).thenAnswer(
        (_) async => fakeBusinessListGraphQLModel,
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
    "should get the business details from the graphql repository",
    () async {
      // Arrange
      final String businessId = "businessId";
      when(mockRemoteDataSource.getBusinessDetails(any)).thenAnswer(
        (_) async => fakeBusinessDetailsGraphQLModel,
      );

      // Act
      final result = await repository.getBusinessDetails(businessId);

      // Assert
      expect(result, fakeBusiness);
      verify(mockRemoteDataSource.getBusinessDetails(businessId));
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );
}
