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

        if (event.user.email.isEmpty)
          yield RegistrationFailure(error: "Email is empty.");

        /*if (!event.validEmailAddress)
          yield RegistrationFailure(
              error: "This is not a valid email address.");*/

        if (event.user.firstName.isEmpty)
          yield RegistrationFailure(error: "First name is empty.");

        if (event.user.lastName.isEmpty)
          yield RegistrationFailure(error: "Last name is empty.");

        if (!event.passwordMatches)
          yield RegistrationFailure(error: "The passwords do not match.");

        if (event.user.password.isEmpty)
          yield RegistrationFailure(error: "Password is empty.");

        if (event.confirmPassword.isEmpty)
          yield RegistrationFailure(
              error: "The password needs to match the one above.");

        if (event.selectedDate.year > (DateTime.now().year - 13))
          yield RegistrationFailure(
              error: "User must be at least 13 years of age.");

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
