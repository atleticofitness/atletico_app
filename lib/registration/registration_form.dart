import 'package:atletico_app/registration/bloc/registration_bloc.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:intl/intl.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
      if (state is RegistrationFailure)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.black,
        ));
    }, child: BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return buildForm(context, state);
      },
    ));
  }

  Widget headerText() {
    return Text(
      'Sign Up',
      style: TextStyle(
        color: buttonColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildForm(BuildContext context, RegistrationState state) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 40.0,
            color: Colors.grey,
            alignment: Alignment.center,
            onPressed: () =>
                ExtendedNavigator.of(context).push(Routes.loginWidget),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: headerText(),
          ),
        ],
      ),
      SizedBox(height: 15.0),
      EmailInput(),
      SizedBox(height: 15.0),
      PasswordInput(),
    ]);
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Email",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.email,
                  style: textStyle,
                  decoration: InputDecoration(
                    hintText: "example@example.com",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.email, color: Colors.grey),
                    suffixIcon: (state.status == FormStatus.invalid)
                        ? Icon(Icons.error, color: buttonColor)
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    context
                        .bloc<RegistrationBloc>()
                        .add(RegistrationEmailForm(email: value));
                  },
                ),
              ),
            ]);
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) => previous.password != current.password || previous.obscured != current.obscured,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Password",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.password,
                  style: textStyle,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "password",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: state.obscured
                          ? Icon(Icons.visibility, color: Colors.grey)
                          : Icon(Icons.visibility_off, color: Colors.grey),
                      onPressed: () =>
                        context.bloc<RegistrationBloc>().add(RegistrationPasswordForm(obscured: !state.obscured)),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => context.bloc<RegistrationBloc>().add(RegistrationPasswordForm(password: value)),
                ),
              ),
            ]);
      },
    );
  }
}

/*
class _RegistrationFormState extends State<RegistrationForm> {
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
  final _confirmPasswordController = TextEditingController();
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
        color: buttonColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildRegistrationButton(RegistrationState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          return state is! RegistrationInProgress
              ? BlocProvider.of<RegistrationBloc>(context)
                  .add(RegistrationButtonPressed(
                  user: User(
                      email: _emailController.text,
                      password: _passwordController.text,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      birthDate: _dateOfBirthController.text,
                      isActive: true),
                  validEmailAddress: _validEmailAddress,
                  passwordMatches: _passwordMatches,
                  selectedDate: _selectedDate,
                  confirmPassword: _confirmPasswordController.text,
                ))
              : null;
        }, ////ExtendedNavigator.of(context).push(Routes.loginWidget)
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: buttonColor,
        child: Text(
          'SIGN UP',
          style: TextStyle(
            color: Colors.white,
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
    return "There are characters the system does not recognize";
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
        if (exist == null)
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
              color: Colors.grey,
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
        lastDate: DateTime(DateTime.now().year - 13),
        helpText: "Please enter your D.O.B",
        confirmText: "Confirm",
        cancelText: "Cancel",
        errorFormatText: "errorFormatText",
        errorInvalidText: "errorInvalidText",
        fieldHintText: "MM/DD/YYYY",
        fieldLabelText: "D.O.B");
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text = _format.format(_selectedDate);
      });
  }

  Widget buildForm(BuildContext context, RegistrationState state) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 40.0,
            color: Colors.grey,
            alignment: Alignment.center,
            onPressed: () =>
                ExtendedNavigator.of(context).push(Routes.loginWidget),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: headerText(),
          )
        ],
      ),
      SizedBox(height: 15.0),
      loginRegistrationTextForm(
          _firstNameKey, _firstNameController, "First Name",
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
                  ? Icon(Icons.visibility, color: Colors.grey)
                  : Icon(Icons.visibility_off, color: Colors.grey),
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
          _passwordConfirmKey, _confirmPasswordController, "Confirm Password",
          hintText: "Re-enter your Password",
          prefixIcon: Icons.lock,
          suffixIcon:
              !_passwordMatches ? Icon(Icons.error, color: Colors.grey) : null,
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
      buildRegistrationButton(state),
      Container(
        child: Builder(builder: (context) {
          if (state is RegistrationInProgress)
            return CircularProgressIndicator();
          else if (state is RegistrationComplete)
            ExtendedNavigator.of(context).push(Routes.loginWidget);
          return Container();
        }),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
      if (state is RegistrationFailure)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.black,
        ));
    }, child: BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return buildForm(context, state);
      },
    ));
  }
}
*/
