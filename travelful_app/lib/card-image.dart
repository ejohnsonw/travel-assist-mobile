import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  String imageUrl;
  CardWithImage(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 200.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(2.0),
    );
  }


}