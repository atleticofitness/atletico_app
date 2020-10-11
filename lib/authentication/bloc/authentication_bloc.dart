import 'package:atletico_app/authentication/bloc/authentication.dart';
import 'package:atletico_app/models/token.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_states.dart';
import 'package:flutter/material.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Token token;

  AuthenticationBloc({@required this.token})
      : assert(token != null),
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      bool hasToken = await token.hasToken();
      if (hasToken)
        yield AuthenticationSuccess();
      else
        yield AuthenticationFailure();
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await event.token.save();
      yield AuthenticationSuccess();
    }

    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await token.delete();
      yield AuthenticationFailure();
    }
  }
}
