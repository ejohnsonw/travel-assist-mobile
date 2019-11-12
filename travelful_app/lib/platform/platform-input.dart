import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform-base.dart';

class PlatformInput extends PlatformWidget<CupertinoTextField, TextFormField> {
  PlatformInput(
      {Key key,
      this.placeholder,
      this.onSaved,
      this.validator,
      this.controller})
      : super(key: key);
  final String placeholder;
  final FormFieldSetter<dynamic> onSaved;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  @override
  CupertinoTextField buildCupertinoWidget(BuildContext context) {

    return CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: CupertinoColors.inactiveGray,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  @override
  TextFormField buildMaterialWidget(BuildContext context) {
    TextFormField(
      decoration: InputDecoration(labelText: placeholder),
      validator: validator,
      controller: controller,
    );
  }
}
