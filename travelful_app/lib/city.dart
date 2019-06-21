import 'package:flutter/material.dart';
import 'package:Travelful/autocomplete_textfield.dart';
import 'city-view-model.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'city-view-model.dart';

class CitySearch extends StatefulWidget {
  StreamController citySelectedController;
  String title;
  bool showImage = false;

  CitySearch({this.title, this.showImage, this.citySelectedController});

  _CitySearchState _state;

  @override
  _CitySearchState createState() {
    _state = new _CitySearchState(title: this.title, showImage: this.showImage,citySelectedController: citySelectedController);
    return _state;
  }

  _CitySearchState get state => _state;
}

class _CitySearchState extends State<CitySearch> {
  GlobalKey<AutoCompleteTextFieldState<City>> key = new GlobalKey();
  StreamController citySelectedController;
  City selectedCity;
  CitySearch parent;
  AutoCompleteTextField searchTextField;
  bool showImage = false;
  bool isCitySelected = false;
  String _bottomTextValue = "";
  String _imageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png";
  TextEditingController controller = new TextEditingController();
  String title;
  Text bottomText;
  Image cardImage;
  Card cardWithImage;

  _CitySearchState({this.title,this.showImage,this.citySelectedController});

  @override
  void initState() {
    super.initState();
    controller.addListener(this.textChanged());
    _loadData("");
  }

  changeStateUI(item) {
    searchTextField.textField.controller.text =
        "${item.name}, ${item.adminName} ${item.countryISO3}";
    _imageUrl = item.imageUrl != null
        ? item.imageUrl
        : "https://upload.wikimedia.org/wikipedia/commons/c/ca/1x1.png";
    selectedCity = item;


    if(citySelectedController != null){
      citySelectedController.add(new DestinationCitySelected(city:selectedCity));
      if(showImage){
        isCitySelected = true;
      }
    }
    CitysViewModel.loadAirports(selectedCity).then((response) {
      if (response.statusCode == 200) {
        selectedCity = City.fromJson( json.decode(utf8.decode(response.bodyBytes)));

      } else {
        //throw Exception('Failed to load citys');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 13.0;

    cardImage = Image.network(
      _imageUrl,
      fit: BoxFit.cover,
      height: 200.0,
      width: MediaQuery.of(context).size.width,
    );

    bottomText = Text(
      _bottomTextValue,
      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    );

    searchTextField = AutoCompleteTextField<City>(
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
          setState(() => changeStateUI(item));
        },
        suggestionsAmount: 10,
        onFocusChanged: (hasFocus) {},
        textChanged: (criteria) {
          this._loadData(criteria);
        },
        clearOnSubmit: false,
//        controller: controller,
        key: key,
        suggestions: CitysViewModel.citys,
        itemBuilder: (context, item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "${item.name}, ${item.adminName} ${item.countryISO3}",
                style: TextStyle(fontSize: fontSize),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
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



    return new Column(children: <Widget>[
      searchTextField,
      getImage(),
//      bottomText,
    ]);
  }

  Widget getImage(){
     cardWithImage = Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: cardImage,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(2.0),
    );
    if(isCitySelected){
      return cardWithImage;
    }else{
      return Container();
    }
  }

  void _loadData(String criteria) async {
    await CitysViewModel.loadCitys(criteria);
    searchTextField.updateSuggestions(CitysViewModel.citys);
  }

  textChanged() {
    this._loadData(controller.text);
  }
}

class DestinationCitySelected {
  City city;
  DestinationCitySelected({this.city});
}