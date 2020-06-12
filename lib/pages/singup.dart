import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  bool _textObscured = true;
  final format = DateFormat("MM/dd/yyyy");
  DateTime selectedDate = DateTime.now();

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

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 13));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateOfBirthController.text = format.format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return loginSignUpScaffold(context, [
      headerText(),
      SizedBox(height: 15.0),
      loginSignupTextForm(_fullNameController, "Name",
          hintText: "John Doe", prefixIcon: Icons.person),
      SizedBox(height: 15.0),
      loginSignupTextForm(_emailController, "Email",
          hintText: "example@email.com", prefixIcon: Icons.email),
      SizedBox(height: 15.0),
      loginSignupTextForm(_passwordController, "Password",
          hintText: "Enter your Password",
          prefixIcon: Icons.lock,
          obscureText: _textObscured),
      SizedBox(height: 15.0),
      loginSignupTextForm(_passwordConfirmController, "Confirm Password",
          hintText: "Re-enter your Password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
              icon: _textObscured
                  ? Icon(Icons.visibility, color: Colors.white)
                  : Icon(Icons.visibility_off, color: Colors.white),
              onPressed: () {
                setState(() {
                  _textObscured = !_textObscured;
                });
              }),
          obscureText: _textObscured),
      SizedBox(height: 15.0),
      loginSignupTextForm(_dateOfBirthController, "D.O.B",
          hintText: "MM/DD/YYYY",
          prefixIcon: Icons.calendar_today,
          context: context,
          onTap: selectDate)
    ]);
  }
}