part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationFailure extends RegistrationState {
  final String error;

  const RegistrationFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegistrationFailure { error: $error }';
}

enum FormStatus { undecided, valid, invalid, inprogress, complete }

class RegistrationFormState extends RegistrationState {
  const RegistrationFormState({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.passwordConfirm = "",
    this.obscured = true,
    this.birthDate = "",
    this.status = FormStatus.undecided,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String passwordConfirm;
  final bool obscured;
  final String birthDate;
  final FormStatus status;

  RegistrationFormState copyWith({
    String firstName,
    String lastName,
    String email,
    String password,
    String passwordConfirm,
    bool obscured,
    String birthDate,
    FormStatus status,
  }) {
    return RegistrationFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirm: passwordConfirm ?? this.passwordConfirm,
      obscured: obscured ?? this.obscured,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        password,
        passwordConfirm,
        obscured,
        birthDate,
        status
      ];
}
