import 'dart:convert';
// ignore_for_file: file_names

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Engine/Utility.dart/DefaultLanguage.dart';
import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../BottomTab/BottomTabContainer.dart';
import 'sign_up.dart';

import 'dart:io';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

String prettyPrint(Map json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

bool isLoadingLogin = false;

class _LoginState extends State<Login> {
  Map<String, dynamic> _userData;

  bool _checking = true;

  @override
  void initState() {
    super.initState();
  }

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
            child: SafeArea(
                child: (isLoadingLogin)
                    ? Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                            CircularProgressIndicator(),
                          ]))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.remove('access_token');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomTabContainer()));
                                  },
                                  child: Text(
                                    "Salta",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                            "Tutti i tuoi eventi, in una sola app",
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                fontWeight: FontWeight.w700)))
                                  ])),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  alignment: Alignment.bottomCenter,
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Container(
                                        //     width: size.width,
                                        //     margin: EdgeInsets.only(
                                        //         bottom: 5, left: 20, right: 20),
                                        //     child: OutlinedButton(
                                        //         style: OutlinedButton.styleFrom(
                                        //             shape: RoundedRectangleBorder(
                                        //               borderRadius:
                                        //                   BorderRadius.circular(30),
                                        //             ),
                                        //             backgroundColor: Color(0xFFde5246)),
                                        //         onPressed: () {
                                        //           Navigator.push(
                                        //               context,
                                        //               MaterialPageRoute(
                                        //                   builder: (context) =>
                                        //                       SignUp()));
                                        //         },
                                        //         child: Container(
                                        //           margin: EdgeInsets.symmetric(
                                        //               vertical: 12.5),
                                        //           child: Text('Accedi con Google',
                                        //               style: TextStyle(
                                        //                   color: Colors.white,
                                        //                   fontSize: 16,
                                        //                   fontWeight: FontWeight.w700)),
                                        //         ))),

                                        Container(
                                            width: size.width,
                                            margin: EdgeInsets.only(
                                                bottom: 5, left: 20, right: 20),
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    backgroundColor:
                                                        Color(0xFFF9b701)),
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignUp()));
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 12.5),
                                                  child: Text(
                                                      'Registrati con Email',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700)),
                                                ))),
                                        Row(
                                          children: const [
                                            Expanded(
                                                child: Divider(
                                              height: 20,
                                              thickness: 3,
                                              color: Colors.white,
                                              indent: 40,
                                              endIndent: 20,
                                            )),
                                            Text('o',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            Expanded(
                                                child: Divider(
                                              height: 20,
                                              thickness: 3,
                                              color: Colors.white,
                                              indent: 20,
                                              endIndent: 40,
                                            ))
                                          ],
                                        ),
                                        Container(
                                            width: size.width,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 5),
                                            child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                backgroundColor:
                                                    Colors.grey[400],
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LoginEmail()));
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 12.5),
                                                  child: Text('Log In',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight
                                                              .w700))),
                                            )),
                                      Container(height: 40)
                                      ]))),
                        ],
                      ))));
  }
}
