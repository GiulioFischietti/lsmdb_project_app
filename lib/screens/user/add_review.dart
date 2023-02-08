import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/models/user_minimal.dart';
import 'package:eventi_in_zona/providers/entity_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';

class AddReview extends StatefulWidget {
  String name;
  String type;
  Review my_review;
  ObjectId entityId;

  AddReview(
      {Key? key,
      required this.entityId,
      required this.type,
      required this.name,
      required this.my_review})
      : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

String initialText = "";

class _AddReviewState extends State<AddReview> {
  Review review = Review({});
  @override
  void initState() {
    updateText();
    super.initState();
  }

  updateText() {
    setState(() {
      reviewController.text = widget.my_review.description;
    });
  }

  TextEditingController reviewController =
      TextEditingController(text: initialText);

  double rating = 5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Container(
            margin: EdgeInsets.all(20),
            child: Text(
              widget.name,
              style: GoogleFonts.poppins(fontSize: 18),
            )),
        Container(
          margin: EdgeInsets.all(20),
          child: RatingBar.builder(
              initialRating: widget.my_review.rate.toDouble(),
              minRating: 1,
              unratedColor: Colors.white,
              itemCount: 5,
              itemSize: 48.0,
              onRatingUpdate: (double rate) {
                review.rate = rate.toInt();
                setState(() {
                  rating = rate;
                });
              },
              itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.orange,
                  )),
        ),
        Container(
            margin: EdgeInsets.all(20),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              style: GoogleFonts.poppins(),
              onChanged: (text) {
                review.description = text;
              },
              controller: reviewController,
              // initialValue: widget.my_review.comment,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey[600]!.withOpacity(0.2))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey[600]!.withOpacity(0.1))),
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  hintText: "Add review description"),
            )),
        Container(
            margin: EdgeInsets.only(top: 80, left: 80, right: 80),
            child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 2.5),
                elevation: 0,
                minWidth: 0,
                child: Container(
                  height: 40,
                  child: Center(
                    child: Text(
                      "Confirm",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.orange,
                onPressed: () async {
                  review.createdAt = DateTime.now();
                  review.updatedAt = DateTime.now();

                  final entityProvider =
                      Provider.of<EntityProvider>(context, listen: false);
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  // userProvider.addReviewedEntity(widget.entityId);
                  review.user = UserMinimal(userProvider.user.toJson());

                  switch (widget.type) {
                    case "organizer":
                      review.entity =
                          EntityMinimal(entityProvider.organizer.toJson());
                      entityProvider.addReviewOrganizer(review);
                      Navigator.of(context).pop();
                      break;
                    case "club":
                      review.entity =
                          EntityMinimal(entityProvider.club.toJson());
                      entityProvider.addReviewClub(review);
                      Navigator.of(context).pop();
                      break;
                    case "artist":
                      review.entity =
                          EntityMinimal(entityProvider.artist.toJson());
                      entityProvider.addReviewArtist(review);
                      Navigator.of(context).pop();
                      break;
                    default:
                      review.entity =
                          EntityMinimal(entityProvider.organizer.toJson());
                      entityProvider.addReviewOrganizer(review);
                      Navigator.of(context).pop();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                )))
      ],
    ));
  }
}
