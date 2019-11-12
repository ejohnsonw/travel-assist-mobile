import 'app-config.dart';
import 'main.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Build flavors DEV',
    flavorName: 'development',
    apiBaseUrl: 'http://localhost:8050',
    websocketBaseUrl: 'ws://localhost:9087',
    child: new TravelfulApp(),
  );

  runApp(configuredApp);
}
