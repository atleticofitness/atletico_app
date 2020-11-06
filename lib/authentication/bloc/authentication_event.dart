part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationStarted { }';
}

class AuthenticationLoggedIn extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationLoggedIn { }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'AuthenticationLoggedOut { }';
}
