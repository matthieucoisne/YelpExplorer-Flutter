import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/features/business/data/datasource/remote/rest/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/model/rest/business_data_model.dart';
import 'package:yelpexplorer/features/business/data/model/rest/review_data_model.dart';

import '../../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  BusinessRestDataSource remoteDataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = BusinessRestDataSource(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String filename) {
    when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response(fixture(filename), 200),
    );
  }

  // TODO
  void setUpMockHttpClientFailure500() {
    when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response("Something went wrong", 500),
    );
  }

  test(
    "should get the business list from the rest api",
    () async {
      final String filename = "getBusinessList.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final BusinessListDataModel businessListDataModel = BusinessListDataModel.fromJson(json);

      final result = await remoteDataSource.getBusinessList("term", "location", "sortBy", 10);

      expect(result, businessListDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );

  test(
    "should get the business details from the rest api",
    () async {
      final String filename = "getBusinessDetails.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final BusinessDataModel businessDataModel = BusinessDataModel.fromJson(json);

      final result = await remoteDataSource.getBusinessDetails("businessId");

      expect(result, businessDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );

  test(
    "should get the business reviews from the the rest api",
    () async {
      final String filename = "getBusinessReviews.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final ReviewListDataModel reviewListDataModel = ReviewListDataModel.fromJson(json);

      final result = await remoteDataSource.getBusinessReviews("businessId");

      expect(result, reviewListDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );
}
