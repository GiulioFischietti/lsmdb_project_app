import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/NotificationProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'View/Access/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider())
        ],
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('it', ''), // it
            const Locale('en', ''), // English
          ],
          debugShowCheckedModeBanner: false,
          title: 'Needfy',
          themeMode: ThemeMode.light,
          theme: ThemeData(
              primaryColor: Color(0xFF353535),
              primaryColorDark: Color(0xFF141414),
              primaryColorLight: Color(0xFFcccccc),
              accentColor: Color(0xFFf9b701),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      color: Color(0xFFcccccc),
                      fontSize: 16,
                      fontWeight: FontWeight.w400))),
          home: AnnotatedRegion<SystemUiOverlayStyle>(
              child: Login(),
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              )),
        ));
  }
}
