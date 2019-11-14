import 'package:flutter/material.dart';

import 'itinerary.dart';
import 'trip-tile.dart';
import 'city-view-model.dart';
import 'fade-route.dart';
import 'itinerary-detail.dart';

class ItineraryTile extends StatelessWidget {
  Itinerary offer;
  Map search;

  ItineraryTile({Key key, this.offer, this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new InkWell(
          onTap: () {
            Navigator.push(
                context,
                FadeRoute(
                    page: ItineraryDetail(offer:offer,search:search)));
          },
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Image.network(
                            "http://pics.avs.io/150/50/${offer.airline}.png"),
                      ),
                      Container(
                          height: 24,
                          child: Text(offer.price.toString(),
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  color: Colors.blue, fontSize: 18.0)))
                    ]),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/lines.png"),
                    ),
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: offer.trips.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TripTile(
                        trip: offer.trips[index],
                        search: search,
                        idx: index,
                      );
                    }),
//              Material(
//                child: ListTile(
//                  title: Text(this.offer.price.toString()),
//                  subtitle: Text(this.offer.airlineName),
//                ),
//              )
              ],
            ),
          ])),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );

//    return Hero(
//      tag: "card"+offer.id.toString(),
//      child: Card(
//        shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.all(
//            Radius.circular(8.0),
//          ),
//        ),
//        clipBehavior: Clip.antiAliasWithSaveLayer,
//
//        child: Stack(
//          children: <Widget>[
//            Column(
//              children: <Widget>[
//                AspectRatio(
//                  aspectRatio: 189.0 / 150.0,
//                  child:
//                      Image.network("https://travelful.co/assets/images/logos2/${offer.airline}"+".png"),
//                ),
//                Material(
//                  child: ListTile(
//                    title: Text(this.offer.price.toString()),
//                    subtitle: Text(this.offer.airlineName),
//                  ),
//                )
//              ],
//            ),
//            Positioned(
//              left: 0.0,
//              top: 0.0,
//              bottom: 0.0,
//              right: 0.0,
//              child: Material(
//                type: MaterialType.transparency,
//                child: InkWell(
////                  onTap: () async {
////                    await Future.delayed(Duration(milliseconds: 200));
////                    Navigator.push(
////                      context,
////                      MaterialPageRoute(
////                        builder: (context) {
////                          return new PageItem(offer: this.offer);
////                        },
////                        fullscreenDialog: true,
////                      ),
////                    );
////                  },
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
  }
}

class PageItem extends StatelessWidget {
  Itinerary offer;

  PageItem({Key key, this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = new AppBar(
      primary: false,
      leading: IconTheme(
          data: IconThemeData(color: Colors.black), child: CloseButton()),
//      flexibleSpace: Container(
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
//            colors: [
//              Colors.blue.withOpacity(0.4),
//              Colors.black.withOpacity(0.1),
//            ],
//          ),
//        ),
//      ),
      backgroundColor: Colors.transparent,
    );
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(children: <Widget>[
      Hero(
        tag: "card_det" + offer.id.toString(),
        child: Material(
          child: Column(
            children: <Widget>[
//              AspectRatio(
//                aspectRatio: 485.0 / 384.0,
//                child:
//                    Image.network(this.offer.urlAction),
//              ),
//              Material(
//                child: ListTile(
//                  title: Text(this.offer.title),
//                  subtitle: Text(this.offer.description),
//                ),
//              ),
              Expanded(
                child: Center(child: Text(offer.airline)),
              )
            ],
          ),
        ),
      ),
      Column(
        children: <Widget>[
          Container(
            height: mediaQuery.padding.top,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: appBar.preferredSize.height),
            child: appBar,
          )
        ],
      ),
    ]);
  }
}
