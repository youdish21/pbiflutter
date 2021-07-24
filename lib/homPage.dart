import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth.dart';
import 'route.dart'as route;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final databaseReference = FirebaseDatabase.instance.reference().child("Users");
  final Future<FirebaseApp> _future = Firebase.initializeApp();
  final auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final firstNameTextEditController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  User user;
  void initState(){
    user= auth.currentUser;


    super.initState();

  }



  // ignore: non_constant_identifier_names
  void addData() {
    databaseReference.push().set({'email':'${user.email}','Number' : '${phoneTextEditingController.text}','Name' : '${firstNameTextEditController.text}','comment': 'Transport request'});
  }

  void printFirebase(){
    databaseReference.push().set((DataSnapshot data) {
      // ignore: unnecessary_statements
      ('Data : ${data.value}');
    });
  }


  @override
  Widget build(BuildContext context) {

    printFirebase();
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
          leading: PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(child: TextButton.icon(onPressed: null, icon: Icon(Icons.add_call), label: Text("Contact"))),
              PopupMenuItem(child: TextButton.icon(
                icon: Icon(Icons.arrow_back),
                label:Text("Back"),
                onPressed:(){ Navigator.pushNamed(context, route.signIn);
                }
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              icon: Icon(Icons.logout),
              label:Text("Sign out"),
              onPressed:() async{
              await _auth.signOut();
              Navigator.pushNamed(context, route.welcome);
            },
            ),
          ],
        ),
        body: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 00),
                          child: Image.asset(
                            "assets/Untitled-1.png",
                            fit: BoxFit.contain,
                            width: 170,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your first name.';
                              }
                              return null;
                            },
                            controller: firstNameTextEditController,
                            keyboardType: TextInputType.text,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your first name.';
                              }
                              return null;
                            },
                            controller: phoneTextEditingController,
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
                        ),

                        Container(
                          width: 200.0,
                          height: 200.0,
                          child:ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Color(0xff001d37),
                                primary: Colors.indigo,
                                shape: CircleBorder(),
                              ),

                              child:Stack(
                                children:<Widget> [
                                  Center(child: Align(
                                    alignment: FractionalOffset.topCenter,
                                    child:Icon(
                                      Icons.directions_bus,
                                      size: 120,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ),
                                  Center(child: Align(
                                    alignment: FractionalOffset(0.5,0.7),
                                    child: Text("Click Here",
                                      style: TextStyle(fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Please enter Name & Phone number"),
                                    content:Text("Sending transport request.Please confirm.") ,
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text("Accept"),
                                        onPressed: (){
                                          addData();
                                          printFirebase();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                          child:Text("Cancel"),
                                          onPressed: (){
                                            Navigator.of(context).pop("Cancel");
                                          }
                                      ),
                                    ],
                                  ),
                                );
                                //call method flutter upload
                              }
                          ),

                        ),

                      ],
                    ),



                  ),


                );
              }
            }
            ),
      ),
    );
  }

}





