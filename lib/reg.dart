
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
enum InputType {
  phone,
  sms
}

class MyHomePage extends StatefulWidget {
  @override _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _phoneTextController = TextEditingController();
  final _smsCodeTextController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up with Phone'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _signUpTextFormField(InputType.phone),
            AnimatedContainer(
                height: _verificationId == null ? 0 : 80,
                duration: const Duration(milliseconds: 400),
                child: _verificationId != null ? _signUpTextFormField(InputType.sms) : Container()
            ),
            _signUpButton(InputType.phone),
            AnimatedContainer(
                height: _verificationId == null ? 0 : 74,
                duration: const Duration(milliseconds: 400),
                child: _signUpButton(InputType.sms)
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  // ------------ Make UI Code ------------
  Widget _signUpTextFormField(InputType type) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: type == InputType.phone ? TextInputType.phone : TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            icon: Icon(type == InputType.phone ? Icons.phone : Icons.sms),
            labelText: type == InputType.phone ? 'Phone' : 'SMS Code',
            hintText: type == InputType.phone ? 'Phone number with +(Country number)' : 'Type SMS Code'
        ),
        validator: (String value) => value.trim().isEmpty ? type == InputType.phone ? 'Phone is required' : 'SMS Code is required' : null,
        controller: type == InputType.phone ? _phoneTextController : _smsCodeTextController,
      ),
    );
  }

  Widget _signUpButton(InputType type){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(12.0),
        ),
        padding: EdgeInsets.all(16),
        textColor: type == InputType.phone ? Colors.black : Colors.white,
        color: type == InputType.phone ? Colors.white : Colors.blue[900],
        onPressed: () => type == InputType.phone ? _requestSMSCodeUsingPhoneNumber() : _signInWithPhoneNumberAndSMSCode(),
        child: Text(type == InputType.phone ? 'Request SMS Code' : 'Sign in with SMS Code', style: TextStyle(fontSize: 20),),
      ),
    );
  }

  // ------------ Make UI Code ------------

  // ------------ Functions for Sign UP Phone ------------
  String verificationId;
  int resendingToken;
  void _requestSMSCodeUsingPhoneNumber() async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneTextController.text,
        timeout: Duration(seconds:60),
        verificationCompleted: (AuthCredential phoneAuthCredential) => print('Sign up with phone complete'),
        verificationFailed: (FirebaseAuthException error) => print('error message is ${error.message}'),
        codeSent:(String verificationId, [int forceResendingToken])async {
          this.verificationId = await verificationId;
          this.resendingToken = await forceResendingToken;
          print('verificationId is $verificationId');
          setState(() => _verificationId = verificationId);
        },
        codeAutoRetrievalTimeout: null);
  }

  void _signInWithPhoneNumberAndSMSCode() async{
    AuthCredential authCreds = PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: _smsCodeTextController.text);
    final User user = (await FirebaseAuth.instance.signInWithCredential(authCreds)).user;
    print("User Phone number is" + user.phoneNumber);

    _smsCodeTextController.text = '';
    _phoneTextController.text = '';
    setState(() => _verificationId = null);
    FocusScope.of(context).requestFocus(FocusNode());
    _showSnackBar('Sign up with phone success. Check your firebase.');
  }

  // ------------ Functions for Sign UP Phone ------------

  // ------------ Show Message ------------
  void _showSnackBar(msg){
    final snackBar = SnackBar(content: Text(msg));
    // ignore: deprecated_member_use
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}