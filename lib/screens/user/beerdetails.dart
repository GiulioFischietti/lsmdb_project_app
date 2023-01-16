import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:eventi_in_zona/screens/user/cart.dart';
import 'package:provider/provider.dart';

class BeerDetails extends StatefulWidget {
  int id;
  BeerDetails({Key? key, required this.id}) : super(key: key);

  @override
  _BeerDetailsState createState() => _BeerDetailsState();
}

class _BeerDetailsState extends State<BeerDetails> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBeerById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            Stack(
              children: [
                Positioned(
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (ctx) => BottomTabContainer(
                                        initialIndex: 1,
                                      )));
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 10),
                            child: Icon(Icons.shopping_cart_outlined,
                                color: Colors.black)))),
                Consumer<UserProvider>(builder: (context, userProvider, _) {
                  return Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                        height: 15,
                        width: 15,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(userProvider.cartProducts.length.toString(),
                            style: GoogleFonts.poppins(
                                fontSize: 11, color: Colors.white))),
                  );
                })
              ],
            )
          ],
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
          backgroundColor: Colors.grey[100],
          title: Text("Beer",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        backgroundColor: Colors.white,
        body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          return homeProvider.loading
              ? Container(
                  height: size.height,
                  child: Center(child: CircularProgressIndicator.adaptive()))
              : Column(children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        height: size.width / 1.5,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: homeProvider.beer.imageUnavailable
                                    ? BoxFit.cover
                                    : BoxFit.contain,
                                image: NetworkImage(homeProvider.beer.image))),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          color: Colors.white,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 20, bottom: 10),
                                            child: Text(homeProvider.beer.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20)))),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "€ " +
                                          homeProvider.beer.price
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: Colors.black),
                                    )),
                              ])),
                      field("Brand", homeProvider.beer.brand),
                      field("Description", homeProvider.beer.description),
                      field(
                          "Alcohol Percentage",
                          homeProvider.beer.alcoholPercentage
                                  .toStringAsFixed(1) +
                              '%'),
                      field("Volume",
                          homeProvider.beer.volumeMl.toString() + 'mL'),
                    ],
                  )),
                  InkWell(
                      onTap: () async {
                        final userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        const snackBar = SnackBar(
                          content: Text('Item added to cart'),
                        );
                        await addToCart(
                            name: homeProvider.beer.name,
                            price: homeProvider.beer.price,
                            category: homeProvider.beer.category,
                            image_url: homeProvider.beer.image,
                            product_id: homeProvider.beer.productId,
                            user_id: userProvider.user.id);

                        userProvider.getUserCart();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Text("Add To Cart",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))))
                ]);
        }));
  }

  Widget field(String title, String content) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(fontSize: 18),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      content,
                      style: GoogleFonts.poppins(),
                    ))
              ],
            )),
          ],
        ));
  }
}
