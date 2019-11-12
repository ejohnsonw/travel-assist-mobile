import 'package:flutter/material.dart';
import 'webservice.dart';

import 'package:intl/intl.dart';

import 'flight-offer.dart';
import 'travelful-bar.dart';
import 'passenger.dart';
import 'passenger-tile.dart';
import 'fade-route.dart';
import 'platform/platform-button.dart';
import 'flight-search-data.dart';
import 'device-info.dart';

class BookFlight extends StatefulWidget {
  Map search;
  FlightOffer offer;
  BookFlightState _state;

  BookFlight({this.search, this.offer});

  @override
  State<StatefulWidget> createState() {
    _state = new BookFlightState(this.search, this.offer);
    return _state;
  }
}

class BookFlightState extends State<BookFlight> {
  static final dateFormatter = DateFormat('yyyy-MM-dd');

  BookFlightState(this.search, this.offer);

  Map search;
  FlightOffer offer;

  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
  List<Passenger> passengers = List();

  @override
  void initState() {
    super.initState();
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
    num total = search["adults"] + search["children"] + search["infants"];
    passengers = List();
    for(int i=0; i < total; i++){
      var passenger = Passenger();
      passenger.id = i + 1;
      passengers.add(passenger);
    }
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (passengers.length > 0) {
        return
          ListView.builder(
              padding: EdgeInsets.fromLTRB(10.0, 130, 10, 0),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: passengers.length,
              itemBuilder: (BuildContext context, int index) {

                var passenger = passengers[index];
                if (index == passengers.length - 1) {
                  return Column(
                      children: [

                        PassengerTile(passenger: passenger),
                        Container(height: 50,),
                        PlatformButton(
                            color: Colors.blueAccent,
                            onPressed: () async {

                                Map booking = Map();
                                booking["itinerary"] = offer;
                                booking["passengers"] = List();
                                for(Passenger p in passengers){
                                  (booking["passenger"] as List).add(p.asMap());
                                }
                                booking["searchId"] = FlightSearchData.flightSearch["searchId"];
                                booking["publicId"] = DeviceInfo.deviceId;
                                booking["testMode"] = true;
//                              FlightResultsManager.shared.booking["bookingFromCache"] = false
//                              FlightResultsManager.shared.booking["moreCount"] = 0
//                              FlightResultsManager.shared.booking["namePrefix"] = "ND"
//

//                              Navigator.push(context,
//                                  FadeRoute(page: BookFlight(
//                                      search: search, offer: offer)));
                            },
                            child: new Text("Book"))
                      ]

                  );
                } else {
                  return PassengerTile(passenger: passenger);
                }
              });


        //);
      } else {
        return Text("No results");
      }
    }
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}
