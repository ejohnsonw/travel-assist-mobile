import 'package:flutter/material.dart';
import 'city-view-model.dart';
import 'travelful-bar.dart';

class TripTileDetail extends StatelessWidget {
  int idx;
  Map trip;
  City departureCity;
  City arrivalCity;

  TripTileDetail({this.trip, this.departureCity, this.arrivalCity, this.idx});

  @override
  Widget build(BuildContext context) {
    double fontSize = 15.0;
    String tripLabel = "";
    int last = (trip['segments'] as List).length - 1;
    String dep =
        "${trip['segments'][0]['depd']} ${trip['segments'][0]['dept']}";
    String arr =
        " ${trip['segments'][last]['arrd']} ${trip['segments'][last]['arrt']}";
    if (trip["stops"] == 0) {
      tripLabel = " ${trip['duration']} direct";
    } else {
      tripLabel = "${trip['duration']} ${trip['stops']} stops";
    }

    String cities = "";
    String cityStart = "";
    String cityEnd = "";
    String airportStart = "";
    String airportEnd = "";
    if (idx == 0) {
      cityStart = "${departureCity.name}";
      cityEnd = "${arrivalCity.name}";
      airportStart = "${departureCity.airports[0].code}";
      airportEnd = "${arrivalCity.airports[0].code}";
    }
    if (idx == 1) {
      cityEnd = "${departureCity.name}";
      cityStart = "${arrivalCity.name}";
      airportStart = "${arrivalCity.airports[0].code}";
      airportEnd = "${departureCity.airports[0].code}";
    }

    Widget tripHeader = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(children: <Widget>[
          Text(airportStart,
              style: TextStyle(fontSize: 32), textAlign: TextAlign.left),
          Text(cityStart,
              style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
          Text(dep, style: TextStyle(fontSize: 10), textAlign: TextAlign.left),
        ]),
        Column(children: <Widget>[
          Container(
//          color: Colors.green,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(tripLabel,
                style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          )
        ]),
        Column(children: <Widget>[
          Text(airportEnd,
              style: TextStyle(fontSize: 32), textAlign: TextAlign.right),
          Text(cityEnd,
              style: TextStyle(fontSize: 15), textAlign: TextAlign.right),
          Text(arr, style: TextStyle(fontSize: 10), textAlign: TextAlign.right),
        ]),
      ],
    );
    return Card (
        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
    child:Column(children: <Widget>[
//      Container(
//        width: MediaQuery.of(context).size.width,
//        height: 10,
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            fit: BoxFit.fitWidth,
//            image: AssetImage("assets/lines.png"),
//          ),
//        ),
//      ),
      tripHeader,
      Container(
        width: MediaQuery.of(context).size.width,
        height: 10,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage("assets/lines.png"),
          ),
        ),
      ),
      Container(
        color: Colors.grey,
    child: ListView.builder(
          padding: const EdgeInsets.all(3),
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: trip['segments'].length,
          itemBuilder: (BuildContext context, int index) {
            Map segment = trip['segments'][index];

            Widget tripHeader = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  Text("${segment['origin']}",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
//                  Text(cityStart,
//                      style: TextStyle(fontSize: 15),
//                      textAlign: TextAlign.left),
                  Text("${segment['depd']} ${segment['dept']}",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.left),
                ]),
                Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                        "${segment['flight']}${segment['classOfService']} ${segment['elapsed']}",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center),
                  )
                ]),
                Column(children: <Widget>[
                  Text("${segment['destination']}",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.right),
//                  Text(cityEnd,
//                      style: TextStyle(fontSize: 15),
//                      textAlign: TextAlign.right),
                  Text("${segment['arrd']} ${segment['arrt']}",
                      style: TextStyle(fontSize: 10),
                      textAlign: TextAlign.right),
                ]),
              ],
            );
            return tripHeader;

          }),
      )
    ]));

  }
}
