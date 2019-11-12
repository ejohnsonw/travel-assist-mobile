import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:http/http.dart' as http;
import 'tile-item.dart';
import 'travelful-bar.dart';
import 'identity-manager.dart';
import 'device-info.dart';
import 'dart:io';

class FeedList extends StatefulWidget {
  String section;

  FeedList(this.section);

  FeedListState state;

  @override
  State<StatefulWidget> createState() {
    state = FeedListState(this.section);
    return state;
  }
}

class FeedListState extends State<FeedList> {
  FeedListState(this.section);

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

    body['deviceId'] = DeviceInfo.deviceId;


    body['service'] = "travelful.mobile";
    body['section'] = this.section;

    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    String url = Webservice.baseUrl + "/feed/retrieve/";
    final response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

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
    return Container(
        //color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
        color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//            shrinkWrap: true,
//            physics: ClampingScrollPhysics(),
                itemCount: feed["items"].length,
                itemBuilder: (BuildContext context, int index) {
                  return TileItem(item: feed["items"][index]);
                }));
  }
}
