import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'home.dart';
import 'dart:async';
import 'restartapp.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/foundation.dart';

final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(Platform.isIOS){
    await Firebase.initializeApp();
    const androidInitializationSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
    const iosNotificatonDetail = DarwinNotificationDetails();
    const notificationDetails = NotificationDetails(
      iOS: iosNotificatonDetail,
    );
    _flutterLocalNotificationsPlugin.show(0, "Bloomfame Invitation", "You have a new business request", notificationDetails);
  }
  else{
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBz5gTFIakI7z35mp3oj4ZYlLx8m6v_nz4",
          authDomain: "bloomfame-ny.firebaseapp.com",
          databaseURL: "https://bloomfame-ny-default-rtdb.firebaseio.com",
          projectId: "bloomfame-ny",
          storageBucket: "bloomfame-ny.appspot.com",
          messagingSenderId: "761436799936",
          appId: "1:761436799936:web:d9134a155bd5fedf2c7e25"
      ),
    );
    showNotification("Bloomfame Invitation", "You have a new business request");
  }
}

const kWebRecaptchaSiteKey = '6Lemcn0dAAAAABLkf6aiiHvpGD6x-zF3nOSDU2M8';
Future<void> showNotification(String title, String message) async {
  const platform = MethodChannel('com.stratusacumen.bloomfame/notifications');
  try {
    await platform.invokeMethod('showNotification', {
      'title': title,
      'message': message,
    });
  } on PlatformException catch (e) {
    print("Failed to show notification: '${e.message}'.");
  }
}
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if(Platform.isIOS){
    await Firebase.initializeApp();
    late FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  else{
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBz5gTFIakI7z35mp3oj4ZYlLx8m6v_nz4",
          authDomain: "bloomfame-ny.firebaseapp.com",
          databaseURL: "https://bloomfame-ny-default-rtdb.firebaseio.com",
          projectId: "bloomfame-ny",
          storageBucket: "bloomfame-ny.appspot.com",
          messagingSenderId: "761436799936",
          appId: "1:761436799936:web:d9134a155bd5fedf2c7e25"
      ),
    );
  }
  await FirebaseAppCheck.instance.activate();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  processStart();
}
void processStart()async{
  Wakelock.toggle(enable: true);
  runApp(
    const RestartWidget(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  static const String _title = 'Bloomfame';
  static Map<int, Color> colorMat = {
    50: const Color.fromRGBO(0, 0, 37, .1),
    100: const Color.fromRGBO(0, 0, 37, .2),
    200: const Color.fromRGBO(0, 0, 37, .3),
    300: const Color.fromRGBO(0, 0, 37, .4),
    400: const Color.fromRGBO(0, 0, 37, .5),
    500: const Color.fromRGBO(0, 0, 37, .6),
    600: const Color.fromRGBO(0, 0, 37, .7),
    700: const Color.fromRGBO(0, 0, 37, .8),
    800: const Color.fromRGBO(0, 0, 37, .9),
    900: const Color.fromRGBO(0, 0, 37, 1),
  };
  static MaterialColor colorB = MaterialColor(0xFF000000, colorMat);
  final Color darkBlue = const Color(0xff000000);

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
        primarySwatch: colorB,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}