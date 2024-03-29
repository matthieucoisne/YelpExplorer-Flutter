import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yelpexplorer/features/business/data/graphql/datasource/remote/business_graphql_datasource.dart';
import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';

import '../../../../../fixture/fixture_reader.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

void main() {
  late BusinessGraphQLDataSource remoteDataSource;
  late MockGraphQLClient mockGraphQLClient;

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    remoteDataSource = BusinessGraphQLDataSource(mockGraphQLClient);
  });

  setUpAll(() {
    registerFallbackValue(QueryOptions(document: gql("query Mocktail {}")));
  });

  test(
    "should get the business list from the graphql api",
    () async {
      // Arrange
      final String term = "sushi";
      final String location = "montreal";
      final String sortBy = "rating";
      final int limit = 20;
      final QueryOptions expectedQueryOptions = QueryOptions(
        document: Queries.businessListQuery,
        variables: {
          "term": term,
          "location": location,
          "sortBy": sortBy,
          "limit": limit,
        },
      );
      final Map<String, dynamic> json = jsonDecode(fixture("graphql/getBusinessList.json"))["data"];
      when(() => mockGraphQLClient.query(any())).thenAnswer(
        (_) async => QueryResult(options: expectedQueryOptions, source: QueryResultSource.network, data: json),
      );
      final BusinessListGraphQLModel businessListDataModel = BusinessListGraphQLModel.fromJson(json);

      // Act
      final result = await remoteDataSource.getBusinessList(term, location, sortBy, limit);

      // Assert
      QueryOptions actualQueryOption = verify(() => mockGraphQLClient.query(captureAny())).captured.first as QueryOptions;
      expect(actualQueryOption.document, expectedQueryOptions.document);
      expect(actualQueryOption.variables, expectedQueryOptions.variables);
      expect(result, businessListDataModel);
      verifyNoMoreInteractions(mockGraphQLClient);
    },
  );

  test(
    "should get the business details from the graphql api",
    () async {
      // Arrange
      final String businessId = "businessId";
      final QueryOptions expectedQueryOptions = QueryOptions(
        document: Queries.businessDetailsQuery,
        variables: {
          "id": businessId,
        },
      );
      final Map<String, dynamic> json = jsonDecode(fixture("graphql/getBusinessDetails.json"))["data"];
      when(() => mockGraphQLClient.query(any())).thenAnswer(
        (_) async => QueryResult(options: expectedQueryOptions, source: QueryResultSource.network, data: json),
      );
      final BusinessDetailsGraphQLModel businessDetailsDataModel = BusinessDetailsGraphQLModel.fromJson(json);

      // Act
      final result = await remoteDataSource.getBusinessDetailsWithReviews(businessId);

      // Assert
      QueryOptions actualQueryOption = verify(() => mockGraphQLClient.query(captureAny())).captured.first as QueryOptions;
      expect(actualQueryOption.document, expectedQueryOptions.document);
      expect(actualQueryOption.variables, expectedQueryOptions.variables);
      expect(result, businessDetailsDataModel);
      verifyNoMoreInteractions(mockGraphQLClient);
    },
  );
}
