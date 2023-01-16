import 'package:eventi_in_zona/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class CardWidgetReview extends StatefulWidget {
  Review review;
  CardWidgetReview({super.key, required this.review});

  @override
  State<CardWidgetReview> createState() => _CardWidgetReviewState();
}

class _CardWidgetReviewState extends State<CardWidgetReview> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 20, right: 0, top: 50),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
        ),
        Flexible(
            child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      widget.review.createdAt.day.toString() +
                          " " +
                          months[widget.review.createdAt.month] +
                          " " +
                          widget.review.createdAt.year.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.grey[500]),
                    )),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          widget.review.user.username,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: RatingBar.builder(
                        initialRating: widget.review.rate.toDouble(),
                        minRating: 1,
                        unratedColor: Colors.white,
                        itemCount: 5,
                        itemSize: 15.0,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          widget.review.description,
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.grey[800]),
                        )),
                  ],
                )))
      ],
    );
  }
}
