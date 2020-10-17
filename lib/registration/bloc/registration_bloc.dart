import 'dart:async';

import 'package:atletico_app/endpoints/registration/registration.dart';
import 'package:atletico_app/models/users.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:hive/hive.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationFormState> {
  RegistrationBloc() : super(RegistrationFormState());

  @override
  Stream<RegistrationFormState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationFirstNameForm)
      yield state.copyWith(
          firstName: event.firstName, status: await event.validate());

    if (event is RegistrationLastNameForm)
      yield state.copyWith(
          lastName: event.lastName, status: await event.validate());

    if (event is RegistrationEmailForm)
      yield state.copyWith(email: event.email, status: await event.validate());

    if (event is RegistrationPasswordForm)
      yield state.copyWith(
          password: event.password,
          obscured: event.obscured,
          status: await event.validate());

    if (event is RegistrationBirthDayForm)
      yield state.copyWith(
          birthDate: event.birthDate, status: await event.validate());

    if (event is RegistrationButtonPressed) {
      yield state.copyWith(status: await event.validate());
      if (state.status == FormStatus.valid) {
        await sendRegistrationInfomation(event.user);
        await Future<void>.delayed(const Duration(seconds: 1));
        yield state.copyWith(status: FormStatus.complete);
      }
    }
  }
}
