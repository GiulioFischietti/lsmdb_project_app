import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:provider/provider.dart';
// ignore: must_be_immutable

class CardWidgetCartItem extends StatefulWidget {
  ProductOrder item;

  CardWidgetCartItem({Key? key, required this.item}) : super(key: key);

  @override
  _CardWidgetCartItemState createState() => _CardWidgetCartItemState();
}

class _CardWidgetCartItemState extends State<CardWidgetCartItem> {
  @override
  void initState() {
    super.initState();
    // getItemNotes();
  }

  TextEditingController noteController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // widget._con = ProductController();
    // widget._con.product = widget.item.product;
    return widget.item.quantity != 0
        ? Slidable(
            key: ValueKey(widget.item.productId),
            enabled: true,
            endActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {
                setState(() {
                  widget.item.quantity = 0;
                });
                final userProvider =
                    Provider.of<UserProvider>(context, listen: false);

                userProvider.removeAllFromCart(widget.item.productId);
                removeAllFromCart(widget.item.productId, userProvider.user.id);
              }),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (ctx) async {
                    // await _con.removeItemFromCart(widget.item.id);
                    // await widget.updateCart();
                    setState(() {
                      widget.item.quantity = 0;
                    });
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    userProvider.removeAllFromCart(widget.item.productId);
                    removeAllFromCart(
                        widget.item.productId, userProvider.user.id);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ProductDetails(
                  //           product_id: widget.item.id,
                  //         )));
                },
                child: Container(
                    margin: EdgeInsets.only(left: 15, bottom: 15),
                    height: 165,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.item.image))),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(
                                    left: 15, top: 15, bottom: 15, right: 30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(right: 15, top: 10),
                                        child: Text(
                                          widget.item.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: 2.5, top: 5),
                                        child: Text(widget.item.category,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                                fontSize: 13))),
                                    Expanded(child: Container()),
                                    Container(
                                        // width: 90,
                                        margin: EdgeInsets.only(bottom: 5),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  // await _con.addToCart(
                                                  //     widget.item.id);
                                                  // await widget.updateCart();
                                                  // widget.addTotal(widget
                                                  //     .item.product.price);

                                                  final userProvider =
                                                      Provider.of<UserProvider>(
                                                          context,
                                                          listen: false);
                                                  addToCart(
                                                      name: widget.item.name,
                                                      price: widget.item.price,
                                                      category:
                                                          widget.item.category,
                                                      image_url:
                                                          widget.item.image,
                                                      product_id:
                                                          widget.item.productId,
                                                      user_id:
                                                          userProvider.user.id);
                                                  userProvider.addOneToCart(
                                                      widget.item.productId);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5,
                                                            left: 0,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Icon(Icons.add,
                                                        color: Colors.grey[600],
                                                        size: 18))),
                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                        widget.item.quantity
                                                            .toStringAsFixed(0),
                                                        style: GoogleFonts
                                                            .poppins()))),
                                            InkWell(
                                                onTap: () async {
                                                  final userProvider =
                                                      Provider.of<UserProvider>(
                                                          context,
                                                          listen: false);
                                                  userProvider
                                                      .removeOneFromCart(widget
                                                          .item.productId);
                                                  removeOneFromCart(
                                                      widget.item.productId,
                                                      userProvider.user.id);
                                                },
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5,
                                                            left: 5,
                                                            top: 5,
                                                            bottom: 5),
                                                    child: Icon(Icons.remove,
                                                        color: Colors.grey[600],
                                                        size: 18))),
                                          ],
                                        ))
                                  ],
                                ))),
                        Container(
                            alignment: Alignment.bottomRight,
                            margin: const EdgeInsets.only(
                                bottom: 20, left: 0, right: 15),
                            child: Text(
                              "€ ${(widget.item.price * widget.item.quantity).toStringAsFixed(2)}",
                              style: GoogleFonts.poppins(),
                            ))
                      ],
                    ))))
        : Container();
  }
}
