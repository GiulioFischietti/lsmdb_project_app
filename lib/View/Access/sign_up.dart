import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

bool privacyProfilation = false;
bool privacyOffers = false;

class _SignUpState extends State<SignUp> {
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
      child: Container(
          child: ListView(children: [
        Container(
            margin: EdgeInsets.only(top: 60),
            alignment: Alignment.center,
            child: Text('Needfy',
                style: TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF9b701)))),
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 40),
            alignment: Alignment.center,
            child: Text('Registra un account Needfy',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.9)))),
        Container(
            height: 45,
            margin: EdgeInsets.only(top: 15, left: 30, right: 30),
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                style: TextStyle(color: Colors.grey[800]),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusColor: Colors.grey[400],
                  hoverColor: Colors.grey[400],
                  labelText: 'Email',
                ))),
        Container(
            height: 45,
            margin: EdgeInsets.only(top: 15, left: 30, right: 30),
            child: TextFormField(
                obscureText: true,
                autocorrect: false,
                style: TextStyle(color: Colors.grey[800]),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusColor: Colors.grey[400],
                  hoverColor: Colors.grey[400],
                  labelText: 'Password',
                ))),
        Container(
            height: 45,
            margin: EdgeInsets.only(top: 15, left: 30, right: 30),
            child: TextFormField(
                obscureText: true,
                autocorrect: false,
                style: TextStyle(color: Colors.grey[800]),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent, width: 2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 2.0),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  focusColor: Colors.grey[400],
                  hoverColor: Colors.grey[400],
                  labelText: "Ripeti Password",
                ))),
        Container(
            width: size.width,
            margin: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: 7.5,
            ),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Color(0xFFF9b701)),
                onPressed: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.5),
                  child: Text("Registrati",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                ))),
      ])),
    ));
  }
}
