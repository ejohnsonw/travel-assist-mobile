import 'app-config.dart';
import 'main.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = new AppConfig(
    appName: 'Build flavors PROD',
    flavorName: 'production',
    apiBaseUrl: 'https://backend.travelful.co:8050',
    travelAssistUrl: 'https://travel-assist-evals28-shared-6494.apps.hackathon.rhmi.io/travel-assist/',
    websocketBaseUrl: 'wss://backend.travelful.co:9087',
    child: new TravelfulApp(),
  );

  runApp(configuredApp);
}