import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'photo.dart';
import 'package:http/http.dart' as http;
import 'feed.dart';
import 'tile-item.dart';

class FeedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FeedListState();
  }
}

class FeedListState extends State<FeedList> {
  List<Map> _feedItems = new List();
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Webservice webservice = new Webservice();
  List<Feed> list = List();

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    Map body = new Map();
    var bodyEncoded = json.encode(body);
    Map headers = new Map();
    final response = await http.post(Webservice.baseUrl+"/travelful/feed", body: "{}" , headers: {
      "Content-Type": "application/json"
    },);

    if (response.statusCode == 200) {
      list = (json.decode(utf8.decode(response.bodyBytes)) as List)
          .map((data) => new Feed.fromJson(data))
          .toList();
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
//    webservice
//        .fetchFeed()
//        .then((items) => setState(() => this._feedItems = items));
  _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(
//          title: Text("Fetch Data JSON"),
//        ),
//        bottomNavigationBar: Padding(
//          padding: const EdgeInsets.all(0.0),
//          child: RaisedButton(
//            child: new Text("Fetch Data"),
//            onPressed: _fetchData,
//          ),
//        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(),)
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
            return TileItem(item:list[index]);
//              return Container(
//                width: MediaQuery.of(context).size.width,
//                height: 200,
//                decoration: BoxDecoration(
//                  image: DecorationImage(
//                    fit: BoxFit.cover,
//                    image: NetworkImage(list[index].urlAction),
//                  ),
//                ),
//                alignment: Alignment.bottomCenter,
//                padding: EdgeInsets.only(bottom: 10),
//                child: Text(
//                  list[index].title,
//                  style: Theme.of(context)
//                      .textTheme
//                      .display1
//                      .copyWith(color: Colors.black),
//                ),
//              );


//              return Column(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                mainAxisSize: MainAxisSize.min,
//                children: <Widget>[
//                  Card(
//                    elevation: 18.0,
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                    child: Image.network(
//                      list[index].urlAction,
//                      fit: BoxFit.cover,
//                      height: 200.0,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    clipBehavior: Clip.antiAlias,
//                    margin: EdgeInsets.all(8.0),
//                  ),
//                  Text(
//                    list[index].title,
//                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//                  )
//                ],
//              );


            }));
  }
}
