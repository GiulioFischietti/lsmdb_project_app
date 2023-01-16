import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/screens/user/order_details.dart';

class CardWidgetOrder extends StatefulWidget {
  Order order;
  CardWidgetOrder({Key? key, required this.order});

  @override
  State<CardWidgetOrder> createState() => _CardWidgetOrderState();
}

class _CardWidgetOrderState extends State<CardWidgetOrder> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) =>
                  OrderDetails(order: widget.order, id: widget.order.id)));
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 7)
                ]),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text("Order #${widget.order.id}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                            widget.order.orderDate.toString().split(' ')[0],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.normal)),
                      ),
                    ]),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text("Shipping address",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal)),
                        )),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(widget.order.shippingAddress.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text("Total Amount",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal)),
                        )),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                              "€" + widget.order.total.toStringAsFixed(2),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal)),
                        )
                      ],
                    ),
                    Row(children: [
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text("Status",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal)),
                      )),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(widget.order.status,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                color: widget.order.status == 'Paid'
                                    ? Colors.grey
                                    : widget.order.status == 'In preparation'
                                        ? Colors.orange
                                        : widget.order.status == 'Shipped'
                                            ? Colors.orange
                                            : widget.order.status == 'Delivered'
                                                ? Colors.green
                                                : Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  ],
                ))
              ],
            )));
  }
}
