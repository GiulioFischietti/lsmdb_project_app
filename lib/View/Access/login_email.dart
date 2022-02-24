import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/LoginEmailResponse.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/BottomTab/BottomTabContainer.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/View/Other/ResponseData.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'forgot_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'sign_up.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  bool isLoading = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('./assets/background-login4-min.jpg'))),
            child: (isLoading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Expanded(
                            flex: 1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      child: Text('Needfy',
                                          style: TextStyle(
                                              fontSize: 72,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFF9b701)))),
                                  Container(
                                      child: Text(
                                          "Accedi con il tuo account needfy",
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(0.9),
                                              fontWeight: FontWeight.w700)))
                                ])),
                        Expanded(
                            flex: 2,
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 40, left: 30, right: 30),
                                alignment: Alignment.topCenter,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 45,
                                          child: TextFormField(
                                              controller: emailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              autocorrect: false,
                                              style: TextStyle(
                                                  color: Colors.grey[800]),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 20.0),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                filled: true,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.grey[400],
                                                hintText: 'Email',
                                              ))),
                                      Container(
                                          height: 45,
                                          margin: EdgeInsets.only(top: 15),
                                          child: TextFormField(
                                              controller: pwdController,
                                              obscureText: true,
                                              autocorrect: false,
                                              style: TextStyle(
                                                  color: Colors.grey[800]),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 20.0),
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400]),
                                                filled: true,
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                ),
                                                focusColor: Colors.grey[400],
                                                hoverColor: Colors.grey[400],
                                                hintText: 'Password',
                                              ))),
                                      Container(
                                          width: size.width,
                                          margin: EdgeInsets.only(
                                            top: 30,
                                            bottom: 7.5,
                                          ),
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  backgroundColor:
                                                      Color(0xFFF9b701)),
                                              onPressed: () {
                                                final userMdl =
                                                    Provider.of<UserProvider>(
                                                        context,
                                                        listen: false);
                                                userMdl.login(
                                                    emailController.text,
                                                    pwdController.text,
                                                    context);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 12.5),
                                                child: Text("Accedi",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700)),
                                              ))),
                                      Container(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                child: Text(
                                                  "Password dimenticata",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ForgotPassword()));
                                            },
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SignUp()));
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Text(
                                                    "Registrati",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))
                                        ],
                                      ))
                                    ]))),
                      ]))));
  }
}
