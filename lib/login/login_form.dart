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
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
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

  Widget buildLoginButton(LoginState state) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () =>
            state is! LoginInProgress ? onLoginButtonPressed() : null,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  Widget buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
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
          color: Colors.white,
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
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildSocialButton(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          buildSocialButton(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
          buildSocialButton(
            () => print('Login with Apple'),
            AssetImage(
              'assets/logos/apple.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegistrationButton() {
    return GestureDetector(
      onTap: () => ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.registrationWidget),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
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
        color: Colors.white,
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
        buildLoginButton(state),
        Container(
            child:
                state is LoginInProgress ? CircularProgressIndicator() : null),
        buildSignInWithText(),
        buildSocialButtonRow(),
        buildRegistrationButton(),
      ],
    );
  }

  void onLoginButtonPressed() {
    BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        email: _emailController.text, password: _passwordController.text));
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
