import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
// ignore_for_file: file_names

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF222222),
        body:
            Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
          return Container(
            child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(languageProvider.text.needfy.search,
                        style: TextStyle(
                            color: Color(0xFFf9b701),
                            fontWeight: FontWeight.w700,
                            fontSize: 34))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
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
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey[400]),
                          suffixIcon:
                              Icon(Icons.cancel, color: Colors.grey[400]),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2.0),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusColor: Colors.transparent,
                          hoverColor: Colors.grey[400],
                          hintText: 'Cerca Eventi, Club, Artisti...',
                        ))),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 150,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                      ],
                    )),
                Container(
                    height: 150,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 150,
                            color: Colors.grey[400]),
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 150,
                            width: 100,
                            color: Colors.grey[400]),
                      ],
                    )),
              ],
            ),
          );
        }));
  }
}
