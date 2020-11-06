// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../authentication/authentication_guard.dart';
import '../loggedin/home.dart';
import '../login/login.dart';
import '../registration/registration.dart';
import '../repositories/user_repository.dart';

class Routes {
  static const String loginWidget = '/';
  static const String registrationWidget = '/registration';
  static const String atleticoWidget = '/atletico';
  static const all = <String>{
    loginWidget,
    registrationWidget,
    atleticoWidget,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginWidget, page: LoginWidget),
    RouteDef(Routes.registrationWidget,
        page: RegistrationWidget, guards: [AuthenticationGuard]),
    RouteDef(Routes.atleticoWidget, page: AtleticoWidget),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginWidget: (data) {
      final args = data.getArgs<LoginWidgetArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginWidget(
          key: args.key,
          userRepository: args.userRepository,
        ),
        settings: data,
      );
    },
    RegistrationWidget: (data) {
      final args = data.getArgs<RegistrationWidgetArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegistrationWidget(
          key: args.key,
          userRepository: args.userRepository,
        ),
        settings: data,
      );
    },
    AtleticoWidget: (data) {
      final args = data.getArgs<AtleticoWidgetArguments>(
        orElse: () => AtleticoWidgetArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => AtleticoWidget(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// LoginWidget arguments holder class
class LoginWidgetArguments {
  final Key key;
  final UserRepository userRepository;
  LoginWidgetArguments({this.key, @required this.userRepository});
}

/// RegistrationWidget arguments holder class
class RegistrationWidgetArguments {
  final Key key;
  final UserRepository userRepository;
  RegistrationWidgetArguments({this.key, @required this.userRepository});
}

/// AtleticoWidget arguments holder class
class AtleticoWidgetArguments {
  final Key key;
  AtleticoWidgetArguments({this.key});
}
