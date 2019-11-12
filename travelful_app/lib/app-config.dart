import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'device-info.dart';

class AppConfig extends InheritedWidget {

  AppConfig({
    @required this.appName,
    @required this.flavorName,
    @required this.apiBaseUrl,
    @required this.websocketBaseUrl,
    @required Widget child,
  }) : super(child: child);

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
  final String websocketBaseUrl;

  DeviceInfo di = new DeviceInfo();
  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}