import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/manager/edit_book.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:eventi_in_zona/screens/user/cart.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  int id;
  BookDetails({Key? key, required this.id}) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBookById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
          backgroundColor: Colors.grey[100],
          title: Text("Book",
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
                                fit: homeProvider.book.imageUnavailable
                                    ? BoxFit.cover
                                    : BoxFit.contain,
                                image: NetworkImage(homeProvider.book.image))),
                      ),
                      Container(
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
                                            child: Text(homeProvider.book.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20)))),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "€ " +
                                          homeProvider.book.price
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: Colors.black),
                                    )),
                              ])),
                      field("Brand", homeProvider.book.brand),
                      field("Summary", homeProvider.book.summary),
                      field("N. Pages", homeProvider.book.nPages.toString()),
                      field("Language", homeProvider.book.language),
                    ],
                  )),
                  InkWell(
                      onTap: () {
                        // final userProvider =
                        //     Provider.of<UserProvider>(context, listen: false);
                        // addToCart(
                        //     name: homeProvider.book.name,
                        //     price: homeProvider.book.price,
                        //     category: homeProvider.book.category,
                        //     image_url: homeProvider.book.image,
                        //     product_id: homeProvider.book.productId,
                        //     user_id: userProvider.user.id);

                        // const snackBar = SnackBar(
                        //   content: Text('Item added to cart'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                EditBook(book: homeProvider.book)));
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Text("Update Details",
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
