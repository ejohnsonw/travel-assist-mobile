import 'package:flutter/material.dart';
import 'city-view-model.dart';

class TripTile extends StatelessWidget {
  int idx;
  Map trip;
  Map search;

  TripTile({this.trip, this.search, this.idx});

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
      tripLabel = trip['starts'] + " ${trip['duration']} direct";
    } else {
      tripLabel =
          trip['starts'] + "    ${trip['duration']} ${trip['stops']} stops";
    }
    String cities = "";
    if (idx == 0) {
      cities = "${search["departureCity"].name} to ${search["arrivalCity"].name}";
    }
    if (idx == 1) {
      cities = "${search["arrivalCity"].name} to ${search["departureCity"].name}";
    }
    return Column(
      children: <Widget>[
        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[
            Text(cities,
                style: new TextStyle(
                    fontFamily: 'RobotoMono',
                    color: Colors.grey,
                    fontSize: fontSize),
                textAlign: TextAlign.left),
//            Text(trip['destination'],
//                style: new TextStyle(
//                    fontFamily: 'RobotoMono',
//                    color: Colors.black,
//                    fontSize: fontSize+5,),textAlign: TextAlign.right,)
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              dep,
              style: new TextStyle(
                  fontFamily: 'NothingYouCouldDo',
                  color: Colors.blue,
                  fontSize: fontSize),
            ),
            Container(
//          color: Colors.green,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                trip['duration'],
                style: new TextStyle(
                    fontFamily: 'NothingYouCouldDo',
                    color: Colors.black,
                    fontSize: fontSize),
                textAlign: TextAlign.right,
              ),
            ),
            Text(arr,
                style: new TextStyle(
                    fontFamily: 'NothingYouCouldDo',
                    color: Colors.blue,
                    fontSize: fontSize))
          ],
        ),
      ],
    );

//    return Column(children: <Widget>[
//        Text(tripLabel,style: new TextStyle(color: Colors.blue, fontSize: 14.0)),
//      ListView.builder(
//          shrinkWrap: true,
//          physics: ClampingScrollPhysics(),
//          itemCount: trip['segments'].length,
//          itemBuilder: (BuildContext context, int index) {
//            Map segment = trip['segments'][index];
//            return Text("${segment['origin']}${segment['destination']} ${segment['flight']}${segment['classOfService']} ${segment['depd']} ${segment['dept']} ${segment['arrd']} ${segment['arrt']}  ${segment['elapsed']}",style: new TextStyle(fontFamily: 'RobotoMono',color: Colors.blue, fontSize: 12.0));
//            return TripTile(trip: trip['segments'][index]);
//          }),
//    ]);
  }
}
