import 'package:atletico_app/util/device_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final String atleticoURL = "http://10.0.2.2:8080/api/v1";

final hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final boxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(6.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

Widget loginSignUpScaffold(BuildContext context, List<Widget> widgets) {
  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widgets,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget loginSignupTextForm(
    Key key, TextEditingController controller, String label,
    {bool autoValidate = false,
    bool readOnly = false,
    bool showCursor = true,
    TextInputType keyboardType,
    IconData prefixIcon,
    StatelessWidget suffixIcon,
    String hintText = "",
    bool obscureText = false,
    Function onTap,
    List functionParamters,
    String Function(String) validator,
    Function onSaved,
    Function onChanged}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: labelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: boxDecorationStyle,
        height: 60.0,
        child: TextFormField(
          key: key,
          autovalidate: autoValidate,
          readOnly: readOnly,
          showCursor: showCursor,
          onChanged: (value) => onChanged != null ? onChanged(value) : null,
          onSaved: (newValue) => onSaved != null ? onSaved(newValue) : null,
          validator: (value) => validator != null ? validator(value) : null,
          onTap: () =>
              onTap != null ? Function.apply(onTap, functionParamters) : null,
          maxLines: 1,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType != null ? keyboardType : null,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Colors.white,
                  )
                : null,
            suffixIcon: suffixIcon != null ? suffixIcon : null,
            hintText: hintText,
            hintStyle: hintTextStyle,
          ),
        ),
      ),
    ],
  );
}

Route routeToWidget(StatefulWidget widget, Offset offset) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = offset;
      var end = Offset.zero;
      var curve = Curves.easeInCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  var orientation = mediaQueryData.orientation;

  //Device width is dependent on the orientation of the device
  double deviceWidth = 0;
  if (orientation == Orientation.landscape) {
    deviceWidth = mediaQueryData.size.height;
  } else {
    deviceWidth = mediaQueryData.size.width;
  }
  if (deviceWidth > 950) return DeviceScreenType.Desktop;
  if (deviceWidth > 600) return DeviceScreenType.Tablet;
  return DeviceScreenType.Mobile;
}
