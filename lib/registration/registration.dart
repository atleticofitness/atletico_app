import 'package:atletico_app/repositories/user_repository.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/registration_bloc.dart';
import 'registration_form.dart';

class RegistrationWidget extends StatefulWidget {
  final UserRepository userRepository;
  RegistrationWidget({Key key, @required this.userRepository})
      : super(key: key);

  @override
  _RegistrationWidgetState createState() =>
      _RegistrationWidgetState(userRepository: userRepository);
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final UserRepository userRepository;

  _RegistrationWidgetState({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return loginRegistrationScaffold(
        context,
        BlocProvider(
            create: (context) =>
                RegistrationBloc(userRepository: userRepository),
            child: RegistrationForm()));
  }
}
