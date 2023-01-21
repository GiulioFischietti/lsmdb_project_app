import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:eventi_in_zona/screens/auth/login_manager.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../user/consent_location.dart';
import 'SignUp.dart';
import 'dart:convert';

bool isLoggedIn = false;
bool loading = false;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  initState() {
    loading = false;
    user_name = "";
  }

  TextEditingController hostnameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  bool _errorusernameVisible = false;
  bool _errorPwdVisible = false;
  String message = '';
  String user_name = '';
  String user_image = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Scaffold(
        backgroundColor: Colors.grey[100],
        body: !loading
            ? Container(
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topRight,
                      child: InkWell(
                        child: Icon(Icons.settings),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: const Text('Settings'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("Set IP Address of host"),
                                      TextFormField(
                                        controller: hostnameController,
                                      )
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.setString(
                                          "host", hostnameController.text);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 0),
                      alignment: Alignment.center,
                      child: Text("EventInZona",
                          textScaleFactor: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Text("Log In to your account",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16, color: Colors.black))),
                    ),
                    Container(
                        child: _errorusernameVisible
                            ? Container(
                                margin: EdgeInsets.only(left: 20, top: 20),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  message,
                                  style: TextStyle(color: Colors.red[600]),
                                ))
                            : Container()),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: 20, left: 20, right: 20, top: 10),
                        child: Container(
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: usernameController,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                filled: true,
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.grey[800]),
                                labelStyle: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: Colors.grey[800])),
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2.0),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusColor: Colors.grey[800],
                                hoverColor: Colors.black.withOpacity(0.8),
                                labelText: 'Username',
                              )),
                        )),
                    Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          child: TextFormField(
                              controller: pwdController,
                              autocorrect: false,
                              style: TextStyle(color: Colors.grey[800]),
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[800],
                                ),
                                labelStyle: GoogleFonts.poppins(
                                    textStyle:
                                        TextStyle(color: Colors.grey[800])),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 2.0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusColor: Colors.grey[800],
                                hoverColor: Colors.grey[800],
                                labelText: 'Password',
                              )),
                        )),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5),
                          )),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20, top: 10),
                            child: InkWell(
                              child: Text("Sign Up",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                            ),
                          )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        final prefs = await SharedPreferences.getInstance();
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        bool success = await userProvider.logIn(
                            usernameController.text, pwdController.text);

                        if (success) {
                          if (prefs.containsKey('delivery_address')) {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomTabContainer(
                                          initialIndex: 0,
                                        )));
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ConsentLocation()));
                          }
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      // color: Colors.orange[300],
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10.0)),
                      // padding: EdgeInsets.all(15.0),
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange[300],
                        ),
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 20),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Log In",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text("Are you aready Manager of a club?",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black)))),
                          InkWell(
                            child: Text("Log In as Manager",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Colors.orange))),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginAsManager()));
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container())
                  ])))
            : Container(
                height: size.height,
                child: Center(child: CircularProgressIndicator()))));
  }
}
