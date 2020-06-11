import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();

  Widget headerText() {
    return Text(
      'Sign Up',
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loginSignUpScaffold(context, [
      headerText(),
      SizedBox(height: 15.0),
      buildTextBoxForm(_fullNameController, "Name",
          hintText: "John Doe", iconData: Icons.person),
      SizedBox(height: 15.0),
      buildTextBoxForm(_emailController, "Email",
          hintText: "example@email.com", iconData: Icons.person)
    ]);
  }
}
