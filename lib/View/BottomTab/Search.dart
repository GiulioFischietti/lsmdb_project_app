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
        backgroundColor: Color(0xFF121212),
        body:
            //   Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
            // return
            Container(
                child: ListView(
          shrinkWrap: true,
          children: [
            // Container(
            //     margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
            //     child: Text("Cerca",
            //         style: TextStyle(
            //             color: Color(0xFFf9b701),
            //             fontWeight: FontWeight.w700,
            //             fontSize: 34))),
            Container(
              color: Color(0xFF333333),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        color: Color(0xFF333333),
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 20.0),
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0xFF333333),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide(
                                      color: Color(0xFF333333), width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF333333), width: 2.0),
                                  borderRadius: BorderRadius.zero,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero),
                                focusColor: Colors.transparent,
                                hoverColor: Color(0xFF333333),
                                hintStyle: TextStyle(color: Colors.white),
                                hintText:
                                    'Cosa (Genere musicale, es: House, Techno...)',
                              ))),
                      Container(
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  labelStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Color(0xFF333333),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                        color: Color(0xFF333333), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.zero),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  focusColor: Colors.transparent,
                                  hoverColor: Color(0xFF333333),
                                  hintText: 'Dove',
                                  hintStyle: TextStyle(color: Colors.white)))),
                      Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  labelStyle: TextStyle(color: Colors.white),
                                  filled: true,
                                  fillColor: Color(0xFF333333),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                        color: Color(0xFF333333), width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 2.0),
                                      borderRadius: BorderRadius.zero),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero),
                                  focusColor: Colors.transparent,
                                  hoverColor: Color(0xFF333333),
                                  hintText: 'Quando',
                                  hintStyle: TextStyle(color: Colors.white)))),
                    ],
                  ))
                ],
              ),
            ),
            InkWell(
                onTap: () {
                  print("hello");
                },
                child: Container(
                    padding: EdgeInsets.all(20),
                    color: Color(0xFF121212),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(6),
                            decoration: (BoxDecoration(
                                color: Color(0xFFF9b701),
                                borderRadius: BorderRadius.circular(50))),
                            child:
                                Icon(Icons.search, color: Color(0xFF121212))),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Tutti gli eventi",
                                style: TextStyle(
                                  color: Color(0xFFF9b701),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )))
                      ],
                    ))),
            Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Ricerche suggerite",
                  style: TextStyle(
                      color: Colors.grey[200], fontWeight: FontWeight.bold),
                )),
            InkWell(
                onTap: () {
                  print("hello");
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(6),
                            decoration: (BoxDecoration(
                                color: Color(0xFFF9b701),
                                borderRadius: BorderRadius.circular(50))),
                            child:
                                Icon(Icons.search, color: Color(0xFF333333))),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("House",
                                style: TextStyle(
                                  color: Color(0xFFF9b701),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )))
                      ],
                    ))),
            InkWell(
                onTap: () {
                  print("hello");
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(6),
                            decoration: (BoxDecoration(
                                color: Color(0xFFF9b701),
                                borderRadius: BorderRadius.circular(50))),
                            child:
                                Icon(Icons.search, color: Color(0xFF333333))),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Pop",
                                style: TextStyle(
                                  color: Color(0xFFF9b701),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )))
                      ],
                    ))),
            InkWell(
                onTap: () {
                  print("hello");
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.all(6),
                            padding: EdgeInsets.all(6),
                            decoration: (BoxDecoration(
                                color: Color(0xFFF9b701),
                                borderRadius: BorderRadius.circular(50))),
                            child:
                                Icon(Icons.search, color: Color(0xFF333333))),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text("Rock",
                                style: TextStyle(
                                  color: Color(0xFFF9b701),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )))
                      ],
                    ))),
          ],
        )));
  }
}
