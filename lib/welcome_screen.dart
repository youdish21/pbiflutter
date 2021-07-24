import 'package:flutter/material.dart';
import 'route.dart'as route;


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {



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
      child: Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text("Welcome!",
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xfff9f9f9),
                        ),
                      ),
                    ),
                  ),


                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Image.asset(
                        "assets/Untitled-1.png",
                        fit: BoxFit.contain,
                        width: 290,
                      ),
                    ),
                  ),


                  Center(
                      child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                            onPrimary: Color(0xff001d37),
                            primary: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                          child: Text("Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, route.signIn

                            );
                          }
                      ),
                    ),

                  Center(
                    child:Padding(
                      padding:EdgeInsets.all(16.0),
                      child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                            onPrimary: Color(0xff00213f),
                            primary: Color(0xff9e9ef8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                          child: Text("Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, route.signUp

                            );

                          }
                      ),
                    ),
                  ),
                  Center(
                      child:TextButton(
                          child: Text("Sign in Anonymously",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onPressed: () {

                            Navigator.pushNamed(
                                context, route.phoneA);
                          }
                      ),
                    ),


                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14,top: 12),
                      child: Image.asset(
                        "assets/Logo-PML.png",
                        fit: BoxFit.contain,
                        width: 120,
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ),
        ),
      ),
    );
  }
}



