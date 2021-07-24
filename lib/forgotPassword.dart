import 'package:flutter/material.dart';
import 'package:pbiflutter/Sign%20In.dart';
import 'package:pbiflutter/auth.dart';
import 'package:pbiflutter/validators.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Forget Password"),
          backgroundColor: Colors.indigo,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(SignIn()),
      ),
    ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 30,vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(

                  children:<Widget> [
                    TextFormField(
                      key: Key('email'),
                      controller: _emailFieldController,
                      decoration: InputDecoration(
                        labelText: 'Enter email address',
                        hintText: 'Johnsmith@hfjfhn.com',
                        labelStyle: TextStyle(
                          color:Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                      cursorColor: Colors.black,
                      validator: Validators.validateEmail,
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Color(0xff001d37),
                        primary: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        ),
                      ),
                      onPressed: () {
                        _onSubmitLoginButton(context);
                        },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
                ],
            ),
          ),
        ),
      );
  }
  bool _isFormValidated(){
    final FormState form = _formKey.currentState;
    return form.validate();
  }
  _onSubmitLoginButton(context)async{
    if(_isFormValidated()){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("Wait please..."),
          ),
      );
      await _auth.sendPasswordResetEmail(
        email: _emailFieldController.text,

      );
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please check your email!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

