// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';
import 'dart:io';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Engine/Utility.dart/DefaultLanguage.dart';
import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/ShowcaseNotificationsModel.dart';
import 'package:project_app/services/NotificationServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Translator text;
  bool isErrorLanguageVisible = false;

  void getLanguage() async {
    final String defaultLocale = Platform.localeName;
    final prefs = await SharedPreferences.getInstance();
    try {
      String response =
          await Request.get('json-language/' + defaultLocale.split("_")[0]);

      prefs.setString('languagepack', response);

      text = Translator.fromJson(jsonDecode(response));
    } catch (e) {
      isErrorLanguageVisible = true;

      await Future.delayed(const Duration(seconds: 2), () {
        print('Errore, prova a controllare la tua connessione');

        prefs.setString('languagepack', DefaultLanguage.en);
        text = Translator.fromJson(jsonDecode(DefaultLanguage.en));
      });
    }
    notifyListeners();
  }
}
