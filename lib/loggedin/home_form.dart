import 'package:atletico_app/loggedin/bloc/homepage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageForm extends StatefulWidget {
  HomePageForm({Key key}) : super(key: key);

  @override
  _HomePageFormState createState() => _HomePageFormState();
}

class _HomePageFormState extends State<HomePageForm> {
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
