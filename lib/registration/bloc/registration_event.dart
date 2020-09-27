part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationButtonPressed extends RegistrationEvent {
  final User user;
  final bool validEmailAddress;
  final bool passwordMatches;
  final DateTime selectedDate;
  final String confirmPassword;

  const RegistrationButtonPressed(
      {@required this.user,
      @required this.validEmailAddress,
      @required this.passwordMatches,
      @required this.selectedDate,
      @required this.confirmPassword});

  @override
  List<Object> get props =>
      [user, validEmailAddress, passwordMatches, selectedDate, confirmPassword];

  @override
  String toString() =>
      'RegistrationButton Pressed { user: $user valid_email: $validEmailAddress password_matches: $passwordMatches selected_date: $selectedDate confirm_password: $confirmPassword}';
}
