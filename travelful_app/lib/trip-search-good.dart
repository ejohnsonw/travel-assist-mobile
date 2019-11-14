import 'package:flutter/material.dart';
import 'package:Travelful/autocomplete_textfield.dart';
import 'airport-view-model.dart';
import 'city.dart';
import 'webservice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travelful-bar.dart';
import 'business-tile.dart';

class TripSearch extends StatefulWidget {
  String title;

  TripSearch({this.title});

  @override
  _TripSearchState createState() => new _TripSearchState(title: this.title);
}

class _TripSearchState extends State<TripSearch> {
  GlobalKey<AutoCompleteTextFieldState<Map>> key = new GlobalKey();

  TextField searchTextField;

  TextEditingController controller = new TextEditingController();
  String title;

  List _searchResults = new List();

  var isLoading = false;

  _TripSearchState({this.title});

  _fetchData(String criteria) async {
    setState(() {
      isLoading = true;
    });

    Map body = new Map();
    body['criteria'] = criteria;
    body['trip'] = Webservice.tripInfo;
    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    String url = Webservice.baseUrlTravelAssist + "findInTrip";
    final response = await http.post(
      url,
      body: bodyEncoded,
      headers: {"Content-Type": "application/json"},
    );
    _searchResults = new List();
    if (response.statusCode == 200) {
//      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
//          .map((data) => new Feed.fromJson(data))
//          .toList();
      _searchResults = json.decode(utf8.decode(response.bodyBytes)) as List;

      setState(() {
        isLoading = false;
      });
      return _searchResults;
    } else {
      setState(() {
        isLoading = false;
      });
      //throw Exception('Failed to load photos');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
//    controller.addListener(this.textChanged());
//    _loadData("");
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 13.0;
    searchTextField = TextField(
//      onChanged: (text) {
//        if (text.length >= 3) {
//          this._fetchData(text);
//        } else {
//          this._searchResults = new List();
//          setState(() {
//            isLoading = false;
//          });
//        }
//      },
      controller: controller,
    );

    Widget searchComponent = Row(
      children: <Widget>[
        Container(child: searchTextField,
          height: 50,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.6,),
        Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(0),
            height: 30,
            width:MediaQuery
                .of(context)
                .size
                .width * 0.3,
            child: FloatingActionButton(
              onPressed: () async {
                this._fetchData(controller.text);
              },
              tooltip: 'Search',
              child: Icon(Icons.search),
            )
        )
      ],
    );
    if (isLoading) {
      return Scaffold(
          body: Stack(children: <Widget>[
            Column(children: <Widget>[
              TravelfulApplicationBar(height: 80, title: ""),
              searchComponent,
              CircularProgressIndicator()
            ])
          ]));
    } else {
      return Scaffold(
        body: Stack(children: <Widget>[
          Column(children: <Widget>[
            TravelfulApplicationBar(height: 80, title: ""),
            Container(
              padding: EdgeInsets.all(10.0),
              child: searchComponent,
            ),
            ListView.builder(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10, 0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  var business = _searchResults[index];
                  print(business['businessName']);
                  return BusinessTile(business: business);
                })
          ])
        ]),
      );
    }
//
//    return new Stack(
//      children: <Widget>[
//        Card(
//            margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
//            child: Column(
//            children: <Widget>[searchTextField])),
//        TravelfulApplicationBar(
//          title: "Search",
//          height: 100,
//        )
//      ],
//    );
  }

  textChanged() {
    if (controller.text.length >= 3) {
      this._fetchData(controller.text);
    }
  }
}
