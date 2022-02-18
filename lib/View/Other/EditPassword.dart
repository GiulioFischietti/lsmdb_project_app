import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/View/Other/ResponseData.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore_for_file: file_names

import 'NeedfyAppBar.dart';

class EditPassword extends StatefulWidget {
  EditPassword({Key key}) : super(key: key);

  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  bool repeatPswError = false;
  TextEditingController pswController = new TextEditingController();
  TextEditingController repeatPswController = new TextEditingController();

  void updatePassword() async {
    if (pswController.text == repeatPswController.text) {
      setState(() {
        repeatPswError = false;
      });
      final response =
          await Request.post('password', {"pwd": pswController.text});
      ResponseData responseData = ResponseData.fromJson(json.decode(response));

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(!responseData.error
              ? "Password cambiata con successo"
              : "Errore"),
          content: Text(responseData.message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        repeatPswError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        appBar: basicAppBar(
            context, languageProvider.text.profileText.modify_password),
        body: SafeArea(
            child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Row(children: [
              Expanded(
                  child: Container(
                      child: Text(
                          languageProvider.text.profileText.password_new,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF999999), fontSize: 14)))),
              repeatPswError
                  ? Container(
                      margin: EdgeInsets.only(right: 0),
                      child: Text("Le due password non coincidono",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.red, fontSize: 12)))
                  : Container()
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, left: 20, right: 20),
            height: 40,
            child: TextFormField(
              obscureText: true,
              controller: pswController,
              style: Theme.of(context).textTheme.bodyText1,
              cursorColor: Theme.of(context).primaryColorLight,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.error,
                    color: repeatPswError ? Colors.red : Colors.transparent),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).primaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).accentColor)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(children: [
              Expanded(
                  child: Container(
                      child: Text(
                          languageProvider.text.profileText.password_confirm,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: Color(0xFF999999), fontSize: 14)))),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, left: 20, right: 20),
            height: 40,
            child: TextFormField(
              obscureText: true,
              controller: repeatPswController,
              style: Theme.of(context).textTheme.bodyText1,
              cursorColor: Theme.of(context).primaryColorLight,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.error,
                    color: repeatPswError ? Colors.red : Colors.transparent),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).primaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Theme.of(context).accentColor)),
              ),
            ),
          ),
          Expanded(child: Container()),
          TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  primary: Colors.transparent.withOpacity(0)),
              onPressed: () {
                updatePassword();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFf9b701),
                      borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  // width: size.width,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        languageProvider.text.profileText.update,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ))))
        ])),
      );
    });
  }
}
