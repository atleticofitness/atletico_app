import 'package:atletico_app/util/constants.dart';
import 'package:auto_route/auto_route.dart';

class AuthenticationGuard extends RouteGuard {
  @override
  Future<bool> canNavigate(ExtendedNavigatorState navigator, String routeName,
      Object arguments) async {
    return !isSignedIn();
  }
}
