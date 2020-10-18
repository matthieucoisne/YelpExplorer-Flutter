import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/data/datasource/remote/rest/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/model/rest/business_data_model.dart';
import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';
import 'package:yelpexplorer/features/business/data/model/rest/user_data_model.dart';
import 'package:yelpexplorer/features/business/data/repository/rest/business_rest_data_repository.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/domain/repository/rest/business_rest_repository.dart';

class MockBusinessRestDataSource extends Mock implements BusinessRestDataSource {}

void main() {
  BusinessRestRepository repository;
  BusinessRestDataSource mockRemoteDataSource;

  // Data
  final BusinessDataModel fakeBusinessDataModel = BusinessDataModel(
    id: "id",
    name: "name",
    imageUrl: "imageUrl",
    rating: 5.0,
    reviewCount: 1337,
    location: LocationDataModel(address: "address", city: "city"),
    price: "price",
    categories: [CategoryDataModel(title: "category")],
    phone: "phone",
    hours: [
      HourDataModel(opens: [OpenDataModel(start: "1600", end: "2300", day: 1)])
    ],
    reviews: null,
  );
  final List<BusinessDataModel> fakeBusinessDataModels = [fakeBusinessDataModel, fakeBusinessDataModel];
  final BusinessListDataModel fakeBusinessListDataModel = BusinessListDataModel(businesses: fakeBusinessDataModels);
  final ReviewDataModel fakeReviewDataModel = ReviewDataModel(
    user: UserDataModel(
      name: "name",
      imageUrl: "imageUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "2020-01-01 13:37:00",
  );
  final List<ReviewDataModel> fakeReviewDataModels = [fakeReviewDataModel, fakeReviewDataModel, fakeReviewDataModel];
  final ReviewListDataModel fakeReviewListDataModel = ReviewListDataModel(reviews: fakeReviewDataModels);

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
    phone: "phone",
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
    "should get the business list from the repository",
    () async {
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 10;
      when(mockRemoteDataSource.getBusinessList(any, any, any, any)).thenAnswer((_) async => fakeBusinessListDataModel);

      final result = await repository.getBusinessList(term, location, sortBy, limit);

      expect(result, fakeBusinesses);
      verify(mockRemoteDataSource.getBusinessList(term, location, sortBy, limit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    },
  );

  test(
    "should get the business details from the repository",
    () async {
      when(mockRemoteDataSource.getBusinessDetails(any)).thenAnswer((_) async => fakeBusinessDataModel);

      final result = await repository.getBusinessDetails("businessId");

      expect(result, fakeBusiness);
    },
  );

  test(
    "should get the business reviews from the repository",
    () async {
      when(mockRemoteDataSource.getBusinessReviews(any)).thenAnswer((_) async => fakeReviewListDataModel);

      final result = await repository.getBusinessReviews("businessId");

      expect(result, fakeReviews);
    },
  );
}
