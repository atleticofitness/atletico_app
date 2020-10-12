part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  FormStatus validate();
}

class RegistrationButtonPressed extends RegistrationEvent {
  final User user;

  const RegistrationButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegistrationButtonPressed { user: $user }';

  @override
  FormStatus validate() {
    throw UnimplementedError();
  }
}

class RegistrationNameForm extends RegistrationEvent {
  final String firstName;
  final String lastName;

  const RegistrationNameForm({this.firstName, this.lastName});

  @override
  List<Object> get props => [firstName, lastName];

  @override
  String toString() =>
      'RegistrationNameForm { firstName: $firstName, lastName: $lastName }';

  @override
  FormStatus validate() {
    return FormStatus.undecided;
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

    if (password.isEmpty) if (passwordConfirm.isNotEmpty)
      return FormStatus.undecided;

    if (validator.password(password)) if (password == passwordConfirm)
      return FormStatus.valid;

    return FormStatus.invalid;
  }
}

class RegistrationBirthDayForm extends RegistrationEvent {
  final String dob;

  const RegistrationBirthDayForm({this.dob});

  @override
  List<Object> get props => [dob];

  @override
  String toString() => 'RegistrationBirthDayForm { dob: $dob }';

  @override
  FormStatus validate() {
    return FormStatus.invalid;
  }
}
