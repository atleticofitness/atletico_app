import 'dart:async';

import 'package:atletico_app/endpoints/registration/registration.dart';
import 'package:atletico_app/models/users.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:hive/hive.dart';
import 'package:atletico_app/util/constants.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationFormState> {
  RegistrationBloc() : super(RegistrationFormState());

  @override
  Stream<RegistrationFormState> mapEventToState(
      RegistrationEvent event) async* {
    try {
      if (event is RegistrationFirstNameForm) {
        yield state.copyWith(
            firstName: event.firstName,
            firstNameStatus: await event.validate());
      }

      if (event is RegistrationLastNameForm)
        yield state.copyWith(
            lastName: event.lastName, lastNameStatus: await event.validate());

      if (event is RegistrationEmailForm)
        yield state.copyWith(
            email: event.email, emailStatus: await event.validate());

      if (event is RegistrationPasswordForm)
        yield state.copyWith(
            password: event.password,
            obscured: event.obscured,
            passwordStatus: await event.validate());

      if (event is RegistrationBirthDayForm)
        yield state.copyWith(
            birthDate: event.birthDate,
            birthDateStatus: await event.validate());

      if (event is RegistrationButtonPressed) {
        yield state.copyWith(userStatus: await event.validate());
        if (state.userStatus == FormStatus.inprogress) {
          event.processRegistration();
          await Future<void>.delayed(const Duration(seconds: 1));
          yield state.copyWith(userStatus: FormStatus.complete);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
