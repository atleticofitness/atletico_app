import 'package:atletico_app/models/users.dart';
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
        color: secondaryColor,
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
      FirstNameInput(),
      SizedBox(height: 15.0),
      LastNameInput(),
      SizedBox(height: 15.0),
      EmailInput(),
      SizedBox(height: 15.0),
      PasswordInput(),
      SizedBox(height: 15.0),
      PasswordConfirmInput(),
      SizedBox(height: 15.0),
      DateOfBirthInput(),
      SizedBox(height: 15.0),
      SubmitButton(),
    ]);
  }
}

class FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "First Name",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.firstName,
                  style: textStyle,
                  decoration: InputDecoration(
                    hintText: "first name",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.person, color: Colors.grey),
                    suffixIcon: (state.status == FormStatus.invalid)
                        ? Icon(Icons.error, color: secondaryColor)
                        : null,
                  ),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    context
                        .bloc<RegistrationBloc>()
                        .add(RegistrationNameForm(firstName: value));
                  },
                ),
              ),
            ]);
      },
    );
  }
}

class LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Last Name",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.lastName,
                  style: textStyle,
                  decoration: InputDecoration(
                    hintText: "last name",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.person, color: Colors.grey),
                    suffixIcon: (state.status == FormStatus.invalid)
                        ? Icon(Icons.error, color: secondaryColor)
                        : null,
                  ),
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    context
                        .bloc<RegistrationBloc>()
                        .add(RegistrationNameForm(lastName: value));
                  },
                ),
              ),
            ]);
      },
    );
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
                        ? Icon(Icons.error, color: secondaryColor)
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
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.obscured != current.obscured,
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
                  obscureText: state.obscured,
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
                      onPressed: () => context.bloc<RegistrationBloc>().add(
                          RegistrationPasswordForm(obscured: !state.obscured)),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => context
                      .bloc<RegistrationBloc>()
                      .add(RegistrationPasswordForm(password: value)),
                ),
              ),
              SizedBox(height: 15.0),
              FlutterPasswordStrength(password: state.password),
            ]);
      },
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) =>
          previous.passwordConfirm != current.passwordConfirm ||
          previous.obscured != current.obscured,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Confirm Password",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.passwordConfirm,
                  style: textStyle,
                  obscureText: state.obscured,
                  decoration: InputDecoration(
                    hintText: "confirm password",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: (state.status == FormStatus.invalid)
                        ? Icon(Icons.error, color: secondaryColor)
                        : null,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) => context
                      .bloc<RegistrationBloc>()
                      .add(RegistrationPasswordForm(passwordConfirm: value)),
                ),
              ),
            ]);
      },
    );
  }
}

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
      builder: (context, state) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Date of Birth",
                style: labelStyle,
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.centerLeft,
                decoration: boxDecorationStyle,
                height: 60.0,
                child: TextFormField(
                  maxLines: 1,
                  initialValue: state.birthDate,
                  style: textStyle,
                  readOnly: true,
                  showCursor: false,
                  onTap: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year - 120),
                      lastDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      helpText: "Please enter your D.O.B",
                      confirmText: "Confirm",
                      cancelText: "Cancel",
                      errorFormatText: "errorFormatText",
                      errorInvalidText: "errorInvalidText",
                      fieldHintText: "MM/DD/YYYY",
                      fieldLabelText: "D.O.B"),
                  decoration: InputDecoration(
                    hintText: "Birth Date",
                    hintStyle: hintTextStyle,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                    suffixIcon: (state.status == FormStatus.invalid)
                        ? Icon(Icons.error, color: secondaryColor)
                        : null,
                  ),
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) => context
                      .bloc<RegistrationBloc>()
                      .add(RegistrationBirthDayForm(dob: value)),
                ),
              ),
            ]);
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, MyFormState>(
      builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            return state is! RegistrationInProgress
                ? BlocProvider.of<RegistrationBloc>(context).add(
                    RegistrationButtonPressed(
                      user: User(
                          email: state.email,
                          password: state.password,
                          firstName: state.firstName,
                          lastName: state.lastName,
                          birthDate: state.birthDate,
                          isActive: true),
                    ),
                  )
                : null;
          }, ////ExtendedNavigator.of(context).push(Routes.loginWidget)
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: secondaryColor,
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
    });
  }
}
