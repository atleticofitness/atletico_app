import 'package:atletico_app/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/registration_bloc.dart';
import 'registration_form.dart';

class RegistrationWidget extends StatefulWidget {
  RegistrationWidget({Key key}) : super(key: key);

  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  @override
  Widget build(BuildContext context) {
    return loginRegistrationScaffold(
        context,
        BlocProvider(
            create: (context) =>
                RegistrationBloc(userRepository: UserRepository.users()),
            child: RegistrationForm()));
  }
}
