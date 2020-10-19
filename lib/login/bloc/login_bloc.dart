import 'dart:async';

import 'package:atletico_app/authentication/bloc/authentication.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/endpoints/authentication/atletico.dart';
import 'package:atletico_app/registration/bloc/registration_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

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
  ) async* {}
}
