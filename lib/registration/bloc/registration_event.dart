part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationButtonPressed extends RegistrationEvent {
  final User user;

  const RegistrationButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegistrationButton Pressed { user: $user';
}
