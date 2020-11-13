import 'dart:async';

import 'package:atletico_app/endpoints/users.dart';
import 'package:atletico_app/models/token.dart';
import 'package:atletico_app/models/users.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageFormState> {
  final UserRepository userRepository;

  HomepageBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(HomepageFormState(isInitial: true));

  @override
  Stream<HomepageFormState> mapEventToState(
    HomepageEvent event,
  ) async* {
    if (userRepository.isSignedIn()) {
      _signedInEvents(event);
    }
  }

  Stream<void> _signedInEvents(HomepageEvent event) async* {
    if (event is HomepageUserEvent) {
      Token token = await event.loadToken();
      User user = await event.getUser(token);
      yield state.copyWith(isInitial: false, token: token, user: user);
    }
  }

}
