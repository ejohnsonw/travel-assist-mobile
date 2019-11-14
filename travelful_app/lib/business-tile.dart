import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'platform/platform-input.dart';
import 'platform/platform-datepicker.dart';


class BusinessTile extends StatefulWidget {
  Map business;

  BusinessTile({this.business});

  @override
  State<StatefulWidget> createState() {
    return new BusinessTileState(business: business);
  }
}

class BusinessTileState extends State<BusinessTile> {
  Map business;

  BusinessTileState({this.business});

  int _gender = -1;

  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  final _biggerFont = const TextStyle(fontSize: 22.0, fontFamily: "RobotoMono-Medium");
  Webservice webservice = new Webservice();

  @override
  initState() {
    super.initState();
//  _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return Hero(
      tag: "card" + business['id'].toString(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: mediaQuery.padding.top + 0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child:
//                        Image.network("http://pics.avs.io/150/50/${offer.airline}.png"),
                        Image.network("https://quos.s3.amazonaws.com/"+business['photo'],height: 75,),

                      ),
                      Container(
                          height: 24,
                          child: Text(business['businessName'],
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  color: Colors.blue, fontSize: 18.0)))
                    ]),

//                Material(
//                  child: ListTile(
//                    title: Text(this.offer.price.toString()),
//                    subtitle: Text(this.offer.airlineName),
//                  ),
//                )
//                ListView.builder(
//                    padding: EdgeInsets.all(5.0),
//                    shrinkWrap: true,
//                    physics: ClampingScrollPhysics(),
//                    itemCount: offer.trips.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      return Column(
//                        children: <Widget>[
//                          TripTileDetail(
//                            trip: offer.trips[index],
//                            departureCity: search["departureCity"],
//                            arrivalCity: search["arrivalCity"],
//                            idx: index,
//                          ),
//                          Container(
//                            height: 10,
//                          )
//                        ],
//                      );
//                    }),
//                Container(
//                  width: MediaQuery.of(context).size.width-10,
//                    child: PlatformButton(
//                        color: Colors.blueAccent,
//                        onPressed: () async {
//                      Navigator.push(
//                          context,
//                          FadeRoute(
//                              page: BookFlight(search:search,offer: offer)));
//                        },
//                        child: new Text("Book this flight")))
              ],
            ),

//            Column(
//              children: <Widget>[
//                Container(
//                  height: mediaQuery.padding.top,
//                ),
//                ConstrainedBox(
//                  constraints:
//                      BoxConstraints(maxHeight: appBar.preferredSize.height),
//                  child: appBar,
//                )
//              ],
//            ),
          ],
        ),
      ),
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _gender = value;

//      switch (_radioValue1) {
//        case 0:
//          Fluttertoast.showToast(
//              msg: 'Correct !', toastLength: Toast.LENGTH_SHORT);
//          break;
//        case 1:
//          Fluttertoast.showToast(
//              msg: 'Try again !', toastLength: Toast.LENGTH_SHORT);
//          break;
//        case 2:
//          Fluttertoast.showToast(
//              msg: 'Try again !', toastLength: Toast.LENGTH_SHORT);
//          break;
//      }
    });
  }
}
