import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/domain/common/model/business.dart';
import 'package:yelpexplorer/features/business/domain/common/usecase/get_business_list_usecase.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_bloc.dart';

class MockGetBusinessListUseCase extends Mock implements GetBusinessListUseCase {}

void main() {
  BusinessListBloc bloc;
  GetBusinessListUseCase mockUseCase;

  final String term = "sushi";
  final String location = "montreal";
  final String sortBy = "rating";
  final int limit = 20;
  final String errorMessage = "error";

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
    mockUseCase = MockGetBusinessListUseCase();
    bloc = BusinessListBloc(mockUseCase);
  });

  test(
    "initial state should be BusinessListLoading",
    () async {
      expect(bloc.state, BusinessListLoading());
    },
  );

  blocTest<BusinessListBloc, BusinessListState>(
    "should yield BusinessListSuccess in response to a GetBusinessList event",
    build: () {
      when(mockUseCase.execute(any, any, any, any)).thenAnswer((_) async => fakeBusinesses);
      return bloc;
    },
    act: (bloc) async {
      bloc.add(GetBusinessList(
        term: term,
        location: location,
        sortBy: sortBy,
        limit: limit,
      ));
    },
    expect: [
      BusinessListLoading(),
      BusinessListSuccess(fakeBusinesses),
    ],
  );

  blocTest<BusinessListBloc, BusinessListState>(
    "should yield BusinessListError when there is an exception",
    build: () {
      when(mockUseCase.execute(any, any, any, any)).thenThrow(Exception(errorMessage));
      return bloc;
    },
    act: (bloc) async {
      bloc.add(GetBusinessList(
        term: term,
        location: location,
        sortBy: sortBy,
        limit: limit,
      ));
    },
    expect: [
      BusinessListLoading(),
      BusinessListError(Exception(errorMessage).toString()),
    ],
  );
}
