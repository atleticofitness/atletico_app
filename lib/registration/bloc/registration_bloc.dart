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
    if (event is RegistrationEmailForm)
      yield state.copyWith(email: event.email, status: event.validate());

    if (event is RegistrationPasswordForm)
      yield state.copyWith(password: event.password, obscured: event.obscured);
  }
}
