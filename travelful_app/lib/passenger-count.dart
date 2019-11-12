import 'package:flutter/material.dart';
import 'package:Travelful/autocomplete_textfield.dart';
import 'airport-view-model.dart';
import 'city.dart';

class PassengerCount extends StatefulWidget {
  PassengerCount();
  _PassengerCountState _state;

  @override
  _PassengerCountState createState()  {
    _state = new _PassengerCountState();
    return _state;
  }

  _PassengerCountState get state => _state;
}

class _PassengerCountState extends State<PassengerCount> {
  int adults = 1;
  int children = 0;
  int infants = 0;



  _PassengerCountState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.people),
            tooltip: 'Increase volume by 10',
            onPressed: () {
              setState(() {
                if (adults > 8) {
                  adults = 0;
                }
                adults += 1;
              });
            },
          ),
          Text('Adults : $adults'),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              setState(() {
                if (children > 8) {
                  children = -1;
                }
                children += 1;
              });
            },
          ),
          Text('Children : $children'),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {
              setState(() {
                if (infants > 8) {
                  infants = -1;
                }
                infants += 1;
              });
            },
          ),
          Text('Infants : $infants')
        ]);
  }
}
