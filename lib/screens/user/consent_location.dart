import 'package:eventi_in_zona/repositories/location_repo.dart';
import 'package:eventi_in_zona/screens/user/BottomTabContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:location/location.dart';

class ConsentLocation extends StatefulWidget {
  ConsentLocation({Key? key, this.user_image, this.user_name})
      : super(key: key);
  String? user_image;
  String? user_name;
  @override
  State<ConsentLocation> createState() => _ConsentLocationState();
}

class _ConsentLocationState extends State<ConsentLocation> {
  bool loading = false;
  void getPosition() async {
    setState(() {
      loading = true;
    });
    dynamic pos = await getNewCurrentLocation(context);

    print(pos);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => BottomTabContainer(initialIndex: 0)));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: loading
          ? Container(
              height: size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Container(
                        width: size.width,
                        padding: EdgeInsets.all(20),
                        child: Text("Caricamento posizione in corso...",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins()))
                  ]))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Container()),
                Container(
                    margin: EdgeInsets.only(bottom: 40),
                    width: size.width,
                    child: Icon(Icons.place, size: 120, color: Colors.orange)),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Abilita il GPS",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "I servizi di localizzazione ti aiuteranno a scoprire le attività nei tuoi dintorni",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    )),
                Expanded(child: Container()),
                Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 0),
                    child: InkWell(
                        onTap: () {
                          getPosition();
                        },
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.orange,
                            ),
                            child: Container(
                              child: Text("Accetta",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white))),
                            )))),
                Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        top: 10, left: 20, right: 20, bottom: 20),
                    child: InkWell(
                      child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            child: Text("Non adesso",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey[500]))),
                          )),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                BottomTabContainer(initialIndex: 0)));
                      },
                    ))
              ],
            ),
    );
  }
}
