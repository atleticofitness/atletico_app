import 'package:atletico_app/authentication/bloc/authentication_bloc.dart';
import 'package:atletico_app/authentication/authentication_guard.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/routes/router.gr.dart' as route;
import 'package:atletico_app/util/bloc_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository.users();
  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationStarted());
      },
      child: DevicePreview(
          enabled: !kReleaseMode == false, builder: (context) => MyApp())));
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child) {
          child = ExtendedNavigator<route.Router>(
            router: route.Router(),
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
              ExtendedNavigator.of(context).push(route.Routes.homePageWidget);
            if (state is AuthenticationFailure)
              ExtendedNavigator.of(context).push(route.Routes.loginWidget);

            if (state is AuthenticationInProgress)
              return CircularProgressIndicator();

            return Container();
          },
        ));
  }
}
