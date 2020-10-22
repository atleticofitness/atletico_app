part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  Future<FormStatus> validate() async {
    throw UnimplementedError();
  }
}

class RegistrationButtonPressed extends RegistrationEvent {
  final User user;

  const RegistrationButtonPressed({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'RegistrationButtonPressed { user: $user }';

  void processRegistration() async {
      await sendRegistrationInfomation(user);
  }

  @override
  Future<FormStatus> validate() async {
    if (user.firstName == null ||
        user.lastName == null ||
        user.password == null ||
        user.email == null ||
        user.birthDate == null) return FormStatus.invalid;
    return FormStatus.inprogress;
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
  Future<FormStatus> validate() async {
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
  Future<FormStatus> validate() async {
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
  Future<FormStatus> validate() async {
    if (email.isEmpty) return FormStatus.undecided;
    if (!email.contains("@")) return FormStatus.undecided;
    if (!email.contains(".")) return FormStatus.undecided;
    if (!validator.email(email)) return FormStatus.invalid;
    var box = Hive.box("user_information");
    var cachedEmail = box.get("cached_email");
    if (cachedEmail != null) {
      if (cachedEmail == email) return FormStatus.valid;
    }
    var emailInUse = await checkIfEmailExists(email);
    if (!emailInUse) {
      box.put("cached_email", email);
      return FormStatus.valid;
    }
    return FormStatus.invalid;
  }
}

class RegistrationPasswordForm extends RegistrationEvent {
  final String password;
  final bool obscured;

  const RegistrationPasswordForm({this.password, this.obscured});

  @override
  List<Object> get props => [password, obscured];

  @override
  String toString() =>
      'RegistrationPasswordForm { password: $password, obscured: $obscured }';

  @override
  Future<FormStatus> validate() async {
    if (password == null) return FormStatus.undecided;
    if (password.isEmpty) return FormStatus.undecided;
    if (!validator.password(password)) return FormStatus.invalid;
    return FormStatus.valid;
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
  Future<FormStatus> validate() async {
    if (this.birthDate.isEmpty) return FormStatus.undecided;
    if (this.birthDate.length < 8) return FormStatus.undecided;
    DateTime dob = DateTime.parse(this.birthDate);
    DateTime now = DateTime.now();
    if (dob.month > 12 ||
        dob.month < 1 ||
        dob.day < 1 ||
        dob.day > daysInMonth(dob.month, dob.year) ||
        dob.year < 1810 ||
        (dob.year > now.year && dob.day > now.day && dob.month > now.month))
      return FormStatus.invalid;
    int age = calculateAge(dob);
    if (age < 13) return FormStatus.invalid;
    return FormStatus.valid;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (birthDate.month > currentDate.month)
      age--;
    else if (currentDate.month == birthDate.month) if (birthDate.day >
        currentDate.day) age--;
    return age;
  }

  int daysInMonth(int month, int year) {
    int days = 28 +
        (month + (month / 8).floor()) % 2 +
        2 % month +
        2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  bool isLeapYear(int year) =>
      ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);
}
