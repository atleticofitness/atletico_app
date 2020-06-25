import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'package:dart_json_mapper_flutter/dart_json_mapper_flutter.dart' show flutterAdapter;
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper;
import 'main.reflectable.dart' show initializeReflectable;

void main() {
  initializeReflectable();
  JsonMapper().useAdapter(flutterAdapter);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'atletico',
      debugShowCheckedModeBanner: true,
      home: LoginScreen(),
    );
  }
}
