import 'package:flutter/material.dart';
import 'package:pbiflutter/Sign up.dart';
import 'file:///C:/Users/youdish/pbiflutter/lib/forgotPassword.dart';
import 'package:pbiflutter/phoneLogin.dart';
import 'package:pbiflutter/verify.dart';
import 'file:///C:/Users/youdish/pbiflutter/lib/welcome_screen.dart';
import 'file:///C:/Users/youdish/pbiflutter/lib/Sign%20In.dart';
import 'package:pbiflutter/homPage.dart';
import 'reg.dart';

const String signUp = 'signUp';
const String signIn = 'signIn';
const String homePage = 'home';
const String welcome = 'welcome';
const String forgetPass = 'forgetPass';
const String verify = 'verify';
const String phoneAuth = 'phoneAuth';
const String phoneAuth1 = 'MyLoginPage';
const String phoneA = 'MyHomepage';

Route<dynamic> controller(RouteSettings settings){
  switch (settings.name){
    case signUp:
      return MaterialPageRoute(builder: (context) => SignUp());
    case signIn:
      return MaterialPageRoute(builder: (context) => SignIn());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case welcome:
      return MaterialPageRoute(builder: (context) => Welcome());
    case forgetPass:
      return MaterialPageRoute(builder: (context) => ForgotPassword());
    case verify:
      return MaterialPageRoute(builder: (context) => Verify());
    case phoneAuth:
      return MaterialPageRoute(builder: (context) => PhoneLogin());
    case phoneA:
      return MaterialPageRoute(builder: (context) => MyHomePage());


    default:
      throw('This route name does not exists');
  }

}
