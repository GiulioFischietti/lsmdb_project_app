import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/Other/EditPassword.dart';
// ignore_for_file: file_names

import 'package:project_app/View/Other/EditProfile.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NeedfyAppBar.dart';

class Settings extends StatefulWidget {
  SharedPreferences prefs;
  Settings(this.prefs);
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Scaffold(
          appBar:
              basicAppBar(context, languageProvider.text.profileText.settings),
          backgroundColor: Color(0xFF141414),
          body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 40),
                _listTile(
                    Icon(FontAwesomeIcons.user, color: Colors.white, size: 18),
                    languageProvider.text.profileText.modify_profile, () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          EditProfile(
                              // user: widget.user,
                              ),
                      transitionDuration: Duration(seconds: 0),
                    ),
                  );
                }, context),
                this.widget.prefs.getBool("social_login") != null
                    ? !this.widget.prefs.getBool("social_login")
                        ? _listTile(
                            Icon(FontAwesomeIcons.key,
                                color: Colors.white, size: 18),
                            languageProvider.text.profileText.modify_password,
                            () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        EditPassword(),
                                transitionDuration: Duration(seconds: 0),
                              ),
                            );
                          }, context)
                        : Container()
                    : Container(),
                _listTile(
                    Icon(Icons.copy, color: Colors.white, size: 18),
                    languageProvider.text.authText.terms_text_4,
                    () {},
                    context),
                _listTile(Icon(Icons.lock, color: Colors.white, size: 18),
                    "Privacy", () {}, context),
                Expanded(child: Container()),
                _logout(context)
              ]));
    });
  }
}

Widget _listTile(
    Icon icon, String text, Function onPressed, BuildContext context) {
  return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Container(child: icon),
              Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(text,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 16)))
            ],
          )));
}

Widget _logout(BuildContext context) {
  return InkWell(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 40, left: 20),
          child: Row(
            children: [
              Container(child: Icon(Icons.logout, color: Colors.red)),
              Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text("Logout",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)))
            ],
          )));
}
