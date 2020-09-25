import 'package:atletico_app/data/token.dart';
import 'package:atletico_app/login/bloc/login_bloc.dart';
import 'package:atletico_app/registration/registration.dart';
import 'package:atletico_app/routes/router.gr.dart';
import 'package:atletico_app/util/constants.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _textObscured = true;

  Widget buildForgotPasswordButton() {
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
  }

  Widget buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: buttonColor),
            child: Checkbox(tristate: false,
              value: _rememberMe,
              checkColor: Colors.white,
              activeColor: buttonColor,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: labelStyle,
          ),
        ],
      ),
    );
  }


  Widget buildSignInWithText() {
    return Column(
      children: <Widget>[
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

  Widget buildSocialButton(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget buildSocialButtonRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildGenericButton(null, 'LOGIN WITH FACEBOOK'),
          buildGenericButton(null, 'LOGIN WITH GOOGLE'),
          buildGenericButton(null, 'LOGIN WITH APPLE'),
        ],
      ),
    );
  }

  Widget buildRegistrationButton() {
    return GestureDetector(
      onTap: () => ExtendedNavigator.ofRouter<Router>()
          .pushNamed(Routes.registrationWidget),
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
  }

  Widget headerText() {
    return Text(
      'Sign In',
      style: TextStyle(
        color: buttonColor,
        fontFamily: 'OpenSans',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildForm(BuildContext context, LoginState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        headerText(),
        SizedBox(height: 15.0),
        loginRegistrationTextForm(_emailKey, _emailController, "Email",
            hintText: "Enter your Email",
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress),
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
            obscureText: _textObscured),
        buildForgotPasswordButton(),
        buildRememberMeCheckbox(),
        buildGenericButton(onPressed, 'LOGIN'),
        Container(
            child:
                state is LoginInProgress ? CircularProgressIndicator() : null),
        buildSignInWithText(),
        buildSocialButtonRow(),
        buildRegistrationButton(),
      ],
    );
  }

  void onPressed(LoginState state) {
    if (state is! LoginInProgress)
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(email: _emailController.text, password: _passwordController.text));
  } 

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailure)
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.black,
        ));
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return buildForm(context, state);
      },
    ));
  }
}
