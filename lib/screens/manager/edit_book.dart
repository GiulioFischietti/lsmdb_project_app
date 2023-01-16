import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EditBook extends StatefulWidget {
  Book book;
  EditBook({Key? key, required this.book}) : super(key: key);

  @override
  _EditBookState createState() => _EditBookState();
}

String nameInitialValue = "";
String shortDescriptionInitialValue = "";
String descriptionInitialValue = "";
String alcoholInitialValue = "";
String volumeInitialValue = "";
String priceInitialValue = "";
String stockInitialValue = "";

class _EditBookState extends State<EditBook> {
  XFile? _image;

  _imgFromCamera() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 30);

    setState(() {
      _image = image!;
    });
    // widget.con.editPropic(file: File(image.path));
  }

  _imgFromGallery() async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
    // widget.con.editPropic(file: File(image.path));
  }

  TextEditingController name_controller =
      TextEditingController(text: nameInitialValue);
  TextEditingController short_description_controller =
      TextEditingController(text: shortDescriptionInitialValue);
  TextEditingController description_controller =
      TextEditingController(text: descriptionInitialValue);
  TextEditingController price_controller =
      TextEditingController(text: priceInitialValue);
  TextEditingController n_pages_controller =
      TextEditingController(text: volumeInitialValue);
  TextEditingController summary_controller =
      TextEditingController(text: alcoholInitialValue);
  TextEditingController stock_controller =
      TextEditingController(text: stockInitialValue);
  TextEditingController language_controller =
      TextEditingController(text: stockInitialValue);

  bool popup = false;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    setFields();
  }

  void setFields() async {
    final managerProvider =
        Provider.of<ManagerProvider>(context, listen: false);
    setState(() {
      name_controller.text = widget.book.name;
      price_controller.text = widget.book.price.toStringAsFixed(2);
      stock_controller.text = widget.book.stock.toString();
      short_description_controller.text = widget.book.shortDescription;
      description_controller.text = widget.book.description;
      summary_controller.text = widget.book.summary;
      n_pages_controller.text = widget.book.nPages.toString();
      language_controller.text = widget.book.language;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
          backgroundColor: Colors.grey[100],
          title: Text("Edit Product",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        body: Column(children: [
          Expanded(
              child: ListView(shrinkWrap: true, children: [
            Container(
                color: Colors.white,
                // padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Container(
                                    child: Wrap(
                                      children: <Widget>[
                                        ListTile(
                                            leading: Icon(Icons.photo_library),
                                            title: Text('Galleria'),
                                            onTap: () {
                                              _imgFromGallery();
                                              Navigator.of(context).pop();
                                            }),
                                        ListTile(
                                          leading: Icon(Icons.photo_camera),
                                          title: Text('Fotocamera'),
                                          onTap: () {
                                            _imgFromCamera();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                            height: size.width / 2,
                            width: size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    // image: _image != null
                                    //     ? FileImage(File(_image.path))
                                    // :
                                    image: NetworkImage(widget.book.image),
                                    fit: BoxFit.contain)))),
                  ],
                )),
            Container(
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400]!.withOpacity(0.1),
                      blurRadius: 7,
                      offset: Offset(10, 10),
                      spreadRadius: 3)
                ]),
                padding: EdgeInsets.all(30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Name", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) => widget.book.name = value,
                            controller: name_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Short Description",
                              style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) =>
                                widget.book.shortDescription = value,
                            controller: short_description_controller,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Description",
                              style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) =>
                                widget.book.description = value,
                            minLines: 3,
                            maxLines: 3,
                            controller: description_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Price €", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) =>
                                widget.book.price = double.parse(value),
                            controller: price_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("N Pages", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) =>
                                widget.book.nPages = int.parse(value),
                            keyboardType: TextInputType.number,
                            controller: n_pages_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Summary", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) => widget.book.summary = value,
                            keyboardType: TextInputType.number,
                            controller: summary_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child:
                              Text("Language", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) => widget.book.language = value,
                            textCapitalization: TextCapitalization.characters,
                            keyboardType: TextInputType.name,
                            controller: language_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Stock", style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) =>
                                widget.book.stock = int.parse(value),
                            keyboardType: TextInputType.number,
                            controller: stock_controller,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                            ),
                            style: GoogleFonts.poppins()),
                      ),
                    ])),
          ])),
          InkWell(
              onTap: () async {
                final managerProvider =
                    Provider.of<ManagerProvider>(context, listen: false);
                managerProvider.updateBook(widget.book);
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Text("Update Product",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold))))
        ]));
  }
}
