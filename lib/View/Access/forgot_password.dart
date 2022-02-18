import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only(top: 60),
                          alignment: Alignment.bottomCenter,
                          child: Text('Needfy',
                              style: TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF9b701))))),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                          'Recupera il tuo account Needfy. \nRiceverai Email con le istruzioni da seguire.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w700))),
                  Expanded(
                      flex: 2,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 45,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: 15, left: 30, right: 30),
                                child: TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(color: Colors.grey[800]),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 20.0),
                                      labelStyle:
                                          TextStyle(color: Colors.grey[400]),
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 2.0),
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      focusColor: Colors.grey[400],
                                      hoverColor: Colors.grey[400],
                                      labelText: 'Email',
                                    ))),
                            Container(
                                width: size.width,
                                margin: EdgeInsets.only(
                                  top: 30,
                                  left: 30,
                                  right: 30,
                                  bottom: 7.5,
                                ),
                                child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        backgroundColor: Color(0xFFF9b701)),
                                    onPressed: () {},
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 12.5),
                                      child: Text('Prosegui',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700)),
                                    )))
                          ])),
                ]))));
  }
}
