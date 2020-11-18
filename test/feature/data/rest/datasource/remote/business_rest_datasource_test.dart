import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/injection.dart';
import 'package:yelpexplorer/features/business/data/rest/datasource/remote/business_rest_datasource.dart';
import 'package:yelpexplorer/features/business/data/rest/model/business_rest_model.dart';
import 'package:yelpexplorer/features/business/data/rest/model/review_rest_model.dart';

import '../../../../../fixture/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  BusinessRestDataSource remoteDataSource;
  MockHttpClient mockHttpClient;

  getIt.registerSingleton("fakeApiKey", instanceName: Const.NAMED_API_KEY);

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
      // Arrange
      final String filename = "rest/getBusinessList.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final BusinessListRestModel businessListDataModel = BusinessListRestModel.fromJson(json);

      // Act
      final result = await remoteDataSource.getBusinessList("term", "location", "sortBy", 20);

      // Assert
      expect(result, businessListDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );

  test(
    "should get the business details from the rest api",
    () async {
      // Arrange
      final String filename = "rest/getBusinessDetails.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final BusinessRestModel businessDataModel = BusinessRestModel.fromJson(json);

      // Act
      final result = await remoteDataSource.getBusinessDetails("businessId");

      // Assert
      expect(result, businessDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );

  test(
    "should get the business reviews from the the rest api",
    () async {
      // Arrange
      final String filename = "rest/getBusinessReviews.json";
      setUpMockHttpClientSuccess200(filename);
      final Map<String, dynamic> json = jsonDecode(fixture(filename));
      final ReviewListRestModel reviewListDataModel = ReviewListRestModel.fromJson(json);

      // Act
      final result = await remoteDataSource.getBusinessReviews("businessId");

      // Assert
      expect(result, reviewListDataModel);
      verify(mockHttpClient.get(any, headers: anyNamed("headers")));
      verifyNoMoreInteractions(mockHttpClient);
    },
  );
}
