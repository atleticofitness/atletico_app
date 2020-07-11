// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/signup/singup.dart';
import 'package:atletico_app/loggedin/home.dart';

class Routes {
  static const String loginWidget = '/';
  static const String signUpWidget = '/signup';
  static const String homeWidget = '/landing';
  static const all = <String>{
    loginWidget,
    signUpWidget,
    homeWidget,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginWidget, page: LoginWidget),
    RouteDef(Routes.signUpWidget, page: SignUpWidget),
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
    SignUpWidget: (RouteData data) {
      var args = data.getArgs<SignUpWidgetArguments>(
          orElse: () => SignUpWidgetArguments());
      return MaterialPageRoute<dynamic>(
        builder: (context) => SignUpWidget(key: args.key),
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

//SignUpWidget arguments holder class
class SignUpWidgetArguments {
  final Key key;
  SignUpWidgetArguments({this.key});
}

//HomeWidget arguments holder class
class HomeWidgetArguments {
  final Key key;
  HomeWidgetArguments({this.key});
}
