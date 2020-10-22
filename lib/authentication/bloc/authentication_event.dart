part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final Token token;

  const AuthenticationLoggedIn({@required this.token});

  void saveToken() async {
    var box = await Hive.openBox("user_information");
    if (box.containsKey("remember_me")) if (box.get("remember_me"))
      token.save();
  }

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthenticationLoggedIn { token: $token }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
