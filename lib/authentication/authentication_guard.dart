import 'package:atletico_app/models/token.dart';
import 'package:auto_route/auto_route.dart';

class AuthenticationGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    return Token.loadToken() == Token();
  }
}
