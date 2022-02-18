import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/ReviewModel.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseOrganizersModel.dart';
import 'package:project_app/Model/ShowcaseReviewsModel.dart';
import 'package:project_app/View/Items/ClubV.dart';
import 'package:project_app/View/Items/OrganizerV.dart';
import 'package:flutter/material.dart';

import 'ReviewV.dart';

class ShowcaseReviews extends StatefulWidget {
  ShowcaseReviewsModel data;
  VoidCallback getReviews;
  Translator languagePack;
  ShowcaseReviews({this.data, this.languagePack, @required this.getReviews});
  @override
  _ShowcaseReviewstate createState() => _ShowcaseReviewstate();
}

class _ShowcaseReviewstate extends State<ShowcaseReviews> {
  void _removeReview(int index) {
    setState(() {
      widget.data.reviews.removeAt(index);
    });
  }

  void _editReview(int index, String description, double rating) {
    setState(() {
      widget.data.reviews[index].description = description;
      widget.data.reviews[index].rating = rating;
    });
  }

  void _addReview() {}

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.data.title != ""
          ? Container(
              margin: EdgeInsets.only(bottom: 0, left: 20, top: 10),
              child: Text(widget.data.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500)))
          : Container(),
      Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.data.reviews.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ReviewV(
                    widget.data.reviews[index],
                    getReviews: widget.getReviews,
                    remove: () {
                      _removeReview(index);
                    },
                    post: widget.languagePack.reviewText.post,
                    placeholder:
                        widget.languagePack.reviewText.textarea_placeholder,
                    new_review: widget.languagePack.reviewText.modify_review,
                  ));
            },
          ))
    ]);
  }
}
