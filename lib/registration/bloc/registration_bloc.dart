import 'dart:async';

import 'package:atletico_app/data/users.dart';
import 'package:atletico_app/endpoints/registration/registration.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial());

  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationButtonPressed) {
      yield RegistrationInProgress();

      try {
        if (event.user == null)
          yield RegistrationFailure(
              error: "Don't know how you got here, but I got you fam.");
        bool success = await sendRegistrationInfomation(event.user);
        if (!success)
          yield RegistrationFailure(
              error: "A user with this email already exist.");
      } catch (error) {
        yield RegistrationFailure(error: error);
      }
    }
  }
}
