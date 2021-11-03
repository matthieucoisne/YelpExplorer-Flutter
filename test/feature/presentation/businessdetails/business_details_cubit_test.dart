import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/domain/model/review.dart';
import 'package:yelpexplorer/features/business/domain/model/user.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase.dart';
import 'package:yelpexplorer/features/business/domain/usecase/get_business_details_usecase_impl.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_cubit.dart';
import 'package:yelpexplorer/features/business/presentation/businessdetails/business_details_mapper.dart';

class MockGetBusinessDetailsUseCase extends Mock implements GetBusinessDetailsUseCaseImpl {}

void main() {
  late BusinessDetailsCubit cubit;
  late GetBusinessDetailsUseCase mockUseCase;

  final String businessId = "businessId";
  final Review fakeReview = Review(
    user: User(
      name: "name",
      photoUrl: "photoUrl",
    ),
    text: "text",
    rating: 5,
    timeCreated: "01-01-2020",
  );
  final List<Review> fakeReviews = [fakeReview, fakeReview, fakeReview, fakeReview];
  final Business fakeBusiness = Business(
    id: "id",
    name: "name",
    photoUrl: "photoUrl",
    rating: 4.5,
    reviewCount: 1337,
    address: "address",
    price: "price",
    categories: ["category"],
    hours: {},
    reviews: fakeReviews,
  );
  final String errorMessage = "error";

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
      when(() => mockUseCase.execute(any())).thenAnswer((_) async => fakeBusiness);
      return cubit;
    },
    act: (cubit) async {
      cubit.getBusinessDetails(businessId: businessId);
    },
    expect: () => [
      BusinessDetailsLoading(),
      BusinessDetailsSuccess(fakeBusiness.toUiModel()),
    ],
  );

  blocTest<BusinessDetailsCubit, BusinessDetailsState>(
    "should emit BusinessDetailsError when there is an exception",
    build: () {
      when(() => mockUseCase.execute(any())).thenThrow(Exception(errorMessage));
      return cubit;
    },
    act: (cubit) async {
      cubit.getBusinessDetails(businessId: businessId);
    },
    expect: () => [
      BusinessDetailsLoading(),
      BusinessDetailsError(Exception(errorMessage).toString()),
    ],
  );
}
