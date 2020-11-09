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

class Routes {
  static const String loginWidget = '/';
  static const String homePageWidget = '/home';
  static const String registrationWidget = '/registration';
  static const all = <String>{
    loginWidget,
    homePageWidget,
    registrationWidget,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginWidget, page: LoginWidget),
    RouteDef(Routes.homePageWidget, page: HomePageWidget),
    RouteDef(Routes.registrationWidget,
        page: RegistrationWidget, guards: [AuthenticationGuard]),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoginWidget: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginWidget(),
        settings: data,
      );
    },
    HomePageWidget: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomePageWidget(),
        settings: data,
      );
    },
    RegistrationWidget: (data) {
      final args = data.getArgs<RegistrationWidgetArguments>(
        orElse: () => RegistrationWidgetArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => RegistrationWidget(key: args.key),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// RegistrationWidget arguments holder class
class RegistrationWidgetArguments {
  final Key key;
  RegistrationWidgetArguments({this.key});
}
