import 'package:atletico_app/loggedin/home.dart';
import 'package:atletico_app/login/login.dart';
import 'package:atletico_app/signup/singup.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(pathPrefix: "/app/v1", routes: <AutoRoute>[
  MaterialRoute(path: "/", page: LoginWidget, initial: true),
  MaterialRoute(path: "/signup", page: SignUpWidget),
  //MaterialRoute(path: "/confirm_email", page: SignUpWidget),
  MaterialRoute(path: "/landing", page: HomeWidget)
])
class $Router {}
