import 'package:atletico_app/login/bloc/login_bloc.dart';
import 'package:atletico_app/repositories/user_repository.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;

  LoginForm({Key key, this.userRepository}) : super(key: key);

  @override
  _LoginFormState createState() =>
      _LoginFormState(userRepository: this.userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final UserRepository userRepository;

  _LoginFormState({@required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginFormState>(
        listener: (context, state) {
          if (state.isLoggedIn)
            ExtendedNavigator.of(context).push(Routes.atleticoWidget);
        },
        child: buildForm(context));
  }

  Widget headerText() {
    return Text(
      'Sign In',
      style: TextStyle(
        color: secondaryColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildSignInWithText() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: labelStyle,
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        headerText(),
        SizedBox(height: 15.0),
        EmailInput(),
        SizedBox(height: 15.0),
        PasswordInput(),
        ForgotPasswordInput(),
        RememberMeInput(),
        LoginButton(),
        RegistrationInput(userRepostory: userRepository),
        buildSignInWithText(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: <Widget>[
              FacebookLoginButton(),
              GoogleLoginButton(),
              AppleLoginButton()
            ],
          ),
        ),
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(
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
                suffixIcon: (state.emailStatus == FormStatus.invalid)
                    ? Icon(Icons.error, color: secondaryColor)
                    : (state.emailStatus == FormStatus.valid)
                        ? Icon(Icons.error, color: Colors.green)
                        : null,
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                context.bloc<LoginBloc>().add(LoginEmailForm(email: value));
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
    return BlocBuilder<LoginBloc, LoginFormState>(
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
                      .bloc<LoginBloc>()
                      .add(LoginPasswordForm(obscured: !state.obscured)),
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => context
                  .bloc<LoginBloc>()
                  .add(LoginPasswordForm(password: value)),
            ),
          ),
        ]);
      },
    );
  }
}

class ForgotPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => print('Forgot Password Button Pressed'),
          padding: EdgeInsets.only(right: 0.0),
          child: Text(
            'Forgot Password?',
            style: labelStyle,
          ),
        ),
      );
    });
  }
}

class RememberMeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(
        buildWhen: (previous, current) =>
            previous.rememberMe != current.rememberMe,
        builder: (context, state) {
          return Container(
            height: 20.0,
            child: Row(
              children: <Widget>[
                Theme(
                  data: ThemeData(unselectedWidgetColor: secondaryColor),
                  child: Checkbox(
                    tristate: false,
                    value: state.rememberMe,
                    checkColor: Colors.white,
                    activeColor: secondaryColor,
                    onChanged: (value) => context.bloc<LoginBloc>().add(
                        LoginRememberMeForm(rememberMe: !state.rememberMe)),
                  ),
                ),
                Text(
                  'Remember me',
                  style: labelStyle,
                ),
              ],
            ),
          );
        });
  }
}

class RegistrationInput extends StatelessWidget {
  final UserRepository userRepostory;

  const RegistrationInput({Key key, @required this.userRepostory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return GestureDetector(
        onTap: () => ExtendedNavigator.of(context)
            .push(Routes.registrationWidget, arguments: userRepostory),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Sign Up',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => context.bloc<LoginBloc>().add(
              LoginButtonPressed(email: state.email, password: state.password)),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: secondaryColor,
          child: Text(
            'LOGIN',
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

class FacebookLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => context.bloc<LoginBloc>().add(LoginWithFacebook()),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: secondaryColor,
          child: Text(
            'LOGIN WITH FACEBOOK',
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

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => context.bloc<LoginBloc>().add(LoginWithGoogle()),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: secondaryColor,
          child: Text(
            'LOGIN WITH GOOGLE',
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

class AppleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginFormState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => context.bloc<LoginBloc>().add(LoginWithApple()),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: secondaryColor,
          child: Text(
            'LOGIN WITH APPLE',
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
