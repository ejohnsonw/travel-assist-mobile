import 'package:flutter/material.dart';

import 'fade-route.dart';
import 'trip.dart';

class TileItem extends StatelessWidget {
  Map item;

  TileItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.network(this.item["mediaUrl"]),
//            Material(
//              child: ListTile(
//                title: Text(this.item.title),
//                subtitle: Text(this.item.description),
//              ),
//            )
          ],
        ),
        Positioned(
            left: 0.0,
            top: 10.0,
            bottom: 0.0,
            right: 0.0,
            child: Text(this.item["title"],
                style: new TextStyle(color: Colors.black, fontSize: 100))),
        Positioned(
          left: 0.0,
          top: 1.0,
          bottom: 0.0,
          right: 0.0,
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () async {
                await Future.delayed(Duration(milliseconds: 200));
                Navigator.push(context, FadeRoute(page: Trip()));
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return new PageItem(item: this.item);
//                        },
//                        fullscreenDialog: true,
//                      ),
//                    );
              },
            ),
          ),
        ),
      ],
    );

//    return Hero(
//      tag: "card"+item.id.toString(),
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
//                  aspectRatio: 485.0 / 384.0,
//                  child:
//                      Image.network(this.item.urlAction),
//                ),
//                Material(
//                  child: ListTile(
//                    title: Text(this.item.title),
//                    subtitle: Text(this.item.description),
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
//                  onTap: () async {
//                    await Future.delayed(Duration(milliseconds: 200));
//                    Navigator.push(
//                        context,
//                        FadeRoute(
//                            page: Trip()));
////                    Navigator.push(
////                      context,
////                      MaterialPageRoute(
////                        builder: (context) {
////                          return new PageItem(item: this.item);
////                        },
////                        fullscreenDialog: true,
////                      ),
////                    );
//                  },
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
