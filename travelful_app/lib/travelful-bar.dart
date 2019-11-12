import 'package:flutter/material.dart';


class TravelfulApplicationBar extends StatelessWidget
    implements PreferredSizeWidget {
  GlobalKey _keyLogo = GlobalKey();
  final double height;

  String title;

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        //throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  TravelfulApplicationBar({Key key, this.height, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = new Color(hexToInt("FF3D5191"));
    double width = MediaQuery.of(context).size.width;


    Image logo = Image.network(
      "https://www.travelful.co/assets/images/travelfulLogo2.png",
      fit: BoxFit.fitHeight,
      key: _keyLogo,
      height: 35.0,
      width: MediaQuery.of(context).size.width/2,
    );
    double ml = ( logo.width/2);

    return Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, color],
            ),
          ),
          height: height,
          child: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
              title,
              style: TextStyle(
                  fontFamily: 'NothingYouCouldDo', fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
            top: (height/2) - 15,
            left: ml,
            child: logo,)
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
