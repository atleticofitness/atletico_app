// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/registration/registration.dart';
import 'package:atletico_app/authentication/authentication_guard.dart';
import 'package:atletico_app/loggedin/home.dart';

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
    LoginWidget: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginWidget(),
        settings: data,
      );
    },
    RegistrationWidget: (RouteData data) {
      var args = data.getArgs<RegistrationWidgetArguments>(
          orElse: () => RegistrationWidgetArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegistrationWidget(key: args.key),
        settings: data,
      );
    },
    AtleticoWidget: (RouteData data) {
      var args = data.getArgs<AtleticoWidgetArguments>(
          orElse: () => AtleticoWidgetArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => AtleticoWidget(key: args.key),
        settings: data,
      );
    },
  };
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//RegistrationWidget arguments holder class
class RegistrationWidgetArguments {
  final Key key;
  RegistrationWidgetArguments({this.key});
}

//AtleticoWidget arguments holder class
class AtleticoWidgetArguments {
  final Key key;
  AtleticoWidgetArguments({this.key});
}
