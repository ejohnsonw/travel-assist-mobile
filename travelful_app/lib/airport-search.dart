import 'package:flutter/material.dart';
import 'package:Travelful/autocomplete_textfield.dart';
import 'airport-view-model.dart';
import 'city.dart';

class AirportSearch extends StatefulWidget {
  String title;

  AirportSearch({this.title});

  @override
  _AirportSearchState createState() =>
      new _AirportSearchState(title: this.title);
}

class _AirportSearchState extends State<AirportSearch> {
  GlobalKey<AutoCompleteTextFieldState<Airport>> key = new GlobalKey();

  AutoCompleteTextField searchTextField;

  TextEditingController controller = new TextEditingController();
  String title;

  _AirportSearchState({this.title});

  void _loadData(String criteria) async {
    await AirportsViewModel.loadAirports(criteria);
    searchTextField.updateSuggestions(AirportsViewModel.airports);
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(this.textChanged());
    _loadData("");
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 13.0;
    searchTextField = AutoCompleteTextField<Airport>(
        style: new TextStyle(color: Colors.black, fontSize: fontSize),
        decoration: new InputDecoration(
            suffixIcon: Container(
              width: 85.0,
              height: 60.0,
            ),
            contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
            filled: true,
            hintText: this.title,
            hintStyle: TextStyle(color: Colors.black)),
        itemSubmitted: (item) {
          setState(() => searchTextField.textField.controller.text = "[${item.code}] ${item.name}, \n${item.city}, ${item.country}");
        },
        suggestionsAmount: 10,
        onFocusChanged: (hasFocus) {},
        textChanged:(criteria){
          this._loadData(criteria);

        },
        clearOnSubmit: false,
//        controller: controller,
        key: key,
        suggestions: AirportsViewModel.airports,
        itemBuilder: (context, item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "[${item.code}] ${item.name}, \n${item.city}, ${item.country}",
                style: TextStyle(fontSize: fontSize),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
//                Text(
//                  item.country,
//                )
            ],
          );
        },
        itemSorter: (a, b) {
          return a.name.compareTo(b.name);
        },
        itemFilter: (item, query) {
          return true;
        });


    return new Column(children: <Widget>[searchTextField]);
  }

  textChanged() {
    this._loadData(controller.text);
  }
}
