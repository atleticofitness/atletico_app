// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/registration/singup.dart';
import 'package:atletico_app/loggedin/home.dart';

class Routes {
  static const String loginWidget = '/';
  static const String RegistrationWidget = '/registration';
  static const String homeWidget = '/landing';
  static const all = <String>{
    loginWidget,
    RegistrationWidget,
    homeWidget,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginWidget, page: LoginWidget),
    RouteDef(Routes.RegistrationWidget, page: RegistrationWidget),
    RouteDef(Routes.homeWidget, page: HomeWidget),
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
    HomeWidget: (RouteData data) {
      var args = data.getArgs<HomeWidgetArguments>(
          orElse: () => HomeWidgetArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeWidget(key: args.key),
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

//HomeWidget arguments holder class
class HomeWidgetArguments {
  final Key key;
  HomeWidgetArguments({this.key});
}
