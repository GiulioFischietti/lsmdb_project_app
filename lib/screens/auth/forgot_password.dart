import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:eventi_in_zona/widgets/user/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'SignUp.dart';
import 'dart:convert';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Scaffold(
        backgroundColor: Colors.grey[100],
        body: Container(
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
                child: Text("Recupera Password",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle:
                            TextStyle(fontSize: 16, color: Colors.black))),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
                  child: Container(
                    child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        autocorrect: false,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon:
                              Icon(Icons.email, color: Colors.grey[800]),
                          labelStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.grey[800])),
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusColor: Colors.grey[800],
                          hoverColor: Colors.black.withOpacity(0.8),
                          labelText: 'Email',
                        )),
                  )),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                child: InkWell(
                  onTap: () async {
                    final postMdl =
                        Provider.of<UserProvider>(context, listen: false);
                    var response =
                        await postMdl.recoverPassword(emailController.text);
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => CustomDialog(
                    //         icon: Icon(Icons.check_circle,
                    //             color: Colors.green, size: 80),
                    //         message: "Email per il recupero password inviata",
                    //         exitMessage: "Ok",
                    //         cancelable: false,
                    //         onExitButtonPress: () {
                    //           Navigator.of(context).pop(context);
                    //           Navigator.of(context).pop(context);
                    //         }));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Reset Password",
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
            ])))));
  }
}
