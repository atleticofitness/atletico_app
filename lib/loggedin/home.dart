import 'package:atletico_app/util/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_form.dart';

class HomePageWidget extends StatefulWidget {

  const HomePageWidget({Key key}) : super(key: key);
  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return loginRegistrationScaffold(
          context,
          BlocProvider(
              create: (context) {
                //return LoginBloc(userRepository: UserRepository.users());
              },
              child: HomePageForm()));
    });
  }
}
