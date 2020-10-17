import 'dart:async';

import 'package:atletico_app/endpoints/registration/registration.dart';
import 'package:atletico_app/models/users.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, MyFormState> {
  RegistrationBloc() : super(MyFormState());

  @override
  Stream<MyFormState> mapEventToState(
    RegistrationEvent event,
  ) async* {
    if (event is RegistrationFirstNameForm)
      yield state.copyWith(
          firstName: event.firstName, status: event.validate());

    if (event is RegistrationLastNameForm)
      yield state.copyWith(lastName: event.lastName, status: event.validate());

    if (event is RegistrationEmailForm)
      yield state.copyWith(email: event.email, status: event.validate());

    if (event is RegistrationPasswordForm)
      yield state.copyWith(
          password: event.password,
          obscured: event.obscured,
          status: event.validate());

    if (event is RegistrationBirthDayForm)
      yield state.copyWith(
          birthDate: event.birthDate, status: event.validate());

    if (event is RegistrationButtonPressed) {
      yield state.copyWith(status: FormStatus.inprogress);
      //Do something
      await Future<void>.delayed(const Duration(seconds: 1));
      yield state.copyWith(status: FormStatus.complete);
    }
  }
}
