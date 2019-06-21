import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'feed.dart';

class Webservice {
  static String baseUrl = "http://localhost:8050";
  Future<List<Map>> fetchFeed() async {
    Map body = new Map();
    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    final response = await http.post(baseUrl+"/travelful/feed", body: "{}" , headers: {
      "Content-Type": "application/json"
    },);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List list = (json.decode(response.body) as List)
          .map((data) => new Feed.fromJson(data))
          .toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
