import 'package:atletico_app/authentication/authentication.dart';
import 'package:atletico_app/data/token.dart';
import 'package:atletico_app/util/bloc_observer.dart';
import 'package:atletico_app/loggedin/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login/login.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("user_information");
  final Token token = Token.loadToken();
  Bloc.observer = SimpleBlocObserver();
  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(token: token)..add(AuthenticationStarted());
      },
      child: DevicePreview(
          enabled: !kReleaseMode == false,
          builder: (context) => MyApp(token: token))));
}

class MyApp extends StatelessWidget {
  final Token token;

  MyApp({Key key, @required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: DevicePreview.of(context).locale,
        builder: DevicePreview.appBuilder,
        title: 'atletico',
        debugShowCheckedModeBanner: true,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess) return HomeWidget();
            if (state is AuthenticationFailure) return LoginWidget();

            if (state is AuthenticationInProgress)
              return CircularProgressIndicator();

            return null;
          },
        ));
  }
}
