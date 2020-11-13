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
    return BlocListener<HomepageBloc, HomepageFormState>(
        listener: (context, state) {
          if (state.isInitial)
            context.bloc<HomepageBloc>().add(HomepageUserEvent());
        },
        child: buildForm(context));
  }

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [FixedHeader()],
    );
  }
}

class FixedHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
