import 'dart:async';

import 'package:atletico_app/endpoints/registration.dart';
import 'package:atletico_app/models/users.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:hive/hive.dart';
import 'package:atletico_app/util/constants.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationFormState> {
  final UserRepository userRepository;

  RegistrationBloc({@required userRepository})
      : assert(userRepository != null),
        this.userRepository = userRepository,
        super(RegistrationFormState());

  @override
  Stream<RegistrationFormState> mapEventToState(
      RegistrationEvent event) async* {
    try {
      if (event is RegistrationFirstNameForm)
        yield state.copyWith(
            firstName: event.firstName,
            firstNameStatus: await event.validate());

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
        yield state.copyWith(userStatus: FormStatus.inprogress);
        User user = User(
            email: state.email,
            password: state.password,
            firstName: state.firstName,
            lastName: state.lastName,
            birthDate: state.birthDate);
        sendRegistrationInfomation(user);
        await userRepository.signInWithCredentials(user.email, user.password);
        yield state.copyWith(userStatus: FormStatus.complete);
      }
    } catch (e) {
      yield state.copyWith(userStatus: FormStatus.undecided);
      print(e);
    }
  }
}
