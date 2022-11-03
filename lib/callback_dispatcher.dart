import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'keys.dart';
import 'location_dto.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  const MethodChannel _backgroundChannel =
      MethodChannel(Keys.BACKGROUND_CHANNEL_ID);
  WidgetsFlutterBinding.ensureInitialized();

  _backgroundChannel.setMethodCallHandler((MethodCall call) async {

    print("PUNTOO: methodCallHandler ${call.method}, ${call.arguments.toString()}");
    print("PUNTOO: methodCallHandler ${Keys.BCM_SEND_LOCATION == call.method ? 'isSendLocation = true' : 'isSendLocation = false'}");


    if (Keys.BCM_SEND_LOCATION == call.method) {
      final Map<dynamic, dynamic> args = call.arguments;

      print("PUNTOO: Before callback function created");
      final Function? callback = PluginUtilities.getCallbackFromHandle(
          CallbackHandle.fromRawHandle(args[Keys.ARG_CALLBACK]));


      print("PUNTOO: After callback function created - Callback: ${callback == null ? '0' : '1'}");

      final LocationDto location =
          LocationDto.fromJson(args[Keys.ARG_LOCATION]);

      print("PUNTOO: methodCallHandler - Callback: ${callback == null ? '0' : '1'} - location: ${location.toJson()}");

      callback!(location);
    } else if (Keys.BCM_NOTIFICATION_CLICK == call.method) {
      final Map<dynamic, dynamic> args = call.arguments;
      final Function? notificationCallback =
          PluginUtilities.getCallbackFromHandle(CallbackHandle.fromRawHandle(
              args[Keys.ARG_NOTIFICATION_CALLBACK]));
      if (notificationCallback != null) {
        notificationCallback();
      }
    } else if (Keys.BCM_INIT == call.method) {
      final Map<dynamic, dynamic> args = call.arguments;
      final Function? initCallback = PluginUtilities.getCallbackFromHandle(
          CallbackHandle.fromRawHandle(args[Keys.ARG_INIT_CALLBACK]));
      Map<dynamic, dynamic>? data = args[Keys.ARG_INIT_DATA_CALLBACK];
      if (initCallback != null) {
        initCallback(data);
      }
    } else if (Keys.BCM_DISPOSE == call.method) {
      final Map<dynamic, dynamic> args = call.arguments;
      final Function? disposeCallback = PluginUtilities.getCallbackFromHandle(
          CallbackHandle.fromRawHandle(args[Keys.ARG_DISPOSE_CALLBACK]));
      if (disposeCallback != null) {
        disposeCallback();
      }
    }
  });
  _backgroundChannel.invokeMethod(Keys.METHOD_SERVICE_INITIALIZED);
}
