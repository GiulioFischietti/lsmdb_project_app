import 'package:eventi_in_zona/models/entity_manager.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:eventi_in_zona/screens/manager/bottomtabcontainer_manager.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';

class SignUpAsManager extends StatefulWidget {
  @override
  SignUpAsManagerState createState() => SignUpAsManagerState();
}

class SignUpAsManagerState extends State<SignUpAsManager> {
  TextEditingController nameController = new TextEditingController();

  TextEditingController usernameController = new TextEditingController();
  TextEditingController linkController =
      new TextEditingController(text: "https://www.facebook.com/");
  TextEditingController pwdController = new TextEditingController();
  TextEditingController pwdRepeatController = new TextEditingController();
  EntityManager entityManager = EntityManager({});
  var _privacyprofilazione = false;
  var _privacyofferte = false;
  bool _errorNameVisible = false;
  bool _errorEmailVisible = false;
  bool _errorusernameVisible = false;
  bool _errorPageVisible = false;
  bool _errorPwdVisible = false;
  bool _errorPhoneVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Container(
          alignment: Alignment.center,
          color: Colors.grey[100],
          height: size.height,
          width: double.infinity,
          child: ListView(shrinkWrap: true, children: [
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
              child: Text("Create a manager account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 16, color: Colors.black))),
            ),
            _errorNameVisible
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Name not valid",
                      style: TextStyle(color: Colors.red[600]),
                    ))
                : Container(),
            Padding(
                padding:
                    EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 10),
                child: Container(
                  child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      autocorrect: false,
                      style: TextStyle(color: Colors.grey[800]),
                      onChanged: (String text) {
                        entityManager.name = text;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.grey[800]),
                        labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey[800])),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.grey[600],
                        hoverColor: Colors.grey[600],
                        labelText: 'Name',
                      )),
                )),
            userProvider.usernameTaken
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Username taken",
                      style: TextStyle(color: Colors.red[600]),
                    ))
                : Container(),
            Padding(
                padding:
                    EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 10),
                child: Container(
                  child: TextFormField(
                      controller: usernameController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.grey[800]),
                      onChanged: (String text) {
                        entityManager.username = text;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon:
                            Icon(Icons.person_outline, color: Colors.grey[800]),
                        labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey[800])),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.grey[800],
                        hoverColor: Colors.grey[800],
                        labelText: 'Username',
                      )),
                )),
            _errorPageVisible
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Page not existing",
                      style: TextStyle(color: Colors.red[600]),
                    ))
                : Container(),
            Padding(
                padding:
                    EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 10),
                child: Container(
                  child: TextFormField(
                      controller: linkController,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.grey[800]),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon:
                            Icon(Icons.facebook, color: Colors.grey[800]),
                        labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey[800])),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.grey[800],
                        hoverColor: Colors.grey[800],
                        labelText: 'Link of Facebook Official Page',
                      )),
                )),
            _errorPwdVisible
                ? Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Passwords do not match, try again",
                      style: TextStyle(color: Colors.red[600]),
                    ))
                : Container(),
            Padding(
                padding:
                    EdgeInsets.only(bottom: 15, right: 20, left: 20, top: 10),
                child: Container(
                  child: TextFormField(
                      obscureText: true,
                      controller: pwdController,
                      autocorrect: false,
                      onChanged: (String text) {
                        entityManager.password = text;
                      },
                      style: TextStyle(color: Colors.grey[800]),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.grey[800]),
                        labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey[800])),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: _errorPwdVisible
                                  ? Colors.red[600]!
                                  : Colors.transparent,
                              width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.grey[800],
                        hoverColor: Colors.grey[800],
                        labelText: 'Password',
                      )),
                )),
            Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                child: Container(
                  child: TextFormField(
                      controller: pwdRepeatController,
                      autocorrect: false,
                      style: TextStyle(color: Colors.grey[800]),
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.lock, color: Colors.grey[800]),
                        labelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.grey[800])),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: _errorPwdVisible
                                  ? Colors.red[600]!
                                  : Colors.transparent,
                              width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusColor: Colors.grey[800],
                        hoverColor: Colors.grey[800],
                        labelText: 'Repeat Password',
                      )),
                )),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: userProvider.usernameTaken
                    ? Colors.grey
                    : Colors.orange[300],
              ),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
              child: InkWell(
                onTap: () async {
                  if (nameController.text == '' ||
                      (pwdController.text != pwdRepeatController.text)) {
                    if (nameController.text == '') {
                      setState(() {
                        _errorNameVisible = true;
                      });
                    } else {
                      setState(() {
                        _errorNameVisible = false;
                      });
                    }

                    if ((pwdController.text != pwdRepeatController.text) ||
                        pwdController.text == '' ||
                        pwdRepeatController.text == '') {
                      setState(() {
                        _errorPwdVisible = true;
                      });
                    } else {
                      setState(() {
                        _errorPwdVisible = false;
                      });
                    }
                  } else {
                    userProvider.manager.name = nameController.text;
                    userProvider.manager.username = usernameController.text;
                    userProvider.manager.password = pwdController.text;

                    final success = await userProvider.signUpAsAManager(
                      entityManager,
                      linkController.text,
                    );

                    if (success) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => BottomTabContainerManager(
                                initialIndex: 0,
                              )));
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up as Manager",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Are you a new App User?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.black)))),
                    InkWell(
                      child: Text("Sign Up as App User",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.orange))),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )),
          ]));
    }));
  }
}
