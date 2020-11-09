import 'package:atletico_app/util/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/homepage_bloc.dart';
import 'home_form.dart';

class HomepageWidget extends StatefulWidget {

  const HomepageWidget({Key key}) : super(key: key);
  @override
  HomepageWidgetState createState() => HomepageWidgetState();
}

class HomepageWidgetState extends State<HomepageWidget>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BaseWidget(builder: (context, sizingInformation) {
      return loginRegistrationScaffold(
          context,
          BlocProvider(
              create: (context) {
                return HomepageBloc();
              },
              child: HomepageForm()));
    });
  }
}
