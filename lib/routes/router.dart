import 'package:atletico_app/authentication/authentication_guard.dart';
import 'package:atletico_app/loggedin/home.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/registration/registration.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(pathPrefix: "/app/v1", routes: <AutoRoute>[
  MaterialRoute(path: "/", page: LoginWidget),
  MaterialRoute(path: "/home", page: HomepageWidget),
  MaterialRoute(
      path: "/registration",
      page: RegistrationWidget,
      guards: [AuthenticationGuard]),
])
class $Router {}
