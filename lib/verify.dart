import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'route.dart'as route;


class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  // ignore: must_call_super
  @override
  void initState(){
    user= auth.currentUser;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {

    });

    super.initState();

  }
  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('An email has been sent ${user.email}  to please check your email' ),
      ),
    );
  }
  Future<void>checkEmailVerified()async{
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.pushNamed(context,route.homePage);
    }

  }
}
