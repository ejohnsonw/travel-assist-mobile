import 'package:flutter/material.dart';
import 'feed-list.dart';
import 'trip.dart';
import 'trip-stages.dart';
import 'travelful-bar.dart';
import 'app-config.dart';
import 'webservice.dart';
import 'device-info.dart';
import 'itinerary-list.dart';
import 'search-bar.dart';
import 'fade-route.dart';
import 'trip-search-good.dart';

class TravelfulApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    Webservice.baseUrl = config.apiBaseUrl;
    Webservice.websocketBaseUrl = config.websocketBaseUrl;
    Webservice.baseUrlTravelAssist = config.travelAssistUrl;
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
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('Search Example');
  final TextEditingController _filter = new TextEditingController();

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
            height: 60.0,
            title: "",
          ),
          body: Center(
            child: FutureBuilder<String>(
                future: _deviceId,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: <Widget>[
                        Container(child: ItineraryList("d7abcae35ab8"), margin: EdgeInsets.fromLTRB(0, 60, 0, 0),),
                        Container(
                            alignment: Alignment.topRight,
                            color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
                            margin: EdgeInsets.all(0),
                            height: 70,
                            child: FloatingActionButton(
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    FadeRoute(
                                        page: TripSearch(
                                      title: "Search",
                                    )));
                              },
                              tooltip: 'Search',
                              child: Icon(Icons.search),
                            )
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                }
//          child: Trip(),
                ),
          ),
        ));
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');
        filteredNames = names;
        _filter.clear();
      }
    });
  }
}
