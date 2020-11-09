import 'package:atletico_app/loggedin/bloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageForm extends StatefulWidget {
  HomepageForm({Key key}) : super(key: key);

  @override
  _HomepageFormState createState() => _HomepageFormState();
}

class _HomepageFormState extends State<HomepageForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomepageBloc, HomepageState>(
        listener: (context, state) {

        },
        child: buildForm(context));
  }

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );
  }
}
