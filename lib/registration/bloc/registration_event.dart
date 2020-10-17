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
    int nulls = 0;
    for (var prop in user.props) {
      if (prop == null) nulls++;
    }
    if (nulls == user.props.length) return FormStatus.undecided;
    if (nulls == 1) return FormStatus.inprogress;
    return FormStatus.invalid;
  }
}

class RegistrationFirstNameForm extends RegistrationEvent {
  final String firstName;

  const RegistrationFirstNameForm({@required this.firstName});

  @override
  List<Object> get props => [firstName];

  @override
  String toString() => 'RegistrationFirstNameForm { firstName: $firstName }';

  @override
  FormStatus validate() {
    if (firstName.isEmpty) return FormStatus.undecided;

    return FormStatus.valid;
  }
}

class RegistrationLastNameForm extends RegistrationEvent {
  final String lastName;

  const RegistrationLastNameForm({@required this.lastName});

  @override
  List<Object> get props => [lastName];

  @override
  String toString() => 'RegistrationLastNameForm { lastName: $lastName }';

  @override
  FormStatus validate() {
    if (lastName.isEmpty) return FormStatus.undecided;

    return FormStatus.valid;
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
  final String birthDate;

  const RegistrationBirthDayForm({@required this.birthDate});

  @override
  List<Object> get props => [birthDate];

  @override
  String toString() => 'RegistrationBirthDayForm { birthDate: $birthDate }';

  @override
  FormStatus validate() {
    if (this.birthDate.isEmpty) return FormStatus.undecided;
    DateTime dob = DateTime.parse(this.birthDate);
    int age = DateTime.now().year - dob.year;
    if (age < 13) return FormStatus.invalid;
    return FormStatus.valid;
  }
}
