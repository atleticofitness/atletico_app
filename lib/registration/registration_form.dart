import 'package:atletico_app/registration/bloc/registration_bloc.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

class RegistrationForm extends StatefulWidget {
  RegistrationForm({Key key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationFormState>(
        listener: (context, state) {
          if (UserRepository.users().isSignedIn())
            ExtendedNavigator.of(context).push(Routes.homePageWidget);
        },
        child: buildForm(context));
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

  Widget buildForm(BuildContext context) {
    return Column(children: [
      Row(
        children: [
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
      DateOfBirthInput(),
      SizedBox(height: 15.0),
      SubmitButton(),
    ]);
  }
}

class FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                suffixIcon: (state.firstNameStatus == FormStatus.invalid)
                    ? Icon(Icons.error, color: secondaryColor)
                    : (state.firstNameStatus == FormStatus.valid)
                        ? Icon(Icons.error, color: Colors.green)
                        : null,
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                context
                    .bloc<RegistrationBloc>()
                    .add(RegistrationFirstNameForm(firstName: value));
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
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                suffixIcon: (state.lastNameStatus == FormStatus.invalid)
                    ? Icon(Icons.error, color: secondaryColor)
                    : (state.lastNameStatus == FormStatus.valid)
                        ? Icon(Icons.error, color: Colors.green)
                        : null,
              ),
              keyboardType: TextInputType.name,
              onChanged: (value) {
                context
                    .bloc<RegistrationBloc>()
                    .add(RegistrationLastNameForm(lastName: value));
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
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                suffixIcon: (state.emailStatus == FormStatus.invalid ||
                        state.emailStatus == FormStatus.emailInUse)
                    ? Icon(Icons.error, color: secondaryColor)
                    : (state.emailStatus == FormStatus.valid)
                        ? Icon(Icons.error, color: Colors.green)
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
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.obscured != current.obscured,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  onPressed: () => context
                      .bloc<RegistrationBloc>()
                      .add(RegistrationPasswordForm(obscured: !state.obscured)),
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

class DateOfBirthInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
      builder: (context, state) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              maxLength: 8,
              initialValue: state.birthDate,
              style: textStyle,
              decoration: InputDecoration(
                counterText: '',
                hintText: "YYYYMMDD",
                hintStyle: hintTextStyle,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(Icons.calendar_today, color: Colors.grey),
                suffixIcon: (state.birthDateStatus == FormStatus.invalid)
                    ? Icon(Icons.error, color: secondaryColor)
                    : (state.birthDateStatus == FormStatus.valid)
                        ? Icon(Icons.error, color: Colors.green)
                        : null,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                context
                    .bloc<RegistrationBloc>()
                    .add(RegistrationBirthDayForm(birthDate: value));
              },
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
    return BlocBuilder<RegistrationBloc, RegistrationFormState>(
        builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if (!state.isValid) return null;
            if (state.userStatus == FormStatus.inprogress) return null;
            if (state.userStatus == FormStatus.complete) return null;
            if (UserRepository.users().isSignedIn()) return null;
            return BlocProvider.of<RegistrationBloc>(context)
                .add(RegistrationButtonPressed());
          },
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
