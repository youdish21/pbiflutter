import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbiflutter/LoginInputs.dart';
import 'package:pbiflutter/analytics.dart';
import 'package:pbiflutter/auth.dart';
import 'package:pbiflutter/welcome_screen.dart';
import 'route.dart'as route;
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  final AnalyticsService _analyticsService = AnalyticsService();
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.indigo,
              Colors.white,
            ],
          )
      ),

      child:Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(Welcome()),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 20 ),
                  child: Image.asset(
                    "assets/Untitled-1.png",
                    fit: BoxFit.contain,
                    width: 250,
                  ),
                ),

                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 20 ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: LoginInputs(
                            emailFieldController: _emailFieldController,
                            passwordFieldController: _passwordFieldController,
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20, ),
                          child:ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                              onPrimary: Color(0xff001d37),
                              primary: Colors.indigo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                              ),
                            ),
                            onPressed: () {
                              _onSubmitLoginButton(context);
                            }
                            ,
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child:TextButton(
                              child: Text("Forgot password?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,route.forgetPass

                                );
                              }
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 1.0, ),
                          child:TextButton(
                              child: Text("Don't have an account? Sign Up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,route.signUp);
                              }
                          ),
                        ),


                      ],
                    ),


                  ) ,

              ),
            ],
          ),

        ),

      ),
      ),
    );
  }



  bool _isFormValidated() {

    final FormState form = _formKey.currentState;
    return form.validate();
  }
  _onSubmitLoginButton(context)async{

    if(_isFormValidated()){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signing In'),
        ),
      );

      final User user = await _auth. signInWithEmailAndPassword(
        email:_emailFieldController.text,
        password: _passwordFieldController.text,
      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if(user != null){
        Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        _analyticsService.logLogin();
        _analyticsService.setUserProperties(
          userId: user.uid,
          userRole: 'User',
        );
        Navigator.pushNamed(context,route.homePage);

      }else {
        Fluttertoast.showToast(
            msg: "Incorrect Please Try Again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }


    }
  }
}




