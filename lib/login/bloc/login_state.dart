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
  final FormStatus emailStatus;
  final FormStatus passwordStatus;

  const LoginFormState(
      {this.email = "",
      this.password = "",
      this.rememberMe = false,
      this.obscured = true,
      this.emailStatus,
      this.passwordStatus});

  LoginFormState copyWith(
          {String email,
          String password,
          bool rememberMe,
          bool obscured,
          FormStatus emailStatus,
          FormStatus passwordStatus}) =>
      LoginFormState(
          email: email ?? this.email,
          password: password ?? this.password,
          rememberMe: rememberMe ?? this.rememberMe,
          obscured: obscured ?? this.obscured,
          emailStatus: emailStatus ?? this.emailStatus,
          passwordStatus: passwordStatus ?? this.passwordStatus);

  @override
  List<Object> get props =>
      [email, password, rememberMe, obscured, emailStatus, passwordStatus];
}
