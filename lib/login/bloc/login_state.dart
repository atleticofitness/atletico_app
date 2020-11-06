part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginFormState extends LoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool obscured;
  final bool isLoggedIn;
  final FormStatus emailStatus;
  final FormStatus passwordStatus;

  const LoginFormState(
      {this.email = "",
      this.password = "",
      this.rememberMe = false,
      this.obscured = true,
      this.isLoggedIn = false,
      this.emailStatus,
      this.passwordStatus});

  bool get isValid =>
      emailStatus == FormStatus.valid && passwordStatus == FormStatus.valid;

  LoginFormState copyWith(
          {String email,
          String password,
          bool rememberMe,
          bool obscured,
          bool isLoggedIn,
          FormStatus emailStatus,
          FormStatus passwordStatus}) =>
      LoginFormState(
          email: email ?? this.email,
          password: password ?? this.password,
          rememberMe: rememberMe ?? this.rememberMe,
          obscured: obscured ?? this.obscured,
          isLoggedIn: isLoggedIn ?? this.isLoggedIn,
          emailStatus: emailStatus ?? this.emailStatus,
          passwordStatus: passwordStatus ?? this.passwordStatus);

  @override
  List<Object> get props => [
        email,
        password,
        rememberMe,
        obscured,
        isLoggedIn,
        emailStatus,
        passwordStatus
      ];
}
