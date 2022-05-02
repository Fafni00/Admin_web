// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:adimn_web/Homepage/Homepage.dart';
import 'package:adimn_web/Services/Services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebseServices _services = FirebseServices();
  final _formkey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    Future<void> _login() async {
      _services.getAdminCredentials().then((value) {
        value.docs.forEach((doc) async {
          if (doc.get('username') == username) {
            if (doc.get('password') == password) {
              UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();
              if (userCredential.user?.uid != null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                return;
              } else {
                _showDialog(title: 'Login', message: 'Login Failed');
              }
            } else {
              _showDialog(
                  title: 'Invalid Password',
                  message: 'The Password you entered is not incorrect.');
            }
          } else {
            _showDialog(
                title: 'Invalid Password',
                message: 'The Password you entered is not incorrect.');
          }
        });
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff023020),
          title: Text('Sar Admin DashBoard',
              style: TextStyle(fontSize: 35, color: Colors.white)),
        ),
        body: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Connection failed'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xff5BC236), Colors.white],
                            stops: [1.0, 1.0],
                            begin: Alignment.topCenter,
                            end: Alignment(0.0, 0.0))),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 400,
                        child: Card(
                          elevation: 6,
                          shape: Border.all(color: Color(0xff5BC236), width: 2),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        child: Column(children: [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        child: Image.asset(
                                          'images/assets/logo.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Text(
                                        'Sar',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 40,
                                            color: Color(0xff023020)),
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Username';
                                          }
                                          setState(() {
                                            username = value;
                                          });
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'User Name',
                                          focusColor: Color(0xff90EE90),
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff5BC236),
                                                width: 2),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Enter Password';
                                          }
                                          if (value.length < 6) {
                                            return 'Minimum 6 Characters';
                                          }
                                          setState(() {
                                            password = value;
                                          });
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'Password',
                                          focusColor: Color(0xff90EE90),
                                          contentPadding: EdgeInsets.only(
                                              left: 20, right: 20),
                                          border: OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xff5BC236),
                                                width: 2),
                                          ),
                                        ),
                                      ),
                                    ])),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                _login();
                                              }
                                            },
                                            child: Text('Login'),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff5BC236)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ));
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future<void> _showDialog({title, message}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            )),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok')),
            ],
          );
        });
  }
}
