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
import 'feed-city.dart';
import 'platform/platform-button.dart';

class StageSearchInfo extends StatefulWidget {
  String title;
  StageSearchState state;
  Map stage;
  StageSearchInfo({this.stage});

  @override
  StageSearchState createState() {
    state = new StageSearchState(title: this.stage['name'], parent: this);
    return state;
  }
}

class StageSearchState extends State<StageSearchInfo> {
  StreamController citySelectedController = StreamController.broadcast();
  StageSearchInfo parent;
  String title;
  DateTime departing;
  DateTime returning;
  String departingS = "";
  String returningS = "";
  CitySearch citySearch;
  bool hasSelectedCity = false;
  bool hasSelectedDates = false;
  City selectedCity;
  String pickDates = "Select Dates";
  FeedCity  feedCity = new FeedCity();
  static final dateFormatter = DateFormat('yyyy/MM/dd');

  StageSearchState({this.title, this.parent});

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    citySelectedController.stream.listen(
            (data) {
          setState(() {
//            hasSelectedCity = true;
//            selectedCity = (data as StageSearchCitySelected).city;
            loadStageSearchFeed(selectedCity, departing, returning);
          });
        },
        onDone: () {},
        onError: (error) {
          print("Some Error1");
        });
  }

  @override
  Widget build(BuildContext context) {

    citySearch = CitySearch(
        title: this.title,
        showImage: true,
        citySelectedController: citySelectedController);

    return new Card(
        child: Center(
            child: new Column(children: <Widget>[
      citySearch,getActions(), feedCity
    ])));
  }

  loadStageSearchFeed(City selectedCity, DateTime departing, DateTime returning){
     feedCity.loadFeed(selectedCity, departing, returning);
  }

  Widget getActions() {
    Widget r1 = null;
    Widget r2 = null;
    Row r3 = null;
    r2 = new Container(
      height: 10.0,
      width: 1.0,
      color: Colors.white,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
    if (hasSelectedCity) {
      r1 = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PlatformButton(
                color: Colors.blueAccent,
                onPressed: () async {
                  final List<DateTime> picked =
                      await DateRangePicker.showDatePicker(
                          context: context,
                          initialFirstDate: new DateTime.now(),
                          initialLastDate:
                              (new DateTime.now()).add(new Duration(days: 7)),
                          firstDate: new DateTime(2015),
                          lastDate: new DateTime(2020));
                  if (picked != null && picked.length == 2) {
                    departing = picked[0];
                    returning = picked[1];

                    setState(() {
                      departingS = dateFormatter.format(departing);
                      returningS = dateFormatter.format(returning);
                      pickDates = "${departingS} - ${returningS}";
                      hasSelectedDates = true;
                      loadStageSearchFeed(selectedCity,departing,returning);
                    });
                  }
                },
                child: new Text(pickDates)),
            hasSelectedDates
                ? PlatformButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          FadeRoute(
                              page: FlightSearch(
                                selectedCity: selectedCity,
                                departing: departing,
                                returning: returning,
                              )));
                    },
                    child: new Text("Shop Flights"))
                : Container(),
//            new Text("[$departingS / $returningS]"),
          ]);

      r3 = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new InkWell(
              child: new Text("Explore",
                  style: new TextStyle(color: Colors.blue, fontSize: 18.0)),
              onTap: () {
                print("value of your text");
              },
            ),
            new InkWell(
              child: new Text("Shop Flights",
                  style: new TextStyle(color: Colors.blue, fontSize: 18.0)),
              onTap: () {
                Navigator.push(
                    context,
                    FadeRoute(
                        page: FlightSearch(
                      selectedCity: selectedCity,
                      departing: departing,
                      returning: returning,
                    )));
              },
            ),
          ]);
      Column w = new Column(
        children: <Widget>[r2, r1, r2],
      );
//      Container c = new Container(
//        child: r2,
//        height: 80.0,
//      );
      return w;
    } else {
      Container c = new Container();
      return c;
    }
  }
}
