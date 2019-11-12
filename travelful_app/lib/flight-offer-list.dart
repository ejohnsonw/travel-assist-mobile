import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'city-view-model.dart';
import 'flight-offer.dart';
import 'flight-offer-tile.dart';
import 'travelful-bar.dart';
import 'flight-search-data.dart';

class FlightOfferList extends StatefulWidget {
  City departureCity;
  City arrivalCity;
  DateTime departing;
  DateTime returning;
  int adults;
  int children;
  int infants;

  FlightOfferListState _state;

  FlightOfferList(this.departureCity, this.arrivalCity, this.departing,
      this.returning, this.adults, this.children, this.infants);

  @override
  State<StatefulWidget> createState() {
    _state = new FlightOfferListState(
        this.departureCity,
        this.arrivalCity,
        this.departing,
        this.returning,
        this.adults,
        this.children,
        this.infants);
    return _state;
  }

  getFlights(City departureCity, City arrivalCity, DateTime departing,
      DateTime returning, int adults, int children, int infants) {
    _state.getFlights(departureCity, arrivalCity, departing, returning, adults,
        children, infants);
  }
}

class FlightOfferListState extends State<FlightOfferList> {
  static final dateFormatter = DateFormat('yyyy-MM-dd');

  City departureCity;
  City arrivalCity;
  DateTime departing;
  DateTime returning;
  int adults;
  int children;
  int infants;

  List<Map> _offerItems = new List();
  Map search = Map();

  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
  List<FlightOffer> list = List();

  FlightOfferListState(this.departureCity, this.arrivalCity, this.departing,
      this.returning, this.adults, this.children, this.infants);

  @override
  void initState() {
    super.initState();
    search = Map();
    search["departureCity"]=departureCity;
    search["arrivalCity"]=arrivalCity;
    search["departing"]=departing;
    search["returning"]=returning;
    search["adults"]=adults;
    search["children"]=children;
    search["infants"]=infants;

    getFlights(departureCity, arrivalCity, departing, returning, adults,
        children, infants);
  }

  getFlights(City departureCity, City arrivalCity, DateTime departing,
      DateTime returning, int adults, int children, int infants) async {
    setState(() {
      isLoading = true;
    });

    Webservice.getFlights(arrivalCity, departureCity, departing, returning, adults, children, infants)
        .then((response) {
      if (response.statusCode == 200) {
        Map resp = (json.decode(utf8.decode(response.bodyBytes)) as Map);
        FlightSearchData.response = resp;
        list = (resp["providers"][0]["selectedOffers"] as List)
            .map((data) => new FlightOffer.fromJson(data))
            .toList();
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
          TravelfulApplicationBar(height: barHeight, title: ""),
        ],
      ),
    );
  }

  Widget getWidget() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (list.length > 0) {
        return Container(
            color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
            margin: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlightOfferTile(
                    offer: list[index],
                    search: search,
                  );
                }));
      } else {
        return Text("No results");
      }
    }
  }
}
