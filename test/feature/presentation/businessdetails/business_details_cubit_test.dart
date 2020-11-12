import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/model/review.dart';
import 'package:yelpexplorer/features/business/domain/common/model/user.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';

class MockGetBusinessDetailsUseCase extends Mock implements GetBusinessDetailsUseCase {}

void main() {
  BusinessDetailsCubit cubit;
  GetBusinessDetailsUseCase mockUseCase;

  final String businessId = "businessId";
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
    mockUseCase = MockGetBusinessDetailsUseCase();
    cubit = BusinessDetailsCubit(mockUseCase);
  });

  test(
    "initial state should be BusinessDetailsLoading",
    () async {
      expect(cubit.state, BusinessDetailsLoading());
    },
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    "should emit BusinessDetailsSuccess in response to calling GetBusinessDetails",
    build: () {
      when(mockUseCase.execute(any)).thenAnswer((_) async => fakeBusiness);
      return cubit;
    },
    act: (cubit) async {
      cubit.getBusinessDetails(businessId: businessId);
    },
    expect: [
      BusinessDetailsLoading(),
      BusinessDetailsSuccess(fakeBusiness),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    "should emit BusinessDetailsError when there is an exception",
    build: () {
      when(mockUseCase.execute(any)).thenThrow(Exception());
      return cubit;
    },
    act: (cubit) async {
      cubit.getBusinessDetails(businessId: businessId);
    },
    expect: [
      BusinessDetailsLoading(),
      BusinessDetailsError("ERROR"),
    ],
  );
}
