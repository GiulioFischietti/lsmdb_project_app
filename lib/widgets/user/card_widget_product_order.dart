import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/product_order.dart';

class CardWidgetProductOrder extends StatefulWidget {
  ProductOrder productOrder;
  CardWidgetProductOrder({Key? key, required this.productOrder});

  @override
  State<CardWidgetProductOrder> createState() => _CardWidgetProductOrderState();
}

class _CardWidgetProductOrderState extends State<CardWidgetProductOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 7.5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.productOrder.image)))),
          Flexible(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Row(children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(widget.productOrder.name,
                          style: GoogleFonts.poppins()))),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "€ " + (widget.productOrder.total).toStringAsFixed(2),
                    style: GoogleFonts.poppins(),
                  )),
            ]),
            Container(
                margin: EdgeInsets.only(top: 2.5),
                alignment: Alignment.centerLeft,
                child: Text(
                    "Quantity: ${widget.productOrder.quantity.toStringAsFixed(0)}",
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.grey))),
          ]))
        ]));
  }
}
