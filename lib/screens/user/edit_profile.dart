import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

String nameInitialValue = "";
String usernameInitialValue = "";
String phoneInitialValue = "";
String addressInitialValue = "";

class _EditProfileState extends State<EditProfile> {
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
      new TextEditingController(text: nameInitialValue);
  TextEditingController username_controller =
      new TextEditingController(text: usernameInitialValue);
  TextEditingController address_controller =
      new TextEditingController(text: addressInitialValue);
  TextEditingController phone_controller =
      new TextEditingController(text: phoneInitialValue);
  TextEditingController password_controller =
      new TextEditingController(text: "Password");

  bool popup = false;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    setFields();
  }

  void setFields() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      name_controller.text = userProvider.user.name;
      username_controller.text = userProvider.user.username;
      phone_controller.text = userProvider.user.phone;
      address_controller.text = userProvider.user.address;
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
          title: Text("Edit Profile",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, _) {
          return !userProvider.loading
              ? Column(children: [
                  Expanded(
                      child: ListView(shrinkWrap: true, children: [
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return SafeArea(
                                          child: Container(
                                            child: new Wrap(
                                              children: <Widget>[
                                                new ListTile(
                                                    leading: new Icon(
                                                        Icons.photo_library),
                                                    title: new Text('Galleria'),
                                                    onTap: () {
                                                      _imgFromGallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                new ListTile(
                                                  leading: new Icon(
                                                      Icons.photo_camera),
                                                  title: new Text('Fotocamera'),
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
                                    height: size.width / 4,
                                    width: size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            size.width / 4),
                                        image: DecorationImage(
                                            // image: _image != null
                                            //     ? FileImage(File(_image.path))
                                            // :
                                            image: NetworkImage(
                                                userProvider.user.image),
                                            fit: BoxFit.cover)))),
                            Container(
                                margin: EdgeInsets.only(left: 15, right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Text(
                                      userProvider.user.name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Container(
                                        child: Text(
                                      "@" + userProvider.user.username,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey[500]),
                                    ))
                                  ],
                                )),
                          ],
                        )),
                    Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              color: Colors.grey[400]!.withOpacity(0.1),
                              blurRadius: 7,
                              offset: Offset(10, 10),
                              spreadRadius: 3)
                        ]),
                        padding: EdgeInsets.all(30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text("Name",
                                      style: GoogleFonts.poppins())),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
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
                                  child: Text("Username",
                                      style: GoogleFonts.poppins())),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                    controller: username_controller,
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
                                  child: Text("Phone",
                                      style: GoogleFonts.poppins())),
                              Container(
                                alignment: Alignment.centerLeft,
                                // margin: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phone_controller,
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
                                  child: Text("Address",
                                      style: GoogleFonts.poppins())),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                    controller: address_controller,
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
                                  child: Text("Password",
                                      style: GoogleFonts.poppins())),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  // margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: 1.5, top: 5),
                                              child: Icon(
                                                Icons.circle,
                                                size: 9,
                                              )),
                                        ],
                                      )),
                                      InkWell(
                                          onTap: () {
                                            // Navigator.of(context)
                                            //     .push(MaterialPageRoute(
                                            //   builder: (context) => EditPassword(),
                                            // ));
                                          },
                                          child: Container(
                                              width: 100,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "Edit Password",
                                                style: GoogleFonts.poppins()
                                                    .copyWith(fontSize: 12),
                                              ))),
                                    ],
                                  )),
                            ])),
                  ])),
                  InkWell(
                      onTap: () async {
                        // await userProvider.updateUser(
                        //     name_controller.text,
                        //     username_controller.text,
                        //     phone_controller.text,
                        //     address_controller.text);
                        // Navigator.of(context).pop();
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Text("Update Profile",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))))
                ])
              : Container(child: Center(child: CircularProgressIndicator()));
        }));
  }
}
