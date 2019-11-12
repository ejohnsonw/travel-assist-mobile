import 'package:flutter/material.dart';
import 'airport-search.dart';
import 'destination.dart';
import 'city.dart';

class MultiCityInput extends StatefulWidget {
  String title;
  _MulticityState state;

  @override
  _MulticityState createState() {
    state = new _MulticityState(title: this.title);
    return state;
  }
}

class _MulticityState extends State<MultiCityInput> {
  String title;

  DestinationInfo arrivalCity;
//  CitySearch departureCity;

  _MulticityState({this.title});

  @override
  Widget build(BuildContext context) {
    arrivalCity = DestinationInfo(title: "What is your destination?");
//    departureCity = CitySearch(title: "Traveling from",showImage: true);
    return ListView(
      padding: EdgeInsets.fromLTRB(10.0, 130.0, 10.0, 20.0),
      children: <Widget>[arrivalCity],
    );
  }
}
