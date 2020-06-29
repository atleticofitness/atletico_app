import 'package:flutter/material.dart';
import 'package:atletico_app/util/constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:atletico_app/endpoints/registration.dart';
import 'package:regexed_validator/regexed_validator.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

enum PasswordState {
  good,
  bad,
  none
}

class _SignUpScreenState extends State<SignUpScreen> {
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
  final format = DateFormat("MM/dd/yyyy");
  DateTime selectedDate = DateTime.now();
  String _password;
  var _passwordStatus = [PasswordState.none, PasswordState.none, PasswordState.none];

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

/*  Color changePasswordPrefixIcon() {
    if (_password.isEmpty)
      return null; // No Icon
    RegExp exp = new RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    Iterable<RegExpMatch> matches = exp.allMatches(_password);
    matches.forEach((i, value) {
      _passwordStatus[i] = if (value.isEmpty())  null : value
    });
    
  }*/

  Widget checkPasswordPolicy() {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Cannot contain parts of your name or email.",
            style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
        Text("Needs at least one uppercase and one lowercase letter.",
            style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans')),
        Text("Needs at least one special character.",
            style: TextStyle(
                color: Color(0xFF527DAA),
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans'))
      ],
    ));
  }

  String validateName(String value) {
    return null;
  }

  String validatePassword(String value) {
    return null;
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

  Widget buildSignUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: null,
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

  void animatePassword(String value) {
    setState(() {
      _password = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loginSignUpScaffold(context, [
      headerText(),
      SizedBox(height: 15.0),
      loginSignupTextForm(_firstNameKey, _firstNameController, "First Name",
          hintText: "Jose", prefixIcon: Icons.person, validator: validateName),
      SizedBox(height: 15.0),
      loginSignupTextForm(_lastNameKey, _lastNameController, "Last Name",
          hintText: "Lopez", prefixIcon: Icons.person, validator: validateName),
      SizedBox(height: 15.0),
      loginSignupTextForm(_emailKey, _emailController, "Email",
          autoValidate: false,
          hintText: "example@email.com",
          prefixIcon: Icons.email,
          suffixIcon: !_validEmailAddress
              ? Icon(Icons.error, color: Colors.white)
              : null,
          onChanged: validateEmail),
      SizedBox(height: 15.0),
      loginSignupTextForm(_passwordKey, _passwordController, "Password",
          hintText: "Enter your Password",
          prefixIcon: Icons.lock,
          obscureText: _textObscured,
          onChanged: animatePassword),
      SizedBox(height: 15.0),
      FlutterPasswordStrength(
          password: _password,
          strengthCallback: (strength) {
            //if (strength < 0.26)
              
          }),
      checkPasswordPolicy(),
      SizedBox(height: 15.0),
      loginSignupTextForm(
          _passwordConfirmKey, _passwordConfirmController, "Confirm Password",
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
      loginSignupTextForm(_dobKey, _dateOfBirthController, "D.O.B",
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
