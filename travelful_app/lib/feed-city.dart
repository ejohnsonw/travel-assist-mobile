import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:http/http.dart' as http;

import 'tile-item.dart';
import 'travelful-bar.dart';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'city-view-model.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedCity extends StatefulWidget {
  City city;
  DateTime departing;
  DateTime returning;

  FeedCityState _state;

  @override
  State<StatefulWidget> createState() {
    _state = FeedCityState();
    return _state;
  }

  loadFeed(City city, DateTime departing, DateTime returning) {
    _state.loadFeed(city, departing, returning);
  }
}

class FeedCityState extends State<FeedCity> {
  City city;
  DateTime departing;
  DateTime returning;

  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
  Map feed = Map();

  @override
  initState(){
    feed["items"] = List();
  }
  loadFeed(City city, DateTime departing, DateTime returning) async {
    setState(() {
      isLoading = true;
    });
    this.city = city;
    var uuid = new Uuid().v4();
    Map body = new Map();
    body['cityId'] = city.id;
    body['uuid'] = uuid;
    if (departing != null) {
      body['departing'] = departing.toIso8601String();
    }

    if (returning != null) {
      body['returning'] = returning.toIso8601String();
    }

    final channel = IOWebSocketChannel.connect(Webservice.websocketBaseUrl+"/city/" + uuid);
    channel.stream.listen((message) {
      print(message.toString());
      var data = json.decode(message) as Map;
      //channel.sink.add("received!: "+message);
      //channel.sink.close(status.goingAway);
    });
    channel.sink.add("received! " + city.name);

    setState(() {
      isLoading = false;
    });

    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    final response = await http.post(
      Webservice.baseUrl + "/city/feed",
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      feed = json.decode(utf8.decode(response.bodyBytes)) as Map;
      if(feed["items"] == null){
        feed["items"] = List();
      }
//      list = ()
//          .map((data) => new Feed.fromJson(data))
//          .toList();

      Map headers = <String, String>{'io': uuid, 'transport': 'polling'};
    } else {
      throw Exception('Failed to load photos');
    }
  }

//  @override
//  initState() {
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    Widget weather = Container(
      padding: EdgeInsets.all(15.0),
      height: 200.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage("assets/weather.png"),
        ),
      ),
    );

    Widget video = YoutubePlayer(
      context: context,
      //videoId: "-17MPSCnnDU",
      videoId: "AWQje34khog",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        showVideoProgressIndicator: true,
      ),
      videoProgressIndicatorColor: Colors.amber,
    );

    Widget listView = ListView.builder(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        itemCount: feed["items"].length,
        itemBuilder: (BuildContext context, int index) {
          return TileItem(item: feed["items"][index]);
        });
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!isLoading && feed["items"].length == 0) {
      if (city != null) {
        return Column(
          children: <Widget>[
            Text(
              "Points of Interest",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 31
              ),
            ),
            video,
            Text(
              "Weather",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 31
              ),
            ),
            weather,
          ],
        );
      } else {
        return Container(
          height: 0,
//        child: weather,
        );
      }
    } else {
      if (!isLoading) {
        return Column(
          children: <Widget>[
            video,
            weather,
            listView,
          ],
        );
      }
    }

//    return Container(
//        color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
//        child: Center(
//          child: CircularProgressIndicator(),
//        ));
  }
}
