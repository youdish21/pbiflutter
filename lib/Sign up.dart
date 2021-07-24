
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pbiflutter/LoginInputs.dart';
import 'package:pbiflutter/auth.dart';
import 'package:pbiflutter/welcome_screen.dart';
import 'package:email_auth/email_auth.dart';
import 'route.dart'as route;

class SignUp extends StatefulWidget {



  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool submitValid = false;

  final databaseReference = FirebaseDatabase.instance.reference().child("Users");
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  final _otpController = TextEditingController();







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
          )
        ),
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric( horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding:  EdgeInsets.symmetric(horizontal: 20 ),
                              child: Image.asset(
                                "assets/Untitled-1.png",
                                fit: BoxFit.contain,
                                width: 150,
                              ),
                            ),



                            SizedBox(height: 30,),
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
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Please check your Email."),
                                        content:   TextFormField(
                                          controller: _otpController,
                                          decoration: InputDecoration(
                                            labelText: 'Please enter OTP',
                                            labelStyle: TextStyle(
                                              color:Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed:(){ sendOtp();},
                                              child: Text("Click here for OTP request")),
                                          TextButton(
                                            child: Text("Verify"),
                                            onPressed: (){verifyOTP();},
                                          ),
                                        ],
                                      ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child:TextButton(
                                  child: Text("Already have an account? Sign In",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  onPressed: () {
                                    if(_formKey.currentState.validate())
                                    {
                                      print("successful");
                                      return;
                                    }else{
                                      print("UnSuccessful");
                                    }
                                    Navigator.pushNamed(context,route.signIn);
                                  }
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ]
              ),
          ),
        ),
      ),
    );
  }

  void sendOtp()async{
    EmailAuth.sessionName =" PBI";
    var data =
        await EmailAuth.sendOtp(receiverMail: _emailFieldController.text);
    if (data){
      print("OTP Send");
    }else{
      print("Problem with sending OTP");
    }
  }

  void verifyOTP() async{
    var res= EmailAuth.validate(receiverMail: _emailFieldController.text, userOTP: _otpController.text);
    if(res){
      print("OTP Verified");
      _onSubmitLoginButton(context);

    }else{
      print("Error could not send OTP.");
    }
  }



  bool _validate() {

    final FormState form = _formKey.currentState;
    return form.validate();
  }

  _onSubmitLoginButton(context)async{
    if(_validate()){
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Creating User'),
      ),
      );
      final User user = await _auth. createUserWithEmailAndPassword(
        email:_emailFieldController.text,
        password: _passwordFieldController.text,
      );

      if(user != null){


        Navigator.pushNamed(context, route.homePage);


      }


    }
  }
  // ignore: non_constant_identifier_names



}


