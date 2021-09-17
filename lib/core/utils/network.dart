import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/injection.dart';

// Custom Http Client used for both REST and GraphQL
// Configured to work with the Yelp API
class YelpHttpClient extends http.BaseClient {
  final http.Client client = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = "Bearer ${getIt<String>(instanceName: Const.NAMED_API_KEY)}";
    request.headers['content-type'] = "application/json";
    request.headers['accept-language'] = "en_US";
    return client.send(request);
  }
}

extension HttpClientExtension on YelpHttpClient {
  Future<T> getData<T>(String url, T Function(dynamic) fn) async {
    http.Response response;
    try {
      response = await this.get(Uri.parse(url));
      if (kDebugMode) {
        // TODO print(some info)
      }
    } finally {
      // The app is configured to use only one http client. Don't close it.
      // this.close();
    }

    if (response.statusCode == 200) {
      return fn(jsonDecode(response.body));
    } else {
      throw Exception("HTTP Error(${response.statusCode}): ${response.reasonPhrase}");
    }
  }
}

GraphQLClient getGraphQLClient(YelpHttpClient httpClient) {
  final HttpLink httpLink = HttpLink(
    Const.URL_GRAPHQL,
    httpClient: httpClient,
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}

extension GraphQLClientExtension on GraphQLClient {
  Future<QueryResult> getData(QueryOptions queryOptions) {
    if (kDebugMode) {
      // TODO print(some info)
    }
    return query(queryOptions);
  }
}
