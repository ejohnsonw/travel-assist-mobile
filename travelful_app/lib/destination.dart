import 'package:flutter/material.dart';
import 'airport-search.dart';
import 'city.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:async';
import 'fade-route.dart';
import 'city-view-model.dart';
import 'flight-search.dart';

class DestinationInfo extends StatefulWidget {
  String title;

  DestinationInfo({this.title});

  @override
  _DestinationState createState() =>
      new _DestinationState(title: this.title, parent: this);
}

class _DestinationState extends State<DestinationInfo> {
  StreamController citySelectedController = StreamController.broadcast();
  DestinationInfo parent;
  String title;
  DateTime departing;
  DateTime returning;
  String departingS = "";
  String returningS = "";
  CitySearch citySearch;
  bool hasSelectedCity = false;
  static final dateFormatter = DateFormat('yyyy-MM-dd');

  _DestinationState({this.title, this.parent});

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    citySearch = CitySearch(
        title: this.title,
        showImage: true,
        citySelectedController: citySelectedController);

    citySelectedController.stream.listen(
        (data) {
          setState(() {
            hasSelectedCity = true;
          });
        },
        onDone: () {},
        onError: (error) {
          print("Some Error1");
        });
    return new Card(
        child: Center(
            child: new Column(children: <Widget>[
      citySearch, getActions()
//      Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          mainAxisSize: MainAxisSize.max,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//                height: 20.0,
//                child: FlatButton(
//                  onPressed: () {
//                    debugPrint('I am Awesome');
//                  },
//                  textColor: Colors.white,
//                  color: Colors.deepOrange,
//                  disabledColor: Colors.grey,
//                  disabledTextColor: Colors.white,
//                  highlightColor: Colors.orangeAccent,
//                  child: Text('More'),
//                )),
//            Container(
//                height: 20.0,
//                child: FlatButton(
//                  onPressed: () {
//                    debugPrint('I am Awesome');
//                  },
//                  textColor: Colors.white,
//                  color: Colors.deepPurple,
//                  disabledColor: Colors.grey,
//                  disabledTextColor: Colors.white,
//                  highlightColor: Colors.orangeAccent,
//                  child: Text('Flights'),
//                ))
//          ]),
    ])));
  }

  Widget getActions() {
    Row r1 = null;
    Row r2 = null;
    if (hasSelectedCity) {
//      r1 = new Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          children: <Widget>[
//            new MaterialButton(
//                color: Colors.blueAccent,
//                onPressed: () async {
//                  final List<DateTime> picked =
//                      await DateRangePicker.showDatePicker(
//                          context: context,
//                          initialFirstDate: new DateTime.now(),
//                          initialLastDate:
//                              (new DateTime.now()).add(new Duration(days: 7)),
//                          firstDate: new DateTime(2015),
//                          lastDate: new DateTime(2020));
//                  if (picked != null && picked.length == 2) {
//                    departing = picked[0];
//                    returning = picked[1];
//
//                    setState(() {
//                      departingS = dateFormatter.format(departing);
//                      returningS = dateFormatter.format(returning);
//                    });
//                  }
//                },
//                child: new Text("Pick dates")),
//          ]);
//
//      r2 = Row(
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            new Text(departingS),
//            new Text(returningS),
//          ]);

      r2 = Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new InkWell(
              child: new Text("Explore",
              style: new TextStyle(color: Colors.blue,fontSize: 18.0)),
              onTap: () {print("value of your text");},
            ),
            new InkWell(
              child: new Text("Shop Flights",
                  style: new TextStyle(color: Colors.blue,fontSize: 18.0)),
              onTap: () {Navigator.push(context, FadeRoute(page: FlightSearch()));},
            ),
          ]);
      Column w = new Column(
        children: <Widget>[r2],
      );
      Container c = new Container(
        child: r2,
        height: 80.0,
      );
      return c;
    } else {
      Container c = new Container();
      return c;
    }
  }
}
