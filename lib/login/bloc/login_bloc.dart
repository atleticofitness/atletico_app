import 'dart:async';

import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:regexed_validator/regexed_validator.dart';

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
        event.saveRememberMe();
        yield state.copyWith(rememberMe: event.rememberMe);
      }

      if (event is LoginWithApple) {
        await userRepository.signInWithApple();
        yield state;
      }

      if (event is LoginWithGoogle) {
        await userRepository.signInWithGoogle();
        yield state;
      }

      if (event is LoginWithFacebook) {
        await userRepository.signInWithFacebook();
        yield state;
      }

      if (event is LoginButtonPressed) {
        if (state.isValid) {
          String loginStatusCode = await userRepository.signInWithCredentials(
              event.email, event.password);
          _handleSignInError(loginStatusCode);
        }
      }
    } catch (e) {
      print(e);
    }
  }

    Stream<void> _handleSignInError(String code) async* {
    if (code == "email-already-in-use") {
      yield state.copyWith(emailStatus: FormStatus.invalid);
      return;
    }

    if (code == "invalid-email") {
      yield state.copyWith(emailStatus: FormStatus.invalid);
      return;
    }

    if (code == "operation-not-allowed") {
      yield state.copyWith(emailStatus: FormStatus.invalid, passwordStatus: FormStatus.invalid);
      return;
    }

    if (code == "weak-password") {
      yield state.copyWith(passwordStatus: FormStatus.invalid);
      return;
    }
    yield state;
  }
}
