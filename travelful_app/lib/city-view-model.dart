import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'webservice.dart';
import 'airport-view-model.dart';

class City {
  int id;
  String name;
  String adminName;
  String countryISO3;
  String countryISO2;
  String infoUrl;
  String videoUrl;
  String imageUrl;
  List<Airport> airports = new List();

  City({this.id,
    this.name,
    this.adminName,
    this.countryISO2,
    this.countryISO3,
    this.infoUrl,
    this.imageUrl});

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    City c = new City();
    c.id = parsedJson['id'] as int;
    c.name = parsedJson['name'] as String;
    c.adminName =
    parsedJson['adminName'] != null ? parsedJson['adminName'] as String : "";
    c.countryISO2 = parsedJson['countryISO2'] as String;
    c.countryISO3 = parsedJson['countryISO3'] as String;
    c.infoUrl = parsedJson['infoUrl'] as String;
    c.imageUrl = parsedJson['imageUrl'] as String;
    if (parsedJson["airports"] != null) {
      (parsedJson["airports"] as List).forEach((a) {
        c.airports.add(Airport.fromJson(a));
      }
      );
    }
    return c;
  }
}

class CitysViewModel {
  static List<City> citys;

  static Future loadCitys(String criteria) async {
    try {
//      citys = new List<City>();
//      String jsonString = await rootBundle.loadString('assets/citys.json');
//      List parsedJson = json.decode(jsonString);
//      for (int i = 0; i < parsedJson.length; i++) {
//        citys.add(new City.fromJson(parsedJson[i]));
//      }

      Map body = new Map();
      body['criteria'] = criteria;
      var bodyEncoded = json.encode(body);
      Map headers = new Map();
      final response = await http.post(Webservice.baseUrl + "/city/search",
          headers: {"Content-Type": "application/json"},
          body: bodyEncoded,
          encoding: Encoding.getByName("utf-8"));

      if (response.statusCode == 200) {
        citys = (json.decode(utf8.decode(response.bodyBytes)) as List)
            .map((data) => new City.fromJson(data))
            .toList();
      } else {
        //throw Exception('Failed to load citys');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future loadAirports(City city) async {
    try {
      Map body = new Map();
      body['criteria'] = '';

      return http.get(Webservice.baseUrl + "/city/airports/${city.id}",
          headers: {"Content-Type": "application/json"});
    } catch (e) {
      print(e);
    }
  }
}
