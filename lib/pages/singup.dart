import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:atletico_app/endpoints/signup_login.dart';

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
        print(checkIfEmailExists(_dateOfBirthController.text));
      });
  }

  String validateName(value) {
    return "123";
  }

  String validateEmail(value) {
    return "321";
  }

  Widget buildSignUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => null,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loginSignUpScaffold(context, [
      headerText(),
      SizedBox(height: 15.0),
      loginSignupTextForm(_fullNameController, "Name",
          hintText: "John Doe", prefixIcon: Icons.person, validator: validateName),
      SizedBox(height: 15.0),
      loginSignupTextForm(_emailController, "Email",
          hintText: "example@email.com", prefixIcon: Icons.email,
          validator: validateEmail),
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
          readOnly: true,
          showCursor: false,
          onTap: selectDate,
          functionParamters: [context]),
          buildSignUpButton()
    ]);
  }
}