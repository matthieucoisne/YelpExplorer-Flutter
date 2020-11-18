import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;
import 'package:yelpexplorer/core/utils/injection.dart';

extension HttpClientExtension on http.Client {
  Future<T> getData<T>(String url, T Function(dynamic) fn) async {
    final String finalUrl = _getFinalUrl(url);

    if (kDebugMode) {
      print("--> GET $finalUrl");
    }

    http.Response response;
    try {
      response = await this.get(
        finalUrl,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${getIt<String>(instanceName: Const.NAMED_API_KEY)}"},
      );
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

extension GraphQLClientExtension on GraphQLClient {
  Future<QueryResult> getData(QueryOptions queryOptions) {
    if (kDebugMode) {
      print("--> GraphQL Query: ${queryOptions.documentNode.definitions[0].name.value}");
    }
    return query(queryOptions);
  }
}

http.Client getHttpClient() {
  return http.Client();
}

GraphQLClient getGraphQLClient(http.Client httpClient) {
  String finalUrl = _getFinalUrl(Const.URL_GRAPHQL);

  if (kDebugMode) {
    print("--> GraphQLClient Endpoint: $finalUrl");
  }

  final HttpLink httpLink = HttpLink(
    uri: finalUrl,
    httpClient: httpClient,
  );
  final AuthLink authLink = AuthLink(getToken: () => "Bearer ${getIt<String>(instanceName: Const.NAMED_API_KEY)}");
  final Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: InMemoryCache(),
    link: link,
  );
}

String _getFinalUrl(String url) {
  if (kIsWeb) {
    // Workaround: Yelp does not implement CORS (Cross Origin Resource Sharing)
    // more info: https://cors-anywhere.herokuapp.com/
    // https://github.com/matthieucoisne/YelpExplorer-Flutter/issues/18
    return "https://cors-anywhere.herokuapp.com/$url";
  } else {
    return url;
  }
}
