import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:uuid/uuid.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}
// ignore_for_file: file_names

class _SearchState extends State<Search> {
  double lat;
  double lon;
  GoogleMapsPlaces _places;
  TextEditingController genreController = TextEditingController();
  TextEditingController _controller = new TextEditingController();

  List<String> searchGenresResult = [];
  List<String> searchGenres = [
    "Pop",
    "Rock",
    "House",
    "Rap",
    "Elettronica",
    "Blues",
    "Dub",
    "Raggae"
  ];
  FocusNode whereNode;
  bool searchingGenres = false;
  bool searchWhere = false;

  @override
  void initState() {
    super.initState();
    whereNode = FocusNode();
    _controller.addListener(() {
      _onChanged();
    });
  }

  String _sessionToken;
  List<Prediction> _placeList = [];
  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = Uuid().v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAwWTijFIGQvx-BnhSVpI_yX4ANZUc2BJM";

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken&language=IT&location=42.76999%2C14.44696&radius=1200';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      List<Prediction> _placeList_cp = [];
      for (var pred in jsonDecode(response.body)['predictions']) {
        _placeList_cp.add(Prediction.fromJson(pred));
      }
      setState(() {
        _placeList = _placeList_cp;
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  Future displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId, language: 'it');

      lat = detail.result.geometry.location.lat;
      lon = detail.result.geometry.location.lng;

      setState(() {
        _controller.text = detail.result.formattedAddress;
      });
    }
  }

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
                              autofocus: true,
                              keyboardType: TextInputType.name,
                              autocorrect: false,
                              controller: genreController,
                              style: TextStyle(color: Colors.white),
                              onChanged: (String text) {
                                if (text != "") {
                                  searchGenresResult = [];
                                  for (String word in searchGenres) {
                                    if (word
                                        .toLowerCase()
                                        .contains(text.toLowerCase())) {
                                      searchGenresResult.add(word);
                                    }
                                  }
                                  setState(() {
                                    searchingGenres = true;
                                  });
                                } else {
                                  setState(() {
                                    searchingGenres = false;
                                  });
                                }
                              },
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
                          padding: EdgeInsets.only(bottom: 5),
                          child: TextFormField(
                              controller: _controller,
                              focusNode: whereNode,
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
                      // Container(
                      //     padding: EdgeInsets.only(bottom: 10),
                      //     child: TextFormField(
                      //         keyboardType: TextInputType.emailAddress,
                      //         autocorrect: false,
                      //         style: TextStyle(color: Colors.white),
                      //         decoration: InputDecoration(
                      //             contentPadding: EdgeInsets.only(left: 20.0),
                      //             labelStyle: TextStyle(color: Colors.white),
                      //             filled: true,
                      //             fillColor: Color(0xFF333333),
                      //             enabledBorder: OutlineInputBorder(
                      //               borderRadius: BorderRadius.zero,
                      //               borderSide: BorderSide(
                      //                   color: Color(0xFF333333), width: 2),
                      //             ),
                      //             focusedBorder: OutlineInputBorder(
                      //                 borderSide: BorderSide(
                      //                     color: Colors.transparent,
                      //                     width: 2.0),
                      //                 borderRadius: BorderRadius.zero),
                      //             border: OutlineInputBorder(
                      //                 borderRadius: BorderRadius.zero),
                      //             focusColor: Colors.transparent,
                      //             hoverColor: Color(0xFF333333),
                      //             hintText: 'Quando',
                      //             hintStyle: TextStyle(color: Colors.white)))),
                    ],
                  ))
                ],
              ),
            ),
            searchingGenres
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchGenresResult.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              genreController.text = searchGenresResult[index];
                              searchWhere = true;
                              searchingGenres = false;
                            });
                            whereNode.requestFocus();
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                      margin: EdgeInsets.all(6),
                                      padding: EdgeInsets.all(6),
                                      decoration: (BoxDecoration(
                                          color: Color(0xFFF9b701),
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                      child: Icon(Icons.search,
                                          color: Color(0xFF333333))),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(searchGenresResult[index],
                                          style: TextStyle(
                                            color: Color(0xFFF9b701),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          )))
                                ],
                              )));
                    },
                  )
                : searchWhere
                    ? Column(children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SearchResults()))
                            },
                            child: Container(
                                margin: EdgeInsets.all(18),
                                child: Row(children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 30),
                                      child: Icon(Icons.gps_fixed,
                                          color: Color(0xFFf9b701))),
                                  Container(
                                      child: Text("Posizione attuale",
                                          style:
                                              TextStyle(color: Colors.white)))
                                ]))),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _placeList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                            
                                setState(() {
                                  whereNode.unfocus();
                                  _controller.text =
                                      _placeList[index].description;
                                });
                                displayPrediction(_placeList[index]);
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SearchResults()))
                            
                              },
                              leading: Icon(Icons.pin_drop,
                                  color: Color(0xFFF9b701)),
                              title: Text(_placeList[index].description,
                                  style: TextStyle(color: Colors.grey[300])),
                            );
                          },
                        )
                      ])
                    : Column(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  genreController.text = "Tutti gli eventi";
                                  searchWhere = true;
                                  searchingGenres = false;
                                });
                                whereNode.requestFocus();
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
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                          child: Icon(Icons.search,
                                              color: Color(0xFF121212))),
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
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold),
                              )),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  genreController.text = "House";
                                  searchWhere = true;
                                  searchingGenres = false;
                                });
                                whereNode.requestFocus();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(6),
                                          decoration: (BoxDecoration(
                                              color: Color(0xFFF9b701),
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                          child: Icon(Icons.search,
                                              color: Color(0xFF333333))),
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
                                setState(() {
                                  genreController.text = "Pop";
                                  searchWhere = true;
                                  searchingGenres = false;
                                });
                                whereNode.requestFocus();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(6),
                                          decoration: (BoxDecoration(
                                              color: Color(0xFFF9b701),
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                          child: Icon(Icons.search,
                                              color: Color(0xFF333333))),
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
                                setState(() {
                                  genreController.text = "Rock";
                                  searchWhere = true;
                                  searchingGenres = false;
                                });
                                whereNode.requestFocus();
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(6),
                                          padding: EdgeInsets.all(6),
                                          decoration: (BoxDecoration(
                                              color: Color(0xFFF9b701),
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                          child: Icon(Icons.search,
                                              color: Color(0xFF333333))),
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
                      )
          ],
        )));
  }
}
