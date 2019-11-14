import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'city-view-model.dart';
import 'package:uuid/uuid.dart';
import 'app-config.dart';
import 'flight-search-data.dart';
import 'itinerary.dart';

class Webservice {
  static String baseUrl = "";
  static String baseUrlTravelAssist = "";
  static String websocketBaseUrl = "";
  static String clientId = "travelful_mobile";
  static final dateFormatter = DateFormat('yyyy-MM-dd');
  static Itinerary itineraryInfo;
  static Map tripInfo;
  Webservice() {}

//  Future<List<Map>> fetchFeed() async {
//    Map body = new Map();
//    var bodyEncoded = json.encode(body);
//    Map headers = new Map();
//    final response = await http.post(
//      baseUrl + "/feed/retrieve",
//      body: "{}",
//      headers: {"Content-Type": "application/json"},
//    );
//
//    if (response.statusCode == 200) {
//      // If the call to the server was successful, parse the JSON
//      List list = (json.decode(response.body) as List)
//          .map((data) => new Feed.fromJson(data))
//          .toList();
//    } else {
//      // If that call was not successful, throw an error.
//      throw Exception('Failed to load post');
//    }
//  }

  static Future<http.Response> getFlights(
      City destination,
      City departure,
      DateTime departing,
      DateTime returning,
      int adults,
      int children,
      int infants) async {
    String departingS = dateFormatter.format(departing);
    String returningS = dateFormatter.format(returning);
    var uuid = new Uuid();
    FlightSearchData.flightSearch = new Map();
    FlightSearchData.flightSearch["adults"] = adults;
    FlightSearchData.flightSearch["children"] = children;
    FlightSearchData.flightSearch["infants"] = infants;
    FlightSearchData.flightSearch["searchId"] = uuid.v4();
    FlightSearchData.flightSearch["immediate"] = false;
    FlightSearchData.flightSearch["preferences"] = {};
    FlightSearchData.flightSearch["immediate"] = true;
    FlightSearchData.flightSearch["preferences.sources"] = ['*'];

    FlightSearchData.flightSearch["itineraryComponents"] = List();
    Map od = new Map();
    if (departure.airports[0] != null) {
      od['origin'] = departure.airports[0].code;
      od['leaving'] = departingS;
      od['returning'] = returningS;
    } else {
      return null;
    }
    if (destination.airports[0] != null) {
      od['destination'] = destination.airports[0].code;
    }
    if (FlightSearchData.flightSearch['adults'] == 0 &&
        FlightSearchData.flightSearch['children'] == 0 &&
        FlightSearchData.flightSearch['infants'] == 0) {
        FlightSearchData.flightSearch['adults'] = 1;
    }
    FlightSearchData.flightSearch["itineraryComponents"].add(od);
    var bodyEncoded = json.encode(FlightSearchData.flightSearch);
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["clientId"] = clientId;
    return http.post(baseUrl + "/travelful/search",
        body: bodyEncoded, headers: headers);
  }

  static Future<http.Response> feedForCity(
      City destination, DateTime departing, DateTime returning) async {
    Map feedForCity = new Map();
    feedForCity["citiId"] = destination.id;
    //TODO: THIS SHOULD BE ARRIVING DATE, INSTEAD OF DEPARTURE DATE FROM ORIGIN.
    feedForCity["departing"] = dateFormatter.format(departing);
    feedForCity["returning"] = dateFormatter.format(returning);
    var bodyEncoded = json.encode(feedForCity);
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["clientId"] = clientId;
    return http.post(baseUrl + "/travelful/feedForCity",
        body: bodyEncoded, headers: headers);
  }


  static Future<http.Response> itinerary(bookingId) async {
    Map itineraryRequest = new Map();
    itineraryRequest["bookingId"] = bookingId;
    var bodyEncoded = json.encode(itineraryRequest);
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["clientId"] = clientId;
    return http.post(baseUrlTravelAssist + "itinerary",
        body: bodyEncoded, headers: headers);
  }

  static Future<http.Response> trip(bookingId) async {
    Map itineraryRequest = new Map();
    itineraryRequest["bookingId"] = bookingId;
    var bodyEncoded = json.encode(itineraryRequest);
    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["clientId"] = clientId;
    return http.get(baseUrlTravelAssist + "trip/"+bookingId, headers: headers);
  }
}
