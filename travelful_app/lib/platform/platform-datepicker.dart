import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform-base.dart';

class PlatformDatepicker extends PlatformWidget<CupertinoDatePicker, Widget> {

  PlatformDatepicker(
      {Key key,cupertinoDatePickerMode})
      : super(key: key);
  DateTime selectedDate = DateTime.now();
  CupertinoDatePickerMode cupertinoDatePickerMode;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate){
      selectedDate = picked;
    }
  }

  @override
  CupertinoDatePicker buildCupertinoWidget(BuildContext context) {

    return CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      minimumYear: 1900,
      onDateTimeChanged: (value){
        selectedDate = value;
      },
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("${selectedDate.toLocal()}"),
          SizedBox(height: 20.0,),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select date'),
          ),
        ],
      ),
    );
  }
}
