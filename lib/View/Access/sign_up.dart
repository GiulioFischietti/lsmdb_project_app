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
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
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
              margin: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: languageProvider.text.authText.terms_text_1 + ' ',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: languageProvider.text.authText.terms_text_2,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            print('aaaa');
                            if (await canLaunch(
                                "https://www.needfy.it/privacy/regolamento-Club-Needfy.pdf")) {
                              await launch(
                                "https://www.needfy.it/privacy/regolamento-Club-Needfy.pdf",
                                forceSafariVC: false,
                                forceWebView: false,
                                headers: <String, String>{
                                  'my_header_key': 'my_header_value'
                                },
                              );
                            } else {
                              throw 'Could not launch  "https://www.needfy.it/privacy/regolamento-Club-Needfy.pdf"';
                            }
                          },
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFf9b701),
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: ' ' +
                            languageProvider.text.authText.terms_text_3 +
                            ' ',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400)),
                    TextSpan(
                        text: languageProvider.text.authText.terms_text_4,
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () async {
                            print('aaaa');
                            if (await canLaunch(
                                "https://www.needfy.it/privacy/termini-e%20condizioni-di-uso.pdf")) {
                              await launch(
                                "https://www.needfy.it/privacy/termini-e%20condizioni-di-uso.pdf",
                                forceSafariVC: false,
                                forceWebView: false,
                                headers: <String, String>{
                                  'my_header_key': 'my_header_value'
                                },
                              );
                            } else {
                              throw 'Could not launch  "https://www.needfy.it/privacy/termini-e%20condizioni-di-uso.pdf"';
                            }
                          },
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFf9b701),
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: ' ' + languageProvider.text.authText.terms_text_5,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              )),
          Container(
              height: 45,
              margin: EdgeInsets.only(left: 30, right: 30, top: 40),
              child: TextFormField(
                  autocorrect: false,
                  style: TextStyle(color: Colors.grey[800]),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    labelStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusColor: Colors.transparent,
                    hoverColor: Colors.grey[400],
                    labelText: 'Username',
                  ))),
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
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2),
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
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2),
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
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 2.0),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    focusColor: Colors.grey[400],
                    hoverColor: Colors.grey[400],
                    labelText: languageProvider.text.authText.confirm_password,
                  ))),
          Container(
              margin: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 20),
              child: Text(
                languageProvider.text.authText.offers,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        privacyOffers = !privacyOffers;
                      });
                    },
                    value: privacyOffers,
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  languageProvider.text.authText.offers_text_1 +
                                      ' ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text:
                                  languageProvider.text.authText.offers_text_2,
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => print('Tap Here onTap'),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFf9b701),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          Container(
              margin: EdgeInsets.only(top: 30, bottom: 20, left: 30, right: 20),
              child: Text(
                languageProvider.text.authText.customization,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Checkbox(
                    onChanged: (val) {
                      setState(() {
                        privacyProfilation = !privacyProfilation;
                      });
                    },
                    value: privacyOffers,
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: languageProvider
                                      .text.authText.customization_text_1 +
                                  ' ',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: languageProvider
                                  .text.authText.customization_text_2,
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => print('Tap Here onTap'),
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFFf9b701),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  )
                ],
              )),
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
                    child: Text(languageProvider.text.login.register,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ))),
        ])),
      ));
    });
  }
}
