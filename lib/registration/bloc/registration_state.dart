part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationFormState extends RegistrationState {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool obscured;
  final String birthDate;
  final FormStatus firstNameStatus;
  final FormStatus lastNameStatus;
  final FormStatus passwordStatus;
  final FormStatus emailStatus;
  final FormStatus birthDateStatus;
  final FormStatus userStatus;

  const RegistrationFormState({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.obscured = true,
    this.birthDate = "",
    this.firstNameStatus = FormStatus.undecided,
    this.lastNameStatus = FormStatus.undecided,
    this.passwordStatus = FormStatus.undecided,
    this.emailStatus = FormStatus.undecided,
    this.birthDateStatus = FormStatus.undecided,
    this.userStatus = FormStatus.undecided,
  });

  bool isValid() =>
      firstNameStatus == FormStatus.valid ||
      lastNameStatus == FormStatus.valid ||
      emailStatus == FormStatus.valid ||
      passwordStatus == FormStatus.valid ||
      birthDateStatus == FormStatus.valid;

  RegistrationFormState copyWith({
    String firstName,
    String lastName,
    String email,
    String password,
    bool obscured,
    String birthDate,
    FormStatus firstNameStatus,
    FormStatus lastNameStatus,
    FormStatus passwordStatus,
    FormStatus emailStatus,
    FormStatus birthDateStatus,
    FormStatus userStatus,
  }) =>
      RegistrationFormState(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        obscured: obscured ?? this.obscured,
        birthDate: birthDate ?? this.birthDate,
        firstNameStatus: firstNameStatus ?? this.firstNameStatus,
        lastNameStatus: lastNameStatus ?? this.lastNameStatus,
        passwordStatus: passwordStatus ?? this.passwordStatus,
        emailStatus: emailStatus ?? this.emailStatus,
        birthDateStatus: birthDateStatus ?? this.birthDateStatus,
        userStatus: userStatus ?? this.userStatus,
      );

  @override
  List<Object> get props => [
        firstName,
        lastName,
        email,
        password,
        obscured,
        birthDate,
        firstNameStatus,
        lastNameStatus,
        passwordStatus,
        emailStatus,
        birthDateStatus,
        userStatus,
      ];
}
