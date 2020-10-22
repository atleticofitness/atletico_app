import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:atletico_app/models/token.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Token token;

  AuthenticationBloc({@required this.token})
      : assert(token != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    try {
      if (event is AuthenticationStarted) {
        bool hasToken = token.hasToken();
        if (hasToken)
          yield AuthenticationSuccess();
        else
          yield AuthenticationFailure();
      }

      if (event is AuthenticationLoggedIn) {
        yield AuthenticationInProgress();
        event.saveToken();
        yield AuthenticationSuccess();
      }

      if (event is AuthenticationLoggedOut) {
        yield AuthenticationInProgress();
        token.delete();
        yield AuthenticationFailure();
      }
    } catch (e) {
      print(e);
    }
  }
}
