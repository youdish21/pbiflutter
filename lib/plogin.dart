import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String strVerificationId;
  final globalKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneNumEditingController = TextEditingController();
  TextEditingController smsEditingController = TextEditingController();
  bool showVerifyNumberWidget = true;
  bool showVerificationCodeWidget = false;
  bool showSuccessWidget = false;



  @override
  void initState() {
    super.initState();
    getCurrentNumber();
  }

  getCurrentNumber() async {
    phoneNumEditingController.text = await smsAutoFill.hint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Firebase Phone Authentication Sample'),
        ),
        key: globalKey,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if(showVerifyNumberWidget) TextFormField(
                    controller: phoneNumEditingController,
                    decoration: const InputDecoration(
                        labelText: 'Enter Phone number'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if(showVerifyNumberWidget) Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        primary: Colors.pinkAccent,
                      ),

                      child: Text("Verify Number", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                      onPressed: () async {
                        phoneNumberVerification();
                      },
                    ),
                  ),
                  if(showVerificationCodeWidget) TextFormField(
                    controller: smsEditingController,
                    decoration: const InputDecoration(labelText: 'Verification code'),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  if(showVerificationCodeWidget) Container(
                    padding: const EdgeInsets.only(top: 16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                      ),
                        onPressed: () async {
                          signInWithPhoneNumber();
                        },
                        child: Text("Sign in", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))
                    ),
                  ),
                  if(showSuccessWidget) Text('You are successfully logged in!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
                ],
              )),
        ));
  }

  Future<void> phoneNumberVerification() async {

    PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await firebaseAuth.signInWithCredential(phoneAuthCredential);
      displayMessage(
          "Phone number is automatically verified and user signed in: ${firebaseAuth.currentUser.uid}");
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    };

    PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException authException) {
      displayMessage('Phone number verification is failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneCodeSent phoneCodeSent =
        (String verificationId, [int forceResendingToken]) async {
      displayMessage('Please check your phone for the verification code.');
      this.verificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    };

    PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      displayMessage("verification code: " + verificationId);
      strVerificationId = verificationId;
      setState(() {
        showVerifyNumberWidget = false;
        showVerificationCodeWidget = true;
      });
    };

    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: ('+230'+phoneNumEditingController.text),
          timeout: const Duration(seconds: 5),
          verificationCompleted: phoneVerificationCompleted,
          verificationFailed: phoneVerificationFailed,
          codeSent: phoneCodeSent,
          codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
    } catch (e) {
      displayMessage("Failed to Verify Phone Number: e");
    }
  }

  void displayMessage(String message) {
    // ignore: deprecated_member_use
    globalKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: strVerificationId,
        smsCode: smsEditingController.text,
      );

      final User user = (await firebaseAuth.signInWithCredential(credential)).user;

      displayMessage("Successfully signed in UID: ${user.uid}");

      setState(() {
        showVerificationCodeWidget = false;
        showSuccessWidget = true;
      });
    } catch (e) {
      displayMessage("Failed to sign in: " + e.toString());
    }
  }
}