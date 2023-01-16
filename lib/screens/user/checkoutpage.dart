import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  dynamic bodyData;
  CheckoutPage({
    Key? key,
    this.bodyData,
  }) : super(key: key);
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool paypal_selected = false;
  bool credit_selected = false;
  bool cash_selected = true;
  bool loadingPayment = false;

  bool step1_ongoing = true;
  bool step1_done = false;
  bool step2_ongoing = false;
  bool step2_done = false;
  bool step3_ongoing = false;
  bool step3_done = false;

  var paymentIntentJson;
  @override
  void initState() {
    super.initState();
  }

  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
        backgroundColor: Colors.grey[100],
        title: Text("Checkout",
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500)),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, _) {
        return Container(
          child: userProvider.loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: step1_ongoing
                                      ? Colors.grey[400]!
                                      : step1_done
                                          ? Colors.orange
                                          : Colors.grey),
                              borderRadius: BorderRadius.circular(50)),
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: step1_ongoing
                                    ? Colors.grey[400]!
                                    : step1_done
                                        ? Colors.orange
                                        : Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              height: 30,
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color: step1_ongoing
                                          ? Colors.grey[400]!
                                          : step1_done
                                              ? Colors.orange
                                              : Colors.grey),
                                ),
                              )),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: step2_ongoing
                                    ? Colors.grey[400]!
                                    : step1_done
                                        ? Colors.orange
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: step2_ongoing
                                    ? Colors.grey[400]!
                                    : step2_done
                                        ? Colors.orange
                                        : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        Expanded(
                          child: Container(
                              height: 30,
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 1.0,
                                    color: step2_ongoing
                                        ? Colors.grey[400]!
                                        : step2_done
                                            ? Colors.orange
                                            : Colors.grey,
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          height: 30,
                          width: 30,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: step3_ongoing
                                    ? Colors.grey[400]!
                                    : step3_done
                                        ? Colors.orange
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: step3_ongoing
                                    ? Colors.grey[400]!
                                    : step3_done
                                        ? Colors.orange
                                        : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Text(
                                  "Address",
                                  style: GoogleFonts.poppins(),
                                ))),
                        Expanded(
                            child: Container(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Payment Mode",
                                  style: GoogleFonts.poppins(),
                                ))),
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Summary",
                                  style: GoogleFonts.poppins(),
                                )))
                      ],
                    ),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: PageView(
                              controller: _pageController,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Column(children: [
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: page1builder())),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 7)
                                          ]),
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Cancel",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(context);
                                              },
                                              shape: new RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.orange),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        100.0),
                                              )),
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Next",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.orange,
                                              onPressed: () {
                                                // for (var order in widget.bodyData['orders']) {
                                                // setState(() {
                                                //   order['delivery_address_id'] = _con.deliveryAddress.id;
                                                // });
                                                // }
                                                setState(() {
                                                  step1_ongoing = false;
                                                  step1_done = true;
                                                  step2_ongoing = true;
                                                });

                                                _pageController.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 650),
                                                    curve: Curves.ease);
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                              )),
                                        ],
                                      ))
                                ]),
                                Column(children: [
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: page2builder()),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 7)
                                          ]),
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Back",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  step1_ongoing = false;
                                                  step1_done = true;
                                                  step2_ongoing = true;
                                                });
                                                _pageController.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 650),
                                                    curve: Curves.ease);
                                              },
                                              shape: new RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.orange),
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        100.0),
                                              )),
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Next",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.orange,
                                              onPressed: () async {
                                                // String userId = (await getCurrentUserID())['user_id'];

                                                // for (var order in widget.bodyData['orders']) {
                                                //   if (credit_selected) {
                                                //     String user_name = (await getCurrentUser()).name;
                                                //     order['payment'] = {
                                                //       "user_id": userId,
                                                //       "method": "card",
                                                //       "card_number":
                                                //           _con.creditCard.number.replaceAll(" ", ""),
                                                //       "card_exp_month":
                                                //           _con.creditCard.expiration.split("/")[0],
                                                //       "card_exp_year":
                                                //           "20" + _con.creditCard.expiration.split("/")[1],
                                                //       "card_cvc": _con.creditCard.cvc,
                                                //       "intestazione": _con.creditCard.intestazione
                                                //     };
                                                //   } else {
                                                //     setState(() {
                                                //       order['payment'] = {
                                                //         "user_id": userId,
                                                //         "method": paypal_selected
                                                //             ? "paypal"
                                                //             : credit_selected
                                                //                 ? "card"
                                                //                 : cash_selected
                                                //                     ? "cash"
                                                //                     : ""
                                                //       };
                                                //     });
                                                //   }
                                                // }
                                                setState(() {
                                                  step2_ongoing = false;
                                                  step2_done = true;
                                                  step3_ongoing = true;
                                                });
                                                // if (_con.creditCard.number == "" && credit_selected) {

                                                _pageController.nextPage(
                                                    duration: Duration(
                                                        milliseconds: 650),
                                                    curve: Curves.ease);
                                              },
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        100.0),
                                              )),
                                        ],
                                      ))
                                ]),
                                Column(children: [
                                  Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.all(20),
                                          child: page3builder(
                                              userProvider.cartProducts,
                                              userProvider.user))),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 7)
                                          ]),
                                      padding:
                                          EdgeInsets.only(bottom: 10, top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Back",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.white,
                                              onPressed: () {
                                                _pageController.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 650),
                                                    curve: Curves.ease);
                                              },
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Colors.orange),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                              )),
                                          MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40,
                                                  vertical: 2.5),
                                              elevation: 0,
                                              minWidth: 0,
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    "Confirm order",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              color: Colors.orange,
                                              onPressed: () async {
                                                setState(() {
                                                  // loadingPayment = true;
                                                  step2_ongoing = false;
                                                  step3_done = true;
                                                });
                                                showCustomDialog(
                                                    "Thank you for your order",
                                                    () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  (BottomTabContainer(
                                                                    initialIndex:
                                                                        0,
                                                                  ))));
                                                });
                                                userProvider.createOrder(
                                                    payment_type:
                                                        credit_selected
                                                            ? "card"
                                                            : "cash",
                                                    shipping_country:
                                                        default_address
                                                            ? userProvider
                                                                .user.country
                                                            : country_controller
                                                                .text,
                                                    shipping_address:
                                                        default_address
                                                            ? userProvider
                                                                .user.address
                                                            : (address_controller
                                                                    .text +
                                                                " " +
                                                                cap_controller
                                                                    .text));
                                              },
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        100.0),
                                              )),
                                        ],
                                      ))
                                ])
                              ],
                            ))),
                  ],
                ),
        );
      }),
    );
  }

  TextEditingController street_controller = new TextEditingController();
  TextEditingController country_controller = new TextEditingController();
  TextEditingController cap_controller = new TextEditingController();
  bool default_address = true;
  TextEditingController address_controller = new TextEditingController();

  Widget page1builder() {
    return ListView(shrinkWrap: true, children: [
      Container(
          margin: EdgeInsets.only(top: 40),
          child: Text(
            "Delivery Address Info",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      Row(
        children: [
          Container(
              margin: EdgeInsets.only(top: 40),
              child: Checkbox(
                activeColor: Colors.orange,
                onChanged: (bool? val) {
                  setState(() {
                    default_address = val!;
                  });
                },
                value: default_address,
              )),
          Container(
              margin: EdgeInsets.only(top: 40, left: 10),
              child: Text(
                "Use default address",
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.normal),
              )),
        ],
      ),
      default_address
          ? Container()
          : Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Name",
                      style: GoogleFonts.poppins()
                          .copyWith(color: Colors.grey[500]),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: name_controller,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      // decoration: InputDecoration(border: InputBorder.none),
                      autofocus: true,
                      cursorColor: Colors.black,
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Street",
                      style: GoogleFonts.poppins()
                          .copyWith(color: Colors.grey[500]),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: street_controller,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      // decoration: InputDecoration(border: InputBorder.none),
                      autofocus: true,
                      cursorColor: Colors.black,
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "Country",
                      style: GoogleFonts.poppins()
                          .copyWith(color: Colors.grey[500]),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: country_controller,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      // decoration: InputDecoration(border: InputBorder.none),
                      autofocus: true,
                      cursorColor: Colors.black,
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      "CAP",
                      style: GoogleFonts.poppins()
                          .copyWith(color: Colors.grey[500]),
                    )),
                Container(
                    margin: EdgeInsets.only(
                      top: 15,
                    ),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      controller: cap_controller,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      // decoration: InputDecoration(border: InputBorder.none),
                      autofocus: true,
                      cursorColor: Colors.black,
                    )),
              ],
            ),
    ]);
  }

  TextEditingController creditn_controller = new TextEditingController();
  TextEditingController name_controller = new TextEditingController();
  TextEditingController exp_controller = new TextEditingController();
  TextEditingController cvv_controller = new TextEditingController();

  Widget page2builder() {
    return ListView(shrinkWrap: true, children: [
      Row(
        children: [
          Expanded(child: Container()),
          // Expanded(
          //     child: InkWell(
          //         onTap: () {
          //           setState(() {
          //             paypal_selected = true;
          //             credit_selected = false;
          //             cash_selected = false;
          //           });
          //         },
          //         child: Container(
          //             height: 50,
          //             margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(2),
          //               color: paypal_selected
          //                   ? Colors.orange
          //                   : Colors.white,
          //             ),
          //             child: Image.asset("assets/img/PayPal.png",
          //                 color: paypal_selected
          //                     ? Colors.white
          //                     : Colors.grey[600])))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      paypal_selected = false;
                      credit_selected = true;
                      cash_selected = false;
                    });
                  },
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: credit_selected
                                ? Colors.transparent
                                : Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(2),
                        color: credit_selected ? Colors.orange : Colors.white,
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Icon(Icons.credit_card_outlined,
                          color: credit_selected
                              ? Colors.white
                              : Colors.grey[600])))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      paypal_selected = false;
                      credit_selected = false;
                      cash_selected = true;
                    });
                  },
                  child: Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: cash_selected
                                ? Colors.transparent
                                : Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(2),
                        color: cash_selected ? Colors.orange : Colors.white,
                      ),
                      child: Icon(
                        Icons.money,
                        color: cash_selected ? Colors.white : Colors.grey[600],
                        size: 22,
                      )))),
          Expanded(child: Container())
        ],
      ),
      credit_selected
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    "Pay with card",
                    style: GoogleFonts.poppins(),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "Full name",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.grey[500], fontSize: 13),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: TextFormField(
                    controller: name_controller,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    // decoration: InputDecoration(border: InputBorder.none),
                    autofocus: true,
                    cursorColor: Colors.black,
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30),
                  child: Text(
                    "Card Number",
                    style: GoogleFonts.poppins()
                        .copyWith(color: Colors.grey[500], fontSize: 13),
                  )),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 15),
                child: Row(children: [
                  Expanded(
                      child: Container(
                          child: TextFormField(
                    controller: creditn_controller,
                    // decoration: InputDecoration(border: InputBorder.none),
                    autofocus: true,
                    cursorColor: Colors.black,
                  ))),
                  Icon(Icons.credit_card)
                ]),
              ),
              Row(
                children: [
                  Flexible(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 15, right: 15),
                        child: Text("Exp date",
                            style: GoogleFonts.poppins().copyWith(
                                color: Colors.grey[500], fontSize: 13)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 15, right: 15),
                        child: TextFormField(
                          controller: exp_controller,
                          // decoration: InputDecoration(border: InputBorder.none),
                          autofocus: true,
                          cursorColor: Colors.black,
                        ),
                      ),
                    ],
                  )),
                  Flexible(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 15, left: 15),
                        child: Text("CVC",
                            style: GoogleFonts.poppins().copyWith(
                                color: Colors.grey[500], fontSize: 13)),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 15, left: 15),
                          child: TextFormField(
                            controller: cvv_controller,
                            // decoration: InputDecoration(border: InputBorder.none),
                            autofocus: true,
                            cursorColor: Colors.black,
                          )),
                    ],
                  )),
                ],
              ),
            ])
          : cash_selected
              ? Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(30),
                  child: Text(
                    "Cash",
                    style: GoogleFonts.poppins(),
                  ))
              : Container(),
    ]);
  }

  Widget page3builder(List<ProductOrder> cartProducts, Customer user) {
    return ListView(shrinkWrap: true, children: [
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 20, right: 10),
          child: Text(
            "Summary",
            style: GoogleFonts.poppins(),
          )),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            height: 220,
            decoration: BoxDecoration(),
            margin: EdgeInsets.only(bottom: 40, top: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: cartProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(140),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(cartProducts[index].image))),
                    ),
                    Flexible(
                        child: Container(
                            width: 120,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              (cartProducts[index].quantity != 1
                                      ? cartProducts[index]
                                              .quantity
                                              .toStringAsFixed(0) +
                                          'x '
                                      : "") +
                                  cartProducts[index].name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: GoogleFonts.poppins(),
                            ))),
                    Flexible(
                        child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "€ " +
                                  (cartProducts[index].price *
                                          cartProducts[index].quantity)
                                      .toStringAsFixed(2)
                                      .toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.poppins(),
                            ))),
                  ],
                );
              },
            )),
        Row(
          children: [
            Expanded(
                child: Container(
                    child: Text(
              "Total",
              style: GoogleFonts.poppins(),
            ))),
            Container(
                child: Text(
              '€' +
                  (cartProducts.map((e) => e.price * e.quantity))
                      .reduce((a, b) => a + b)
                      .toStringAsFixed(2),
              style: GoogleFonts.poppins(),
            ))
          ],
        )
      ]),
      Container(
          margin: EdgeInsets.only(top: 20),
          child: Divider(
            color: Colors.grey[400]!,
          )),
      Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "Delivery address",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
          )),
      Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            default_address
                ? (user.name + '\n' + user.address + ', ' + user.country)
                : name_controller.text +
                    '\n' +
                    street_controller.text +
                    ', ' +
                    country_controller.text +
                    '\n' +
                    cap_controller.text,
            style: GoogleFonts.poppins(),
          )),
      InkWell(
          onTap: () {
            _pageController.animateTo(0,
                duration: Duration(milliseconds: 650), curve: Curves.ease);
          },
          child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Update",
                style: GoogleFonts.poppins(
                    color: Colors.orange, fontWeight: FontWeight.w500),
              ))),
      Container(
          margin: EdgeInsets.only(top: 20),
          child: Divider(
            color: Colors.grey[400]!,
          )),
      Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "Payment Mode",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          )),
      Container(
          margin: EdgeInsets.only(top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            cash_selected ? "Cash" : "Credit card",
            style: GoogleFonts.poppins(),
          )),
      InkWell(
          onTap: () {
            _pageController.animateToPage(1,
                duration: Duration(milliseconds: 650), curve: Curves.ease);
          },
          child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text("Update",
                  style: GoogleFonts.poppins(
                      color: Colors.orange, fontWeight: FontWeight.w500)))),
    ]);
  }

  showCustomDialog(String content, Function callback) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Info'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              },
            ),
          ],
        );
      },
    );
  }
}
