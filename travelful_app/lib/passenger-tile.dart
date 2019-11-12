import 'dart:convert';
import 'package:flutter/material.dart';
import 'webservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'platform/platform-input.dart';
import 'platform/platform-datepicker.dart';

import 'passenger.dart';

class PassengerTile extends StatefulWidget {
  Passenger passenger;

  PassengerTile({this.passenger});

  @override
  State<StatefulWidget> createState() {
    return new PassengerTileState(passenger: passenger);
  }
}

class PassengerTileState extends State<PassengerTile> {
  Passenger passenger;

  PassengerTileState({this.passenger});

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
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,

        ),
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
        Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Passenger ${passenger.id}",
                    style: _biggerFont,
                  ),
                  Container(
                      height: 55,
                      padding: EdgeInsets.all(6),
                      child: PlatformInput(
                        placeholder: "First name",
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name';
                          }
                        },
                        onSaved: (val) =>
                            setState(() => passenger.firstName = val),
                      )),
                  Container(
                      height: 55,
                      padding: EdgeInsets.all(6),
                      child: PlatformInput(
                          placeholder: 'Middle Name',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your middle name.';
                            }
                          },
                          onSaved: (val) =>
                              setState(() => passenger.middleName = val))),
                  Container(
                      height: 55,
                      padding: EdgeInsets.all(6),
                      child: PlatformInput(
                          placeholder: 'Last name',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your last name.';
                            }
                          },
                          onSaved: (val) =>
                              setState(() => passenger.lastName = val))),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: _gender,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text(
                        'Female',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: _gender,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text(
                        'Male',
                        style: new TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      new Radio(
                        value: 2,
                        groupValue: _gender,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text(
                        'Other',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Date of Birth",
                        style: _biggerFont,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-30,
                        child: PlatformDatepicker(),
                        height: 100,
                      )
                    ],
                  )
                ]))
      ],
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
