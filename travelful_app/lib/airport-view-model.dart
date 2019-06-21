import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'webservice.dart';

class Airport {
  String code;
  String name;
  String city;
  String country;

  Airport({
    this.code,
    this.name,
    this.city,
    this.country
  });

  factory Airport.fromJson(Map<String, dynamic> parsedJson) {
    return Airport(
        code: parsedJson['code'] as String,
        name: parsedJson['name'] as String,
        city: parsedJson['city'] as String,
        country: parsedJson['country'] as String
    );
  }
}

class AirportsViewModel {
  static List<Airport> airports;

  static Future loadAirports(String criteria) async {
    try {
//      airports = new List<Airport>();
//      String jsonString = await rootBundle.loadString('assets/airports.json');
//      List parsedJson = json.decode(jsonString);
//      for (int i = 0; i < parsedJson.length; i++) {
//        airports.add(new Airport.fromJson(parsedJson[i]));
//      }

      Map body = new Map();
      body['criteria'] = criteria;
      var bodyEncoded = json.encode(body);
      Map headers = new Map();
      final response = await http.post(Webservice.baseUrl + "/airport/search", headers: {"Content-Type": "application/json"}, body: bodyEncoded,
          encoding: Encoding.getByName("utf-8"));

      if (response.statusCode == 200) {
        airports = (json.decode(response.body) as List)
            .map((data) => new Airport.fromJson(data))
            .toList();
      } else {
        //throw Exception('Failed to load airports');
      }
    } catch (e) {
      print(e);
    }
  }
}