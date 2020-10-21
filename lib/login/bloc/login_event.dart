part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailForm extends LoginEvent {
  final String email;

  const LoginEmailForm({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'LoginEmailForm Pressed { email: $email }';
}

class LoginPasswordForm extends LoginEvent {
  final String password;
  final bool obscured;

  const LoginPasswordForm({this.password, this.obscured});

  @override
  List<Object> get props => [password, obscured];

  @override
  String toString() =>
      'LoginPasswordForm Pressed { password: $password, obscured: $obscured }';
}

class LoginRememberMeForm extends LoginEvent {
  final bool rememberMe;

  const LoginRememberMeForm({@required this.rememberMe});

  @override
  List<Object> get props => [rememberMe];

  @override
  String toString() =>
      'LoginRememberMeForm Pressed { rememberMe: $rememberMe }';
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButton Pressed { email: $email, password: $password }';

  void submitInfo() {
    if (email.isEmpty) return;
    if (!email.contains("@")) return;
    if (!email.contains(".")) return;
    if (!validator.email(email)) return;
    if (password.isEmpty) return;
    if (!validator.password(password)) return;
    //Process login
  }
}
