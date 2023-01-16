import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  late String name;
  late Function navigate;
  late String image;
  late String description;
  late String type;
  late IconData icon;
  late Color categoryColor;

  CategoryWidget(
      {required this.name,
      required this.icon,
      required this.navigate,
      required this.image,
      required this.description,
      required this.type,
      required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Container(
        width: 110,
        // margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            this.navigate();
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => ActivitiesByCategory(
            //               idcategory: this.type,
            //               lat: this.myLocation.latitude,
            //               lon: this.myLocation.longitude,
            //               name: this.name,
            //             )));
          },
          child: Column(
            children: [
              Container(
                  height: 80,
                  width: 80,
                  // child: Hero(
                  //     tag: this.type,
                  child: Container(
                    child: Icon(this.icon, color: Colors.grey[800]),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(60),
                      color: this.categoryColor,
                    ),
                  )),
              Flexible(
                  child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Container(
                  // margin: EdgeInsets.all(10),
                  child: Text(
                    this.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 11,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ))
            ],
          ),
        )));
  }
}
