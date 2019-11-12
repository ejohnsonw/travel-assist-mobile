import 'package:flutter/material.dart';
import 'feed-list.dart';
import 'trip.dart';
import 'travelful-bar.dart';
import 'app-config.dart';
import 'webservice.dart';
import 'device-info.dart';

class TravelfulApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    Webservice.baseUrl = config.apiBaseUrl;
    Webservice.websocketBaseUrl = config.websocketBaseUrl;
    return MaterialApp(
      title: 'Travelful',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Travelful(title: 'Travelful'),
    );
  }
}

class Travelful extends StatefulWidget {
  Travelful({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TravelfulState createState() => _TravelfulState();
}

class _TravelfulState extends State<Travelful> {
  Future<String> _deviceId;

  @override
  void initState() {
    super.initState();
    _deviceId = DeviceInfo.getDeviceInformation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Travelful',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: TravelfulApplicationBar(
            height: 100.0,
            title: "",
          ),
          body: Center(
            child: FutureBuilder<String>(
                future: _deviceId,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return FeedList("main");
                  } else {
                    return Container();
                  }
                }
//          child: Trip(),
                ),
          ),
        ));
  }
}
