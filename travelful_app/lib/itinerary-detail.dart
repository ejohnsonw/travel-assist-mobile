import 'package:flutter/material.dart';

import 'itinerary.dart';
import 'trip-tile-detail.dart';
import 'travelful-bar.dart';
import 'book-flight.dart';
import 'fade-route.dart';
import 'platform/platform-button.dart';

class ItineraryDetail extends StatelessWidget {
  Itinerary offer;
  Map search;

  ItineraryDetail({Key key, this.offer, this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    AppBar appBar = new AppBar(
      primary: false,
      leading: IconTheme(
          data: IconThemeData(color: Colors.black), child: CloseButton()),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.4),
              Colors.black.withOpacity(0.1),
            ],
          ),
        ),
      ),
      backgroundColor: Color(TravelfulApplicationBar.hexToInt("FF3D5191")),
    );

    return Hero(
      tag: "card" + offer.id.toString(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: 50,
                        child:
//                        Image.network("http://pics.avs.io/150/50/${offer.airline}.png"),
                          Image.network("https://quos.s3.amazonaws.com/advertising/bento/airmaginary.png"),

                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: 24,
                          child: Text("Price: \$"+offer.price.toString(),
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
                ListView.builder(
                    padding: EdgeInsets.all(5.0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: offer.trips.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          TripTileDetail(
                            trip: offer.trips[index],
                            departureCity: search["departureCity"],
                            arrivalCity: search["arrivalCity"],
                            idx: index,
                          ),
                          Container(
                            height: 10,
                          )
                        ],
                      );
                    }),
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
}
