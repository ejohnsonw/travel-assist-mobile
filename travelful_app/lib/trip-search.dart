import 'package:flutter/material.dart';

import 'flight-offer.dart';
import 'trip-tile-detail.dart';
import 'travelful-bar.dart';
import 'book-flight.dart';
import 'fade-route.dart';
import 'platform/platform-button.dart';
import 'itinerary.dart';
import 'webservice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:material_search/material_search.dart';


class TripSearchPage extends StatefulWidget {
  TripSearchPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TripSearchPageState createState() => new _TripSearchPageState();
}

class _TripSearchPageState extends State<TripSearchPage> {

  List _feedItems = new List();
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();


  String _name = 'No one';

  final _formKey = new GlobalKey<FormState>();

//  _buildMaterialSearchPage(BuildContext context) {
//    return new MaterialPageRoute<String>(
//        settings: new RouteSettings(
//          name: 'material_search',
//          isInitialRoute: false,
//        ),
//        builder: (BuildContext context) {
//          return new Material(
//            child: new MaterialSearch<String>(
//              placeholder: 'Search',
//              results: _names.map((String v) => new MaterialSearchResult<String>(
//                icon: Icons.person,
//                value: v,
//                text: "Mr(s). $v",
//              )).toList(),
//              filter: (dynamic value, String criteria) {
//                return value.toLowerCase().trim()
//                    .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
//              },
//              onSelect: (dynamic value) => Navigator.of(context).pop(value),
//              onSubmit: (String value) => Navigator.of(context).pop(value),
//            ),
//          );
//        }
//    );
//  }

//  _showMaterialSearch(BuildContext context) {
//    Navigator.of(context)
//        .push(_buildMaterialSearchPage(context))
//        .then((dynamic value) {
//      setState(() => _name = value as String);
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new MaterialSearch<String>(
      placeholder: 'Search', //placeholder of the search bar text input

      getResults: (String criteria) async {
        if(criteria.length >= 3){
          var list = await _fetchData(criteria);
          return list.map((name) => new MaterialSearchResult<String>(
            value: name, //The value must be of type <String>
            text: name, //String that will be show in the list
            icon: Icons.person,
          )).toList();
        }else{
          return new List();
        }

      },
//      //or
//      results: _list.map((name) => new MaterialSearchResult<String>(
//        value: name, //The value must be of type <String>
//        text: name, //String that will be show in the list
//        icon: Icons.person,
//      )).toList(),

      //optional. default filter will look like this:
      filter: (String value, String criteria) {
        return value.toString().toLowerCase().trim()
            .contains(new RegExp(r'' + criteria.toLowerCase().trim() + ''));
      },
//      //optional
//      sort: (String value, String criteria) {
//        return 0;
//      },
      //callback when some value is selected, optional.
      onSelect: (String selected) {
        print(selected);
      },
      //callback when the value is submitted, optional.
      onSubmit: (String value) {
        print(value);
      },
    );
  }


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

    if (response.statusCode == 200) {
//      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
//          .map((data) => new Feed.fromJson(data))
//          .toList();
      _feedItems = json.decode(utf8.decode(response.bodyBytes)) as List;

      setState(() {
        isLoading = false;
      });
      return _feedItems;
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load photos');
    }
    return null;
  }

}

