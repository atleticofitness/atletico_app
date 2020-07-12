import 'package:atletico_app/loggedin/home.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/registration/singup.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(pathPrefix: "/app/v1", routes: <AutoRoute>[
  MaterialRoute(path: "/", page: LoginWidget, initial: true),
  MaterialRoute(path: "/registration", page: RegistrationWidget),
  //MaterialRoute(path: "/confirm_email", page: RegistrationWidget),
  MaterialRoute(path: "/landing", page: HomeWidget)
])
class $Router {}
