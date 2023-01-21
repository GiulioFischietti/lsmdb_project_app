import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/providers/entity_provider.dart';
import 'package:eventi_in_zona/screens/user/edit_review.dart';
import 'package:eventi_in_zona/widgets/user/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class CardWidgetReview extends StatefulWidget {
  Review review;
  bool isMine;
  CardWidgetReview({super.key, required this.review, required this.isMine});

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
          margin: EdgeInsets.only(left: 20, right: 0, top: 30),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
        ),
        Flexible(
            child: Container(
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: Text(
                          widget.review.createdAt.day.toString() +
                              " " +
                              months[widget.review.createdAt.month] +
                              " " +
                              widget.review.createdAt.year.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.grey[500]),
                        ))),
                        widget.isMine
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => EditReview(
                                          entityId: widget.review.entity.id,
                                          type: widget.review.entity.type,
                                          name: widget.review.entity.name,
                                          my_review: widget.review)));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(top: 5, right: 5),
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange),
                                    )))
                            : Container(),
                        widget.isMine
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Delete Review",
                                            style: GoogleFonts.poppins(),
                                          ),
                                          content: Text(
                                              "Do you really want to delete your review?",
                                              style: GoogleFonts.poppins()),
                                          actions: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('Yes'),
                                              onPressed: () {
                                                final entityProvider =
                                                    Provider.of<EntityProvider>(
                                                        context,
                                                        listen: false);
                                                entityProvider
                                                    .deleteReviewOrganizer(
                                                        widget.review.entity.id,
                                                        widget.review.id,
                                                        widget.review.user.id);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: const Text('No'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5.0)), //this right here
                                        );
                                      });
                                },
                                child: Container(
                                    padding: EdgeInsets.only(top: 5, left: 5),
                                    child: Text(
                                      "Delete",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )))
                            : Container(),
                      ],
                    ),
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
