import 'package:atletico_app/authentication/bloc/authentication_bloc.dart';
import 'package:atletico_app/login/bloc/login_bloc.dart';
import 'package:atletico_app/login/login_form.dart';
import 'package:atletico_app/util/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidget extends StatefulWidget {
  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return loginRegistrationScaffold(
          context,
          BlocProvider(
              create: (context) {
                return LoginBloc(
                    authenticationBloc:
                        BlocProvider.of<AuthenticationBloc>(context));
              },
              child: LoginForm()));
    });
  }
}
