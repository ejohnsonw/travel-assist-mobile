import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:http/http.dart' as http;
import 'tile-item.dart';
import 'travelful-bar.dart';
import 'identity-manager.dart';
import 'device-info.dart';
import 'dart:io';
import 'stage-item.dart';
import 'itinerary-list.dart';

class TripStage extends StatefulWidget {
  String section;

  TripStage(this.section);

  TripStageState state;

  @override
  State<StatefulWidget> createState() {
    state = TripStageState(this.section);
    return state;
  }
}

class TripStageState extends State<TripStage> {
  TripStageState(this.section);

  List<Map> _feedItems = new List();
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();

  Map feed;

  String section;

  _fetchData(Map body) async {
    setState(() {
      isLoading = true;
    });

    body['bookingId'] = "d7abcae35ab8";

    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    String url = Webservice.baseUrlTravelAssist + "trip/d7abcae35ab8";
    final response = await http.get(url);

    if (response.statusCode == 200) {
//      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
//          .map((data) => new Feed.fromJson(data))
//          .toList();
      feed = json.decode(utf8.decode(response.bodyBytes)) as Map;
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load photos');
    }
  }

  @override
  initState() {
    super.initState();
    Map body = new Map();
    _fetchData(body);
  }

  @override
  Widget build(BuildContext context) {

    ListView stagesList =  ListView.builder(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//            shrinkWrap: true,
//            physics: ClampingScrollPhysics(),
        itemCount: feed["locations"].length,
        itemBuilder: (BuildContext context, int index) {
          return StageItem(item: feed["locations"][index]);
        });

    ItineraryList itineraryList = new ItineraryList("d7abcae35ab8");

    return Container(
        //color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
        color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : itineraryList

              );
  }
}
