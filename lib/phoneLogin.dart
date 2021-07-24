import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pbiflutter/welcome_screen.dart';
import 'route.dart'as route;





class PhoneLogin extends StatefulWidget {
  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {

  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _phoneFieldController = TextEditingController();
  final _userNameController = TextEditingController();

  // ignore: missing_return
  Future <bool> loginUser(String phone, BuildContext context)async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: ('+230'+ phone),
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();
          UserCredential result = await _auth.signInWithCredential(credential);

          User user =result.user;

          if(user != null){
            Navigator.pushNamed(context,route.homePage);
          }else{
            print("Error");
          }
        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception);
        },
        codeSent: (String verificationId,[int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context){
                return AlertDialog(
                  title: Text("Verification code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      )
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: ()async{
                          AuthCredential credential= PhoneAuthProvider.credential(verificationId:verificationId, smsCode:_codeController.text);

                          UserCredential result = await _auth.signInWithCredential(credential);

                          User user = result.user;
                          if(user != null){
                            Navigator.pushNamed(context,route.homePage);
                          }else{
                            print("Error");
                          }
                        },
                        child: Text("Confirm")
                    ),
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null,
    );
  }
  
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _userNameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                hintText: 'John Smith',
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

                            ),
                            TextFormField(
                              controller: _phoneFieldController,
                              decoration: InputDecoration(
                                labelText: 'Number',
                                hintText: 'Phone Number',
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
                                  final phone = _phoneFieldController.text;
                                  loginUser(phone, context);

                                },
                                child: Text('Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ),
                          ]
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
}


