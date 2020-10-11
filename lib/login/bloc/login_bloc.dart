import 'dart:async';

import 'package:atletico_app/authentication/bloc/authentication.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/endpoints/authentication/atletico.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        if (event.email.isEmpty)
          yield LoginFailure(error: 'No email has been provided.');
        if (event.password.isEmpty)
          yield LoginFailure(error: 'No password has been provided.');
        Token token = await getToken(event.email, event.password);
        authenticationBloc.add(AuthenticationLoggedIn(token: token));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
