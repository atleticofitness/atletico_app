import 'dart:async';

import 'package:atletico_app/authentication/bloc/authentication_bloc.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/endpoints/login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regexed_validator/regexed_validator.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginFormState> {
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(LoginFormState());

  @override
  Stream<LoginFormState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginEmailForm) yield state.copyWith(email: event.email);

      if (event is LoginPasswordForm)
        yield state.copyWith(
            password: event.password, obscured: event.obscured);

      if (event is LoginRememberMeForm) {
        event.saveRememberMe();
        yield state.copyWith(rememberMe: event.rememberMe);
      }

      if (event is LoginButtonPressed) {
        if (event.isValid()) {
          Token token =
              await getToken(email: event.email, password: event.password);
          var auth = AuthenticationLoggedIn(token: token);
          yield state.copyWith(loggedIn: true);
          authenticationBloc.add(auth);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
