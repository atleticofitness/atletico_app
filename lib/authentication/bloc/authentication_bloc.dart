import 'package:atletico_app/models/users.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        this.userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* mapAppStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* mapLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> mapAppStartedToState() async* {
    try {
      if (isSignedIn()) {
        mapLoggedInToState();
      } else {
        yield AuthenticationInitial();
      }
    } catch (_) {
      yield AuthenticationInitial();
    }
  }

  Stream<AuthenticationState> mapLoggedInToState() async* {
    yield AuthenticationSuccess(user: await getUser());
  }

  Stream<AuthenticationState> mapLoggedOutToState() async* {
    yield AuthenticationInitial();
    userRepository.signOut();
  }
}
