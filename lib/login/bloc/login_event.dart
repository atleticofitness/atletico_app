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

  FormStatus validate() {
    if (email.isEmpty) return FormStatus.undecided;
    if (!email.contains("@")) return FormStatus.inprogress;
    if (!email.contains(".")) return FormStatus.inprogress;
    if (!validator.email(email)) return FormStatus.invalid;
    return FormStatus.complete;
  }
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

  FormStatus validate() {
    if (password.isEmpty) return FormStatus.undecided;
    if (password.length < 8) return FormStatus.inprogress;
    if (!validator.password(password)) return FormStatus.invalid;
    return FormStatus.complete;
  }
}

class LoginRememberMeForm extends LoginEvent {
  final bool rememberMe;

  const LoginRememberMeForm({@required this.rememberMe});

  void saveRememberMe() {
    var box = Hive.box("user_information");
    box.put("remember_me", rememberMe);
  }

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
}

class LoginWithApple extends LoginEvent {
  const LoginWithApple();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginWithApple Pressed { }';
}

class LoginWithGoogle extends LoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginWithGoogle Pressed {}';
}

class LoginWithFacebook extends LoginEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'LoginWithFacebook Pressed {}';
}
