import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yelpexplorer/core/utils/const.dart' as Const;

extension NetworkExtension on http.Client {
  Future<T> getData<T>(String url, T Function(dynamic) fn) async {
    http.Response response;
    try {
      response = await this.get(
        url,
        headers: {HttpHeaders.authorizationHeader: "Bearer ${Const.API_KEY}"},
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
