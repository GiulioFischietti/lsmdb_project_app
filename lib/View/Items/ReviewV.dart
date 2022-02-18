import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ReviewModel.dart';
import 'package:project_app/View/Entities/Artist.dart';
import 'package:project_app/View/Entities/Club.dart';
import 'package:project_app/View/Entities/Organizer.dart';
import 'package:project_app/View/Entities/Profile.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Entities/calendarUtilities.dart';
// ignore_for_file: file_names

class ReviewV extends StatefulWidget {
  ReviewModel reviewV;
  ReviewV(this.reviewV,
      {Key key,
      this.remove,
      this.post,
      this.placeholder,
      this.new_review,
      this.getReviews});
  final VoidCallback remove;
  final VoidCallback getReviews;
  String post;
  String placeholder;
  String new_review;
  @override
  _ReviewVState createState() => _ReviewVState();
}

class _ReviewVState extends State<ReviewV> {
  double rating = 0;
  bool showResponse = false;
  TextEditingController reviewDescription = new TextEditingController(text: "");
  @override
  void initState() {
    // final userMdl = Provider.of<UserProvider>(context, listen: false);
    // userMdl.getUserData(context);
    reviewDescription.text = widget.reviewV.description;
    print(widget.reviewV.username);
  }

  Future<void> _removeReview() async {
    widget.remove();
    final response =
        await Request.delete('removereview/' + widget.reviewV.id.toString());
    widget.getReviews();
  }

  Future<void> _modifyReview() async {
    print('text');
    final response = await Request.post(
        'modifyreview/' + widget.reviewV.id.toString(),
        {"rating": rating.toString(), "description": reviewDescription.text});
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          InkWell(
              onTap: () {
                if (widget.reviewV.type.toLowerCase() == 'club') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Club(
                              name: "",
                              slug: int.parse(widget.reviewV.slug),
                              image: widget.reviewV.image)));
                } else if (widget.reviewV.type.toLowerCase() == 'organizer') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Organizer(
                              slug: int.parse(widget.reviewV.slug),
                              image: widget.reviewV.image)));
                } else if (widget.reviewV.type.toLowerCase() == 'artist') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Artist(
                              name: "",
                              slug: int.parse(widget.reviewV.slug),
                              image: widget.reviewV.image)));
                } else if (widget.reviewV.type.toLowerCase() == 'profile') {
                  if (provider.user.username == widget.reviewV.username) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User(
                                slug: widget.reviewV.username,
                                image: widget.reviewV.image)));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Profile(
                            slug: widget.reviewV.slug,
                            image: widget.reviewV.image)));
                  }
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.reviewV.image))),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15, top: 0),
                          child: Text(
                              widget.reviewV?.name != ""
                                  ? widget.reviewV?.name
                                  : widget.reviewV?.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFcccccc)))),
                      Container(
                          margin: EdgeInsets.only(left: 12),
                          alignment: Alignment.centerLeft,
                          child: RatingBar.builder(
                            initialRating: widget.reviewV?.rating ?? 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 24,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )),
                      widget.reviewV?.description != ""
                          ? Container(
                              alignment: Alignment.topLeft,
                              // color: Colors.white,
                              margin:
                                  EdgeInsets.only(left: 15, top: 2, bottom: 1),
                              child: Text(widget.reviewV?.description,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFFcccccc))))
                          : Container(),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15, top: 2, bottom: 5),
                          child: Text(
                              widget.reviewV?.created_at?.day.toString() +
                                      ' ' +
                                      getMonth(widget.reviewV.created_at.month -
                                          1) ??
                                  "",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF999999)))),
                    ],
                  )),
                  (provider.user.username == widget.reviewV.username)
                      ? TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                backgroundColor: Color(0xFF222222),
                                builder: (context) => Container(
                                    height: size.height / 4,
                                    child: ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _removeReview();
                                              },
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: EdgeInsets.all(20),
                                                  child: Text(
                                                    'Elimina',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                showModalBottomSheet(
                                                    isScrollControlled: false,
                                                    context: context,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft:
                                                                    Radius.circular(
                                                                        20))),
                                                    backgroundColor:
                                                        Color(0xFF222222),
                                                    builder:
                                                        (context) =>
                                                            StatefulBuilder(builder:
                                                                (BuildContext
                                                                        context,
                                                                    StateSetter
                                                                        setState /*You can rename this!*/) {
                                                              return Container(
                                                                  padding: EdgeInsets.only(
                                                                      bottom: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets
                                                                          .bottom),
                                                                  child: ListView(
                                                                      shrinkWrap:
                                                                          true,
                                                                      physics:
                                                                          NeverScrollableScrollPhysics(),
                                                                      children: [
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.all(20),
                                                                            alignment: Alignment.center,
                                                                            child: Text(widget.new_review, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFFCCCCCC)))),
                                                                        Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 20, bottom: 0),
                                                                            alignment: Alignment.topCenter,
                                                                            child: RatingBar.builder(
                                                                              unratedColor: Color(0xFF999999),
                                                                              initialRating: widget.reviewV.rating,
                                                                              minRating: 1,
                                                                              direction: Axis.horizontal,
                                                                              allowHalfRating: false,
                                                                              itemCount: 5,
                                                                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                                              itemBuilder: (context, _) => Icon(
                                                                                Icons.star,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              onRatingUpdate: (double r) {
                                                                                setState(() {
                                                                                  rating = r;
                                                                                });
                                                                                print('aaaaa');
                                                                              },
                                                                            )),
                                                                        Container(
                                                                          // height: 50,
                                                                          margin:
                                                                              EdgeInsets.only(
                                                                            right:
                                                                                40,
                                                                            left:
                                                                                40,
                                                                            top:
                                                                                10,
                                                                          ),
                                                                          child:
                                                                              TextFormField(
                                                                            textInputAction:
                                                                                TextInputAction.go,
                                                                            controller:
                                                                                reviewDescription,
                                                                            autofocus:
                                                                                true,
                                                                            maxLines:
                                                                                3,
                                                                            textCapitalization:
                                                                                TextCapitalization.sentences,
                                                                            style:
                                                                                TextStyle(color: Color(0xFFcccccc), fontSize: 16),
                                                                            cursorHeight:
                                                                                20,
                                                                            decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintStyle: TextStyle(fontSize: 16, color: Color(0xFF999999)),
                                                                                hintText: widget.placeholder),
                                                                            cursorColor:
                                                                                Color(0xFFcccccc),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                            margin: EdgeInsets.only(
                                                                                left: 40,
                                                                                right: 40,
                                                                                bottom: 20),
                                                                            child: TextButton(
                                                                              onPressed: () {
                                                                                // _addReview();
                                                                                _modifyReview();
                                                                                Navigator.pop(context);
                                                                                setState(() {
                                                                                  widget.reviewV.rating = rating;
                                                                                  widget.reviewV.description = reviewDescription.text;
                                                                                });
                                                                              },
                                                                              style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)), padding: EdgeInsets.symmetric(vertical: 15), backgroundColor: Color(0xFFf9b701)),
                                                                              child: Container(child: Text(widget.post, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white))),
                                                                            ))
                                                                      ]));
                                                            }));
                                              },
                                              child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  margin: EdgeInsets.all(20),
                                                  child: Text(
                                                    'Modifica',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))),
                                        ])));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Icon(Icons.menu, color: Color(0xFFf9b701)),
                          ))
                      : Container()
                ],
              )),
          showResponse
              ? Column(children: [
                  Container(
                      margin: EdgeInsets.only(left: 60, top: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.reviewV?.response?.image ??
                                              ""))),
                            ),
                            Flexible(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                            widget.reviewV?.response?.name ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFFcccccc),
                                            ))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 2.5),
                                        child: Text(
                                            widget.reviewV?.response?.created_at
                                                        ?.day
                                                        .toString() +
                                                    ' ' +
                                                    getMonth(widget.reviewV
                                                            .created_at.month -
                                                        1) ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF999999)))),
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 2.5),
                                        child: Text(
                                            widget.reviewV.response.description,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFFcccccc)))),
                                  ]),
                            )
                          ]))
                ])
              : InkWell(
                  onTap: () {
                    print('a');
                    setState(() {
                      showResponse = true;
                    });
                  },
                  child: widget.reviewV?.response != null
                      ? Container(
                          margin: EdgeInsets.only(left: 70, top: 5),
                          child: Row(children: [
                            Container(
                                child: Text(
                                    widget.reviewV.response.name + ' replied.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).accentColor))),
                          ]))
                      : Container())
        ]));
  }
}
