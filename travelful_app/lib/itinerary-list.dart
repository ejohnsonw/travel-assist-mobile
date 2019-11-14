import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'city-view-model.dart';
import 'itinerary.dart';
import 'itinerary-tile.dart';
import 'travelful-bar.dart';
import 'flight-search-data.dart';
import 'itinerary-detail.dart';
import 'airport-view-model.dart';
import 'search-bar.dart';

class ItineraryList extends StatefulWidget {
  City departureCity;
  City arrivalCity;
  DateTime departing;
  DateTime returning;
  int adults;
  int children;
  int infants;
  Itinerary itinerary;
  ItineraryListState _state;
  String bookingId;

  ItineraryList(this.bookingId);

  @override
  State<StatefulWidget> createState() {
    _state = new ItineraryListState(this.bookingId);
    return _state;
  }

  getFlights(City departureCity, City arrivalCity, DateTime departing,
      DateTime returning, int adults, int children, int infants) {
    _state.getFlights(bookingId);
  }
}

class ItineraryListState extends State<ItineraryList> {
  static final dateFormatter = DateFormat('yyyy-MM-dd');

  City departureCity;
  City arrivalCity;
  DateTime departing;
  DateTime returning;
  int adults;
  int children;
  int infants;
  Itinerary itinerary;
  List<Map> _offerItems = new List();
  Map search = Map();
  String bookingId;
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
  List<Itinerary> list = List();

  ItineraryListState(this.bookingId);

  @override
  void initState() {
    super.initState();
    search = Map();
    search["departureCity"] = departureCity;
    search["arrivalCity"] = arrivalCity;
    search["departing"] = departing;
    search["returning"] = returning;
    search["adults"] = adults;
    search["children"] = children;
    search["infants"] = infants;

    getFlights(bookingId);
  }

  getFlights(String bookingId) async {
    setState(() {
      isLoading = true;
    });

    Webservice.itinerary(bookingId).then((response) {
      if (response.statusCode == 200) {
        Map resp = (json.decode(utf8.decode(response.bodyBytes)) as Map);
        this.itinerary = new Itinerary.fromJson(resp['itinerary']);
        Webservice.itineraryInfo = this.itinerary;
//        list = (resp["providers"][0]["selectedOffers"] as List)
//            .map((data) => )
//            .toList();
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load flights');
      }
    });

    Webservice.trip(bookingId).then((response) {
      if (response.statusCode == 200) {
        Map resp = (json.decode(utf8.decode(response.bodyBytes)) as Map);
        Webservice.tripInfo = resp;
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load flights');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double barHeight = 120.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          getWidget(),
        ],
      ),
    );
  }

  Widget getWidget() {
    Map search = new Map();
    City departureCity = new City(
        id: 1,
        name: "Munich",
        adminName: "Munich",
        countryISO2: "DE",
        countryISO3: "DE",
        infoUrl: "ss",
        imageUrl: "dd");
    departureCity.airports = new List();
    Airport muc = new Airport(
        code: "MUC", name: "Munich Internation", city: "Munich", country: "DE");
    departureCity.airports.add(muc);

    City arrivalCity = new City(
        id: 2,
        name: "San Francisco",
        adminName: "San Francisco",
        countryISO2: "US",
        countryISO3: "US",
        infoUrl: "ss",
        imageUrl: "dd");
    search['departureCity'] = departureCity;
    search['arrivalCity'] = arrivalCity;

    arrivalCity.airports = new List();
    Airport sfo = new Airport(
        code: "SFO",
        name: "San Francisco",
        city: "San Francisco",
        country: "US");
    arrivalCity.airports.add(sfo);

    ListView ilis = ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return ItineraryTile(
            offer: list[index],
            search: search,
          );
        });

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Container(padding: EdgeInsets.all(5.0),
          color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
          //color: Colors.white,
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          child: new ItineraryDetail(offer: this.itinerary, search: search));
    }
  }
}
