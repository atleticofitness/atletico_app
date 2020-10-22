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

  bool isValid() {
    if (email.isEmpty) return false;
    if (!email.contains("@")) return false;
    if (!email.contains(".")) return false;
    if (!validator.email(email)) return false;
    if (password.isEmpty) return false;
    if (!validator.password(password)) return false;
    return true;
  }

  Future<Token> getAndSaveToken() async {
    Token token = await getToken(email: email, password: password);
    saveToken(token);
    return token;
  }

  void saveToken(Token token) {
    var box = Hive.box("user_information");
    if (box.containsKey("remember_me")) {
      if (box.get("remember_me"))
        box.put("token_data", token.toJson());
    }
  }

}
