import 'package:flutter/material.dart';

import 'city.dart';
import 'city-view-model.dart';
import 'card-image.dart';
import 'passenger-count.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'trip.dart';
import 'flight-offer-list.dart';
import 'fade-route.dart';
import 'travelful-bar.dart';
import 'platform/platform-button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class FlightSearch extends StatefulWidget {
  City selectedCity;
  DateTime departing;
  DateTime returning;

  FlightSearch({this.selectedCity, this.departing, this.returning});

  @override
  FlightSearchState createState() => new FlightSearchState(
      selectedCity: this.selectedCity,
      departing: this.departing,
      returning: this.returning);
}

class FlightSearchState extends State<FlightSearch> {
  FlightSearchState({this.selectedCity, this.departing, this.returning});

  CitySearch departureCity =
      CitySearch(title: "Departing from", showImage: false);

  City selectedCity;
  DateTime departing;
  DateTime returning;
  String departingS = "";
  String returningS = "";
  static final dateFormatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  PassengerCount passengerCount = PassengerCount();
  ListView listView;
  ScrollController _scrollController = new ScrollController();

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if(visible){
          _scrollController.animateTo(1000, duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double barHeight = 120.0;
    departingS = dateFormatter.format(departing);
    returningS = dateFormatter.format(returning);

     listView = ListView(
        reverse: false,
        padding:
        EdgeInsets.fromLTRB(10.0, barHeight + 10.0, 10.0, 20.0),
        controller: _scrollController,
        children: <Widget>[
          Text(selectedCity.name +
              " " +
              selectedCity.countryISO2 +
              "  [$departingS / $returningS]"),
          CardWithImage(selectedCity.imageUrl),
          passengerCount,
          departureCity,
          new PlatformButton(
              color: Colors.blue,
              onPressed: () {

                Navigator.push(context,
                    FadeRoute(
                        page: FlightOfferList(departureCity.state.selectedCity, selectedCity,  departing, returning, passengerCount.state.adults, passengerCount.state.children, passengerCount.state.infants)
                    ));

              },
              child: new Text("Shop")),

        ]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: listView,
          ),

          TravelfulApplicationBar(height: barHeight, title: ""), ],
      ),
    );
  }
}
