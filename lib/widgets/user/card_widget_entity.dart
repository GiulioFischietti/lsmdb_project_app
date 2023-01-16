import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/screens/user/club_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/user/bookdetails.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardWidgetEntity extends StatefulWidget {
  EntityMinimal entity;

  CardWidgetEntity({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  _CardWidgetEntityState createState() => _CardWidgetEntityState();
}

class _CardWidgetEntityState extends State<CardWidgetEntity> {
  bool addedToCart = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.all(10),
        width: size.width / 2.3,
        child: Column(children: [
          InkWell(
              onTap: () {
                switch (widget.entity.type) {
                  case "club":
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ClubDetails(id: widget.entity.id)));
                    break;
                  // case "organizer":
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (ctx) => OrganizerDetails(id: widget.entity.id)));
                  //   break;
                  // case "artist":
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (ctx) => ClubDetails(id: widget.entity.id)));
                  //   break;

                  default:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ClubDetails(id: widget.entity.id)));
                    break;
                }
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          onError: (error, stacktrace) {
                            widget.entity.image =
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSJXPMV4om8DHHMSpua5R6d8TlCmR0zDwbQ&usqp=CAU";
                            setState(() {});
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.entity.image)),
                      borderRadius: BorderRadius.circular(5)),
                  width: size.width / 2.3,
                  height: size.width / 2)),
          Container(
              margin: const EdgeInsets.only(top: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.5, vertical: 1.5),
                    decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.circular(50)),
                    margin: const EdgeInsets.only(left: 2.5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.entity.type,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500))),
                Expanded(child: Container()),
                //   InkWell(
                //       onTap: () {
                //         setState(() {
                //           addedToCart = !addedToCart;
                //         });
                //         final userProvider =
                //             Provider.of<UserProvider>(context, listen: false);
                //         // addToCart(
                //         //     name: widget.entity.name,
                //         //     price: widget.entity.price,
                //         //     category: widget.entity.category,
                //         //     image_url: widget.entity.image,
                //         //     product_id: widget.entity.productId,
                //         //     user_id: userProvider.user.id);

                //         SnackBar snackBar = SnackBar(
                //           content: Text(
                //               '${addedToCart ? "Added to" : "Removed from"}  favorites'),
                //         );
                //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //       },
                //       child: Container(
                //           margin: const EdgeInsets.only(right: 2.5),
                //           child: Icon(
                //               addedToCart
                //                   ? Icons.favorite
                //                   : Icons.favorite_outline,
                //               size: 16,
                //               color: addedToCart ? Colors.red : Colors.black)))
              ])),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.entity.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 14)))),
          ]),
        ]));
  }
}
