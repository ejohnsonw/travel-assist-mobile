import 'package:flutter/material.dart';

import 'fade-route.dart';
import 'trip.dart';
import 'stage-search.dart';

class StageItem extends StatelessWidget {
  Map item;

  StageItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: new InkWell(
          onTap: () {
            Navigator.push(
                context,
                FadeRoute(
                    page: StageSearchInfo(stage:this.item)));
          },
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//                      Container(
//                        height: 50,
//                        child: Image.network(
//                            "http://pics.avs.io/150/50/${offer.airline}.png"),
//                      ),
                      Container(
                          height: 44,
                          child: Text("\n"+item['name'].toString(),
                              textAlign: TextAlign.right,
                              style: new TextStyle(
                                  color: Colors.blue, fontSize: 18.0)))
                    ]),
//                Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 10,
//                  decoration: BoxDecoration(
//                    image: DecorationImage(
//                      fit: BoxFit.fitWidth,
//                      image: AssetImage("assets/lines.png"),
//                    ),
//                  ),
//                ),


              ],
            ),
          ])),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(2.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}

class PageItem extends StatelessWidget {
  Map item;

  PageItem({Key key, this.item}) : super(key: key);

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
        tag: "card_det" + item["id"].toString(),
        child: Material(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(child: Text(item["title"])),
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
