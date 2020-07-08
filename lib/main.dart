import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/login/login.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("settings");
  runApp(DevicePreview(
      enabled: !kReleaseMode == false, builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      title: 'atletico',
      debugShowCheckedModeBanner: true,
      home: LoginWidget(),
    );
  }
}
