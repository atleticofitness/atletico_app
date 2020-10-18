part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

enum FormStatus { undecided, valid, invalid, inprogress, complete }

class RegistrationFormState extends RegistrationState {
  const RegistrationFormState({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.obscured = true,
    this.birthDate = "",
    this.status = FormStatus.undecided,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool obscured;
  final String birthDate;
  final FormStatus status;

  RegistrationFormState copyWith({
    String firstName,
    String lastName,
    String email,
    String password,
    bool obscured,
    String birthDate,
    FormStatus status,
  }) {
    return RegistrationFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      obscured: obscured ?? this.obscured,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [firstName, lastName, email, password, obscured, birthDate, status];
}
