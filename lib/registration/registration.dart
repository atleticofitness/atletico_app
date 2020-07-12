import 'package:atletico_app/data/users.dart';
import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:atletico_app/endpoints/registration/registration.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

import '../login/login.dart';

class RegistrationWidget extends StatefulWidget {
  RegistrationWidget({Key key}) : super(key: key);

  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final _firstNameKey = GlobalKey<FormFieldState>();
  final _lastNameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _passwordConfirmKey = GlobalKey<FormFieldState>();
  final _dobKey = GlobalKey<FormFieldState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  bool _textObscured = true;
  bool _validEmailAddress = true;
  final _format = DateFormat("MM/dd/yyyy");
  DateTime _selectedDate = DateTime.now();
  bool _passwordMatches = true;

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

  Widget buildRegistrationButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (_emailController.text.isEmpty) return null;

          if (!_validEmailAddress) return null;

          if (_firstNameController.text.isEmpty) return null;

          if (_lastNameController.text.isEmpty) return null;

          if (!_passwordMatches) return null;

          if (_passwordController.text.isEmpty) return null;

          if (_passwordConfirmController.text.isEmpty) return null;

          if (_selectedDate.year > (DateTime.now().year - 13)) return null;

          await sendRegistrationInfomation(User(
              email: _emailController.text,
              password: _passwordController.text,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              birthDate: _dateOfBirthController.text,
              isActive: true));
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGN UP',
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

  String validateName(String value) {
    if (value.isEmpty) return null;
    bool validName = validator.name(value);
    if (validName) return null;
    return "There are characters thr system does not recognize";
  }

  String validateEmail(String value) {
    if (value.isEmpty) return null;
    bool validEmail = validator.email(value);
    if (!validEmail) {
      setState(() => _validEmailAddress = false);
      return "This is not a valid email";
    }
    var emailInUse = checkIfEmailExists(value);
    if (emailInUse != null)
      emailInUse.then((exist) {
        if (exist)
          setState(() => _validEmailAddress = false);
        else
          setState(() => _validEmailAddress = true);
      });
    return null;
  }

  String validateIfPasswordMatchPolicy(String value) {
    setState(() {
      _passwordController.text; // = value;
    });
    bool match = validator.password(value);
    if (match) return null;
    return "This password does not follow policy guidelines.";
  }

  String validateIfPasswordsAreEqual(String value) {
    bool match = validator.password(value);
    if (match) {
      setState(() => _passwordMatches = true);
      return null;
    }
    setState(() => _passwordMatches = false);
    return "The password fields do not match.";
  }

  Widget checkPasswordPolicy() {
    return Row(children: <Widget>[
      Text(
          "Password Requirements:\n\t\t•\t8 characters long\n\t\t•\tOne uppercase and One lowercase letter\n\t\t•\tOne special character",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'))
    ]);
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year - 13));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text = _format.format(_selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return loginRegistrationScaffold(context, null);
  }
}

/*
Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 40.0,
            color: Colors.white,
            alignment: Alignment.center,
            onPressed: () => Navigator.of(context)
                .push(routeToWidget(LoginWidget(), Offset(-1.0, 0.0))),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: headerText(),
          )
        ],
      ),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(_firstNameKey, _firstNameController, "First Name",
          hintText: "Jose", prefixIcon: Icons.person, onChanged: validateName),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(_lastNameKey, _lastNameController, "Last Name",
          hintText: "Lopez", prefixIcon: Icons.person, onChanged: validateName),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(_emailKey, _emailController, "Email",
          autoValidate: false,
          keyboardType: TextInputType.emailAddress,
          hintText: "example@email.com",
          prefixIcon: Icons.email,
          suffixIcon: !_validEmailAddress
              ? Icon(Icons.error, color: Colors.white)
              : null,
          onChanged: validateEmail),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(_passwordKey, _passwordController, "Password",
          hintText: "Enter your Password",
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
          obscureText: _textObscured,
          onChanged: validateIfPasswordMatchPolicy),
      SizedBox(height: 15.0),
      FlutterPasswordStrength(password: _passwordController.text),
      checkPasswordPolicy(),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(
          _passwordConfirmKey, _passwordConfirmController, "Confirm Password",
          hintText: "Re-enter your Password",
          prefixIcon: Icons.lock,
          suffixIcon:
              !_passwordMatches ? Icon(Icons.error, color: Colors.white) : null,
          obscureText: _textObscured,
          onChanged: validateIfPasswordsAreEqual),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(_dobKey, _dateOfBirthController, "D.O.B",
          hintText: "MM/DD/YYYY",
          prefixIcon: Icons.calendar_today,
          readOnly: true,
          showCursor: false,
          onTap: selectDate,
          functionParamters: [context]),
      buildRegistrationButton()

 */
