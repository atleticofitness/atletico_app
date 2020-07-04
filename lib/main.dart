import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'widgets/login/login.dart';
import 'package:dart_json_mapper_flutter/dart_json_mapper_flutter.dart'
    show flutterAdapter;
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'main.reflectable.dart' show initializeReflectable;
import 'package:device_preview/device_preview.dart';

void main() {
  initializeReflectable();
  JsonMapper().useAdapter(flutterAdapter);
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
