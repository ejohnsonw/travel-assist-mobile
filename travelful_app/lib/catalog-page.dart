import 'package:flutter/material.dart';
import 'package:Travelful/autocomplete_textfield.dart';
import 'airport-view-model.dart';
import 'city.dart';
import 'webservice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'travelful-bar.dart';
import 'business-tile.dart';
import 'product-tile.dart';

class Catalog extends StatefulWidget {
  Map business;

  Catalog({this.business});

  @override
  _CatalogState createState() => new _CatalogState(business: this.business);
}

class _CatalogState extends State<Catalog> {
  GlobalKey<AutoCompleteTextFieldState<Map>> key = new GlobalKey();

  TextField searchTextField;

  TextEditingController controller = new TextEditingController();
  Map business;

  List _searchResults = new List();

  var isLoading = false;

  _CatalogState({this.business});

//  _fetchData(String criteria) async {
//    setState(() {
//      isLoading = true;
//    });
//
//    Map body = new Map();
//    body['criteria'] = criteria;
//    body['trip'] = Webservice.tripInfo;
//    var bodyEncoded = json.encode(body);
//    Map headers = new Map();
//    String url = Webservice.baseUrlTravelAssist + "findInTrip";
//    final response = await http.post(
//      url,
//      body: bodyEncoded,
//      headers: {"Content-Type": "application/json"},
//    );
//    _searchResults = new List();
//    if (response.statusCode == 200) {
////      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
////          .map((data) => new Feed.fromJson(data))
////          .toList();
//      _searchResults = json.decode(utf8.decode(response.bodyBytes)) as List;
//
//      setState(() {
//        isLoading = false;
//      });
//      return _searchResults;
//    } else {
//      setState(() {
//        isLoading = false;
//      });
//      //throw Exception('Failed to load photos');
//    }
//    return null;
//  }

  @override
  void initState() {
    super.initState();
//    _loadData("");
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 13.0;
    return
      Container(
        color: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
        child: Stack(
          children: <Widget>[
            Container(child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0.0, 20, 0, 0),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: business['products'].length,
                itemBuilder: (BuildContext context, int index) {
                  var product = this.business['products'][index];
                  //print(product['name']);
                  if(product['image'] == null){
                    product['image'] = business['photo'];
                  }
                  return ProductTile(product: product);
                }) ,
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              height: MediaQuery.of(context).size.height,),
            TravelfulApplicationBar(height: 80,title: "",)],
        ) ,
      );
          ;
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
