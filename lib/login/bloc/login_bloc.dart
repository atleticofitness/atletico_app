import 'dart:async';

import 'package:atletico_app/authentication/bloc/authentication_bloc.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/endpoints/login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginFormState> {
  final UserRepository userRepository;

  LoginBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(LoginFormState());

  @override
  Stream<LoginFormState> mapEventToState(
    LoginEvent event,
  ) async* {
    try {
      if (event is LoginEmailForm)
        yield state.copyWith(email: event.email, emailStatus: event.validate());

      if (event is LoginPasswordForm)
        yield state.copyWith(
            password: event.password,
            obscured: event.obscured,
            passwordStatus: event.validate());

      if (event is LoginRememberMeForm) {
        yield state.copyWith(rememberMe: event.rememberMe);
        event.saveRememberMe();
      }

      if (event is LoginWithApple) {
        yield state.copyWith(isLoggedIn: true);
        //authenticationBloc.add(AuthenticationLoggedIn());
      }

      if (event is LoginWithGoogle) {
        await userRepository.signInWithGoogle();
        yield state.copyWith(isLoggedIn: true);
        //authenticationBloc.add(AuthenticationLoggedIn());
      }
      if (event is LoginWithFacebook) {
        yield state.copyWith(isLoggedIn: true);
        //authenticationBloc.add(AuthenticationLoggedIn());
      }

      if (event is LoginButtonPressed) {
        if (state.isValid) {
          yield state.copyWith(isLoggedIn: true);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
