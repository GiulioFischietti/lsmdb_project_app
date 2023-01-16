import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/auth/forgot_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:eventi_in_zona/screens/auth/signup_manager.dart';
import 'package:eventi_in_zona/screens/manager/bottomtabcontainer_manager.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:eventi_in_zona/screens/user/home.dart';
import 'package:provider/provider.dart';
import 'SignUp.dart';
import 'dart:convert';

bool isLoggedIn = false;
bool loading = false;

class LoginAsManager extends StatefulWidget {
  @override
  _LoginAsManagerState createState() => _LoginAsManagerState();
}

class _LoginAsManagerState extends State<LoginAsManager> {
  initState() {
    loading = false;
    user_name = "";
  }

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
                      child: Text("Log In to your Manager account",
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
                              keyboardType: TextInputType.name,
                              controller: usernameController,
                              autocorrect: false,
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
                            margin: EdgeInsets.only(right: 5),
                            child: InkWell(
                              child: Text("Sign Up as Manager",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.black))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignUpAsManager()));
                              },
                            ),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 20),
                      child: InkWell(
                        onTap: () async {
                          final managerProvider = Provider.of<ManagerProvider>(
                              context,
                              listen: false);
                          bool success = await managerProvider.logInAsManager(
                              usernameController.text, pwdController.text);
                          if (success) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => BottomTabContainerManager(
                                      initialIndex: 0,
                                    )));
                          }
                        },
                        // color: Colors.orange[300],
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(10.0)),
                        // padding: EdgeInsets.all(15.0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Log In as Manager",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 16)),
                          ),
                        ),
                      ),
                    )
                  ])))
            : Container(
                height: size.height,
                child: Center(child: CircularProgressIndicator()))));
  }
}
