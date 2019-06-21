import 'package:flutter/material.dart';
import 'multicity.dart';
import 'airport-search.dart';
import 'city.dart';
import 'trip.dart';

class FlightSearch extends StatelessWidget {
  CitySearch departureCity =
      CitySearch(title: "Departing from", showImage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
      ListView(
      padding: EdgeInsets.fromLTRB(10.0, 120.0, 10.0, 20.0),
      children: <Widget>[departureCity],
    ),
          TripBar(height: 100.0, title: "Flights"),

        ],
      ),
    );
  }
}

//  @override
//  Widget build(BuildContext context) {
//
//
//    Color color = new Color(hexToInt("FF3D5191"));
//    return Stack(
//      children: <Widget>[
//        new AppBar(
//          backgroundColor: Colors.transparent,
//          elevation: 0.0,
//          centerTitle: true,
//          title: new Text(
//            "Flights",
//            style: TextStyle(
//                fontFamily: 'NothingYouCouldDo', fontWeight: FontWeight.bold),
//          ),
//        ),
//        ListView(
//          padding: EdgeInsets.fromLTRB(10.0, 130.0, 10.0, 20.0),
//          children: <Widget>[departureCity],
//        ),],
//    );
//  }
//}
