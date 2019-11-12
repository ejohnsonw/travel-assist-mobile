import 'package:device_info/device_info.dart';
import 'dart:io';

class DeviceInfo {
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  static String deviceId = null;


  static Future<String> getDeviceInformation(){
    if (Platform.isAndroid) {
      try {
        if (androidInfo == null) {
          return _getAndroidDeviceInfo();
        }
      } on Exception {}
    }
    if (Platform.isIOS) {
      try {
        if (iosInfo == null) {
          return _get_iOS_DeviceInfo();
        }
      } on Exception {}
    }
    return null;
  }

   static Future<String> _getAndroidDeviceInfo() async{
    androidInfo = await deviceInfo.androidInfo;
    return androidInfo.androidId;
  }

   static Future<String> _get_iOS_DeviceInfo() async{
    iosInfo =   await deviceInfo.iosInfo;
    deviceId = iosInfo.identifierForVendor;
      return iosInfo.identifierForVendor;
//    return iosInfo;
  }


}
