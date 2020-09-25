import 'package:atletico_app/authentication/authentication_guard.dart';
import 'package:atletico_app/authentication/bloc/authentication.dart';
import 'package:atletico_app/data/token.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:atletico_app/util/bloc_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
        builder: (context, child) {
          child = ExtendedNavigator<Router>(
            router: Router(),
            guards: [AuthenticationGuard()],
          );
          child = DevicePreview.appBuilder(context, child);
          return child;
        },
        locale: DevicePreview.of(context).locale,
        title: 'atletico',
        debugShowCheckedModeBanner: true,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationSuccess)
              ExtendedNavigator.of(context).pushNamed(Routes.atleticoWidget);
            if (state is AuthenticationFailure)
              ExtendedNavigator.of(context).pushNamed(Routes.loginWidget);

            if (state is AuthenticationInProgress)
              return CircularProgressIndicator();

            return Container();
          },
        ));
  }
}
