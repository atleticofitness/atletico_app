part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  FormStatus validate();
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

  @override
  FormStatus validate() {
    throw UnimplementedError();
  }
}

class RegistrationEmailForm extends RegistrationEvent {
  final String email;

  const RegistrationEmailForm({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'RegistrationEmailForm { email: $email }';

  @override
  FormStatus validate() {
    if (email.isEmpty) return FormStatus.undecided;

    var emailInUse = checkIfEmailExists(email);
    if (emailInUse != null)
      emailInUse.then((exist) {
        if (exist == null)
          return FormStatus.invalid;
        else if (validator.email(email)) return FormStatus.valid;
      });

    return FormStatus.invalid;
  }
}

class RegistrationPasswordForm extends RegistrationEvent {
  final String password;
  final String passwordConfirm;
  final bool obscured;

  const RegistrationPasswordForm(
      {this.password, this.passwordConfirm, this.obscured});

  @override
  List<Object> get props => [password, passwordConfirm, obscured];

  @override
  String toString() =>
      'RegistrationPasswordForm { password: $password, passwordConfirm: $passwordConfirm, obscured: $obscured }';

  @override
  FormStatus validate() {
    if (passwordConfirm.isEmpty) return FormStatus.undecided;

    if (password.isEmpty)
      if (passwordConfirm.isNotEmpty)
        return FormStatus.undecided;

    if (validator.password(password))
      if (password == passwordConfirm)
        return FormStatus.valid;

    return FormStatus.invalid;
  }
}
