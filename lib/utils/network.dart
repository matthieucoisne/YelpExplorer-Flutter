import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:yelpexplorer/utils/const.dart' as Const;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer ${Const.API_KEY}"
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
