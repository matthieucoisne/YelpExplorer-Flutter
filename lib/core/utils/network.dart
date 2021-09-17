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
    final String finalUrl = _getFinalUrl(url);

    if (kDebugMode) {
      print("--> GET $finalUrl");
    }

    http.Response response;
    try {
      response = await this.get(Uri.parse(finalUrl));
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
  String finalUrl = _getFinalUrl(Const.URL_GRAPHQL);

  if (kDebugMode) {
    print("--> GraphQLClient Endpoint: $finalUrl");
  }

  final HttpLink httpLink = HttpLink(
    finalUrl,
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
