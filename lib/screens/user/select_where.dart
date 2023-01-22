import 'dart:convert';
import 'package:eventi_in_zona/models/Prediction.dart';
import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/repositories/location_repo.dart';
import 'package:eventi_in_zona/screens/user/select_radius.dart';
import 'package:eventi_in_zona/screens/user/select_when.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geocoding;

class SelectWhere extends StatefulWidget {
  Function? function;
  SelectWhere({Key? key, this.function}) : super(key: key);

  @override
  State<SelectWhere> createState() => _SelectWhereState();
}

class _SelectWhereState extends State<SelectWhere> {
  String? _sessionToken;
  dynamic loc;
  List<Prediction> _placeList = [];
  TextEditingController _controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = Uuid().v4();
      });
    }
    getSuggestion(_controller.text);
  }

  Future displayPrediction(Prediction p) async {
    Response response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?place_id=${p.placeId}&key=AIzaSyAwWTijFIGQvx-BnhSVpI_yX4ANZUc2BJM"));
    var detail = jsonDecode(response.body);

    loc = {
      "lat": detail['results'][0]['geometry']['location']['lat'].toString(),
      "lon": detail['results'][0]['geometry']['location']['lng'].toString(),
      "address": p.description
    };

    return loc;
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
        print(pred);
        _placeList_cp.add(Prediction.fromJson(pred));
      }
      setState(() {
        _placeList = _placeList_cp;
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
              BoxShadow(color: Colors.grey[300]!.withOpacity(0.3))
            ]),
            padding: EdgeInsets.only(left: 10, bottom: 10, right: 10, top: 40),
            child: TextField(
              autofocus: true,
              controller: _controller,
              cursorHeight: 18,
              style: GoogleFonts.poppins(fontSize: 18),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: 15),
                labelText: "Inserisci luogo...",
                hintText: "Inserisci luogo...",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                labelStyle: GoogleFonts.poppins(fontSize: 18),
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                icon: InkWell(
                  child: Icon(Icons.arrow_back, color: Colors.black),
                  onTap: () {
                    Navigator.of(context).pop(context);
                  },
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _controller.text = "";
                    });
                  },
                  icon: Icon(Icons.cancel, color: Colors.grey),
                ),
              ),
            )),
        InkWell(
            onTap: () async {
              final eventProvider =
                  Provider.of<EventProvider>(context, listen: false);

              eventProvider.locationSearch = await getStoredLocation(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (ctx) => SelectRadius()));
            },
            child: Container(
                margin: EdgeInsets.all(15),
                child: Row(children: [
                  Container(
                      child: Icon(Icons.my_location, color: Colors.grey[600])),
                  Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text("Posizione Attuale",
                          style: GoogleFonts.poppins(fontSize: 14)))
                ]))),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _placeList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                var loc = await displayPrediction(_placeList[index]);
                final eventProvider =
                    Provider.of<EventProvider>(context, listen: false);
                eventProvider.locationSearch = loc;
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => SelectRadius()));
              },
              leading: Icon(
                Icons.pin_drop,
              ),
              title: Text(_placeList[index].description,
                  style: GoogleFonts.poppins(fontSize: 14)),
            );
          },
        ),
      ]),
    );
  }
}
