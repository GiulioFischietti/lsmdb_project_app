import 'dart:io';

import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/View/Other/NeedfyAppBar.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_app/View/Entities/calendarUtilities.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
// ignore_for_file: file_names

class EditProfile extends StatefulWidget {
  Function updateProfile;
  EditProfile({this.updateProfile});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  PickedFile _image;
  _imgFromCamera() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  DateTime picked;
  String username = "";
  String name = "";
  String surname = "";
  String bio = "";
  String phone = "";
  String gender = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, LanguageProvider>(
        builder: (context, customProvider, languageProvider, _) {
      return Scaffold(
        appBar: basicAppBar(
            context, languageProvider.text.profileText.modify_profile),
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext bc) {
                            return SafeArea(
                              child: Container(
                                child: new Wrap(
                                  children: <Widget>[
                                    new ListTile(
                                        leading: new Icon(Icons.photo_library),
                                        title: new Text('Photo Library'),
                                        onTap: () {
                                          _imgFromGallery();
                                          Navigator.of(context).pop();
                                        }),
                                    new ListTile(
                                      leading: new Icon(Icons.photo_camera),
                                      title: new Text('Camera'),
                                      onTap: () {
                                        _imgFromCamera();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Container(
                          height: size.width / 3,
                          width: size.width / 3,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(size.width / 3),
                              image: DecorationImage(
                                  image: _image != null
                                      ? FileImage(File(_image.path))
                                      : NetworkImage(customProvider.user.image),
                                  fit: BoxFit.cover))),
                    )),
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      languageProvider.text.profileText.image_text,
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                                child: Container(
                                    child: Text("Username",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: Color(0xFF999999),
                                                fontSize: 14)))),
                            customProvider.loading
                                ? Container(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.white,
                                    ))
                                : customProvider.usernameTaken
                                    ? Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            languageProvider
                                                .text.profileText.username_used,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                    color: Colors.red,
                                                    fontSize: 11)))
                                    : Container(),
                          ]),
                          Container(
                            height: 40,
                            child: TextFormField(
                              onChanged: (String text) {
                                username = text;
                                customProvider.checkUsername(text);
                              },
                              style: Theme.of(context).textTheme.bodyText1,
                              cursorColor: Theme.of(context).primaryColorLight,
                              initialValue: customProvider.user.username,
                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.error,
                                    color: customProvider.usernameTaken
                                        ? Colors.red
                                        : Colors.transparent),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                  languageProvider.text.profileText.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                            height: 40,
                            child: TextFormField(
                              onChanged: (String text) {
                                name = text;
                              },
                              style: Theme.of(context).textTheme.bodyText1,
                              cursorColor: Theme.of(context).primaryColorLight,
                              initialValue: customProvider.user.name,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                  languageProvider.text.profileText.surname,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                            height: 40,
                            child: TextFormField(
                              onChanged: (String text) {
                                surname = text;
                              },
                              style: Theme.of(context).textTheme.bodyText1,
                              cursorColor: Theme.of(context).primaryColorLight,
                              initialValue: customProvider.user.surname,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                  languageProvider.text.profileText.biography,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                            height: 40,
                            child: TextFormField(
                              onChanged: (String text) {
                                bio = text;
                              },
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText1,
                              cursorColor: Theme.of(context).primaryColorLight,
                              initialValue: customProvider.user.motto,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ),
                          Container(height: 60),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                  languageProvider
                                      .text.profileText.additional_information,
                                  style:
                                      Theme.of(context).textTheme.bodyText1)),
                          Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                  languageProvider.text.profileText
                                      .additional_information_text,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 12,
                                          color: Colors.grey[700]))),
                          Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Text(
                                  languageProvider.text.profileText.gender,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 10),
                              child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20),
                                                topLeft: Radius.circular(20))),
                                        backgroundColor: Color(0xFF222222),
                                        builder: (context) => Container(
                                            margin: EdgeInsets.only(top: 20),
                                            height: size.height / 5,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      gender = "m";
                                                      customProvider
                                                          .updateProfile(
                                                              customProvider
                                                                  .user
                                                                  .birthday,
                                                              name,
                                                              surname,
                                                              bio,
                                                              username,
                                                              phone,
                                                              gender);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            languageProvider
                                                                .text
                                                                .profileText
                                                                .male,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))),
                                                InkWell(
                                                    onTap: () {
                                                      gender = "f";
                                                      customProvider
                                                          .updateProfile(
                                                              customProvider
                                                                  .user
                                                                  .birthday,
                                                              name,
                                                              surname,
                                                              bio,
                                                              username,
                                                              phone,
                                                              gender);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            languageProvider
                                                                .text
                                                                .profileText
                                                                .female,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)))),
                                              ],
                                            )));
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor))),
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        customProvider.user.gender == 'm'
                                            ? languageProvider
                                                .text.profileText.male
                                            : customProvider.user.gender == 'f'
                                                ? languageProvider
                                                    .text.profileText.female
                                                : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(),
                                      )))),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                  languageProvider.text.profileText.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                            height: 40,
                            child: TextFormField(
                              onChanged: (String text) {
                                phone = text;
                              },
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText1,
                              cursorColor: Theme.of(context).primaryColorLight,
                              initialValue: customProvider.user.phone,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                  languageProvider.text.profileText.birthday,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          color: Color(0xFFaaaaaa),
                                          fontSize: 14))),
                          Container(
                              height: 40,
                              margin: EdgeInsets.only(bottom: 90),
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  onPressed: () async {
                                    if (Platform.isAndroid) {
                                      // Android-specific code
                                      picked = await showDatePicker(
                                        locale: Locale('it'),
                                        initialEntryMode:
                                            DatePickerEntryMode.input,
                                        context: context,
                                        initialDate:
                                            customProvider.user.birthday ??
                                                DateTime.now(),
                                        firstDate: DateTime(1920),
                                        lastDate: DateTime.now(),
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              secondaryHeaderColor:
                                                  Color(0xFFf9b701),
                                              buttonTheme: ButtonThemeData(
                                                  highlightColor: Colors.green,
                                                  buttonColor: Colors.green,
                                                  colorScheme: Theme.of(context)
                                                      .colorScheme
                                                      .copyWith(
                                                          background:
                                                              Colors.white,
                                                          primary: Colors.green,
                                                          primaryVariant:
                                                              Colors.green,
                                                          brightness:
                                                              Brightness.dark,
                                                          onBackground:
                                                              Colors.green)),
                                              colorScheme: ColorScheme.dark(
                                                onSecondary: Theme.of(context)
                                                    .accentColor,
                                                secondaryVariant:
                                                    Color(0xFFf9b701),
                                                secondary: Color(0xFFf9b701),
                                                primary: Theme.of(context)
                                                    .primaryColorLight,
                                                onPrimary: Colors.white,

                                                // surface:
                                                //     Theme.of(context).primaryColorLight,
                                                onSurface: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                              dialogTheme: DialogTheme(
                                                  contentTextStyle: Theme.of(
                                                          context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.white)),
                                              dialogBackgroundColor:
                                                  Theme.of(context)
                                                      .primaryColorDark,
                                            ),
                                            child: child,
                                          );
                                        },
                                      );
                                    } else if (Platform.isIOS) {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext bc) {
                                            return CupertinoDatePicker(
                                              onDateTimeChanged: (date) {
                                                picked = date;
                                              },
                                              initialDateTime: DateTime.now(),
                                            );
                                          });
                                    }
                                    if (picked != null) {
                                      customProvider.user.birthday = picked;
                                    }
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Theme.of(context)
                                                      .primaryColor))),
                                      height: 40,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        customProvider.user.birthday.day
                                                .toString() +
                                            ' ' +
                                            getMonth(customProvider
                                                    .user.birthday.month -
                                                1) +
                                            ' ' +
                                            customProvider.user.birthday.year
                                                .toString(),
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(),
                                      )))),
                        ]))
              ],
            ),
            Positioned(
                left: 20,
                right: 20,
                bottom: 10,
                child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        primary: Colors.transparent.withOpacity(0)),
                    onPressed: () {
                      if (_image != null) {
                        customProvider.uploadImage(File(_image.path));
                      }
                      customProvider.updateProfile(
                          picked, name, surname, bio, username, phone, gender);

                      Navigator.of(context).pop();
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFf9b701),
                            borderRadius: BorderRadius.circular(50)),
                        margin: EdgeInsets.only(
                          left: 0,
                          right: 0,
                        ),
                        width: size.width,
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              languageProvider.text.profileText.update,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            )))))
          ],
        ),
      );
    });
  }
}
