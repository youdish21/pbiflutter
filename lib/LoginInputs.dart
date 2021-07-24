import 'package:flutter/material.dart';
import 'package:pbiflutter/validators.dart';

class LoginInputs extends StatelessWidget {
  const LoginInputs({
    Key key,
    this.emailFieldController,
    this.passwordFieldController,
}) : super(key: key);
  final emailFieldController;
  final passwordFieldController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: Key('email'),
          controller: emailFieldController,
          decoration: InputDecoration(
            labelText: 'Email',
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
        SizedBox(height: 30,),
        TextFormField(
          key: Key('password'),
          controller: passwordFieldController,
          autocorrect: false,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'SecurePassword',
            labelStyle: TextStyle(
              color:Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: Colors.black54,
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
          validator: Validators.validatePassword,

        ),
      ],
    );
  }
}
