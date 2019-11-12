import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'photo.dart';
import 'package:http/http.dart' as http;
import 'tile-item.dart';

class DestinationFeedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DestinationFeedListState();
  }
}

class DestinationFeedListState extends State<DestinationFeedList> {
  List<Map> _feedItems = new List();
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
//  List<Feed> list = List();
  Map feed;

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    Map body = new Map();
    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    final response = await http.post(Webservice.baseUrl+"/city/feed", body: "{}" , headers: {
      "Content-Type": "application/json"
    },);

    if (response.statusCode == 200) {
//      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
//          .map((data) => new Feed.fromJson(data))
//          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  initState() {
    super.initState();
//  _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: isLoading
            ? Center(child: CircularProgressIndicator(),)
            : ListView.builder(
            itemCount: feed["items"].length,
            itemBuilder: (BuildContext context, int index) {
            return TileItem(item:feed["items"][index]);

            }));
  }
}
