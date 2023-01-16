import 'package:eventi_in_zona/models/beer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/user/beerdetails.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardWidgetBeer extends StatefulWidget {
  Beer beer;

  CardWidgetBeer({
    Key? key,
    required this.beer,
  }) : super(key: key);

  @override
  _CardWidgetBeerState createState() => _CardWidgetBeerState();
}

class _CardWidgetBeerState extends State<CardWidgetBeer> {
  bool addedToCart = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.all(10),
        width: size.width / 2.5,
        child: Column(children: [
          InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => BeerDetails(id: widget.beer.productId)));
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.beer.image)),
                      borderRadius: BorderRadius.circular(5)),
                  width: size.width / 2.5,
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
                    child: Text("€" + widget.beer.price.toStringAsFixed(2),
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500))),
                Expanded(child: Container()),
                InkWell(
                    onTap: () {
                      setState(() {
                        addedToCart = true;
                      });
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      addToCart(
                          name: widget.beer.name,
                          price: widget.beer.price,
                          category: widget.beer.category,
                          image_url: widget.beer.image,
                          product_id: widget.beer.productId,
                          user_id: userProvider.user.id);

                      const snackBar = SnackBar(
                        content: Text('Item added to cart'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 2.5),
                        child: Icon(Icons.add_shopping_cart_outlined,
                            size: 16,
                            color: addedToCart ? Colors.orange : Colors.black)))
              ])),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.beer.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 14)))),
          ]),
        ]));
  }
}
