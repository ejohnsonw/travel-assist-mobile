import 'app-config.dart';
import 'main.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Build flavors PROD',
    flavorName: 'production',
    apiBaseUrl: 'https://backend.travelful.co:8050',
    travelAssistUrl: 'https://backend-api--apicast-production.amp.hackathon.rhmi.io:443/',
    websocketBaseUrl: 'wss://backend.travelful.co:9087',
    child: new TravelfulApp(),
  );

  runApp(configuredApp);
}