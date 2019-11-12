import 'package:flutter/material.dart';
import 'multicity.dart';
import 'airport-search.dart';
import 'travelful-bar.dart';

class Trip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          MultiCityInput(),
          TravelfulApplicationBar(
            height: 120.0,
            title: "",
          ),
        ],
      ),
    );
  }
}


