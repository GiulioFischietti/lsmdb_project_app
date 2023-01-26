import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
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
String socialMediaInitialValue = "";
String websitesInitialValue = "";
String descriptionInitialValue = "";
String emailInitialValue = "";

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

  List<TextEditingController> websites_controller = [];
  List<TextEditingController> socialMedias_controller = [];
  List<TextEditingController> phones_controller = [];
  TextEditingController name_controller =
      new TextEditingController(text: nameInitialValue);
  TextEditingController username_controller =
      new TextEditingController(text: usernameInitialValue);
  TextEditingController address_controller =
      new TextEditingController(text: addressInitialValue);
  TextEditingController email_controller =
      new TextEditingController(text: emailInitialValue);
  TextEditingController password_controller =
      new TextEditingController(text: "Password");
  TextEditingController description_controller =
      new TextEditingController(text: descriptionInitialValue);

  bool popup = false;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    setFields();
  }

  void setFields() async {
    final managerProvider = Provider.of<UserProvider>(context, listen: false);
    setState(() {
      name_controller.text = managerProvider.manager.managedEntity.name;

      email_controller.text = managerProvider.manager.managedEntity.email;
      websites_controller = managerProvider.manager.managedEntity.websites
          .map((e) => TextEditingController(text: e))
          .toList();
      phones_controller = managerProvider.manager.managedEntity.phones
          .map((e) => TextEditingController(text: e))
          .toList();
      socialMedias_controller = managerProvider
          .manager.managedEntity.socialMedias
          .map((e) => TextEditingController(text: e))
          .toList();
    });

    name_controller.addListener(() {
      managerProvider.manager.managedEntity.name = name_controller.text;
    });
    email_controller.addListener(() {
      managerProvider.manager.managedEntity.email = email_controller.text;
    });
    for (int i = websites_controller.length; i <= 0; i--) {
      websites_controller[i].addListener(() {
        print("updated $i with ${websites_controller[i].text}");
        managerProvider.manager.managedEntity.websites[i] =
            websites_controller[i].text;
      });
    }
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
          title: Text("Edit Entity Profile",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        body: Consumer<UserProvider>(builder: (context, managerProvider, _) {
          return !managerProvider.loading
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
                                            child: Wrap(
                                              children: <Widget>[
                                                ListTile(
                                                    leading: const Icon(
                                                        Icons.photo_library),
                                                    title:
                                                        const Text('Galleria'),
                                                    onTap: () {
                                                      _imgFromGallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.photo_camera),
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
                                    height: size.width / 4,
                                    width: size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            size.width / 4),
                                        image: DecorationImage(
                                            // image: _image != null
                                            //     ? FileImage(File(_image.path))
                                            // :
                                            image: NetworkImage(managerProvider
                                                .manager.managedEntity.image),
                                            fit: BoxFit.cover)))),
                            Container(
                                margin: EdgeInsets.only(left: 15, right: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: Text(
                                      managerProvider
                                          .manager.managedEntity.name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    Container(
                                        child: Text(
                                      "@" +
                                          managerProvider
                                              .manager.managedEntity.type,
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
                                  child: Text("Social Medias",
                                      style: GoogleFonts.poppins())),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      children: socialMedias_controller
                                          .asMap()
                                          .map((i, e) => MapEntry(
                                                i,
                                                TextFormField(
                                                    controller:
                                                        socialMedias_controller[
                                                            i],
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                    ),
                                                    style:
                                                        GoogleFonts.poppins()),
                                              ))
                                          .values
                                          .toList())),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      socialMedias_controller
                                          .add(TextEditingController());
                                      managerProvider
                                          .manager.managedEntity.socialMedias
                                          .add("");
                                      socialMedias_controller.last
                                          .addListener(() {
                                        // print(socialMedias_controller.last.text);
                                        managerProvider.manager.managedEntity
                                                .socialMedias.last =
                                            socialMedias_controller.last.text;
                                      });
                                    });
                                  },
                                  child: Container(
                                      width: size.width,
                                      // color: Colors.orange,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                color: Colors.grey
                                                    .withOpacity(0.2))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.only(top: 10),
                                      child:
                                          Icon(Icons.add, color: Colors.grey))),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text("Phones",
                                      style: GoogleFonts.poppins())),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      children: phones_controller
                                          .asMap()
                                          .map((i, e) => MapEntry(
                                                i,
                                                TextFormField(
                                                    controller:
                                                        phones_controller[i],
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                    ),
                                                    style:
                                                        GoogleFonts.poppins()),
                                              ))
                                          .values
                                          .toList())),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      phones_controller
                                          .add(TextEditingController());
                                      managerProvider
                                          .manager.managedEntity.phones
                                          .add("");
                                      phones_controller.last.addListener(() {
                                        // print(phones_controller.last.text);
                                        managerProvider
                                            .manager
                                            .managedEntity
                                            .phones
                                            .last = phones_controller.last.text;
                                      });
                                    });
                                  },
                                  child: Container(
                                      width: size.width,
                                      // color: Colors.orange,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                color: Colors.grey
                                                    .withOpacity(0.2))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.only(top: 10),
                                      child:
                                          Icon(Icons.add, color: Colors.grey))),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text("Websites",
                                      style: GoogleFonts.poppins())),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                      children: websites_controller
                                          .asMap()
                                          .map((i, e) => MapEntry(
                                                i,
                                                TextFormField(
                                                    controller:
                                                        websites_controller[i],
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Colors.grey[300]!,
                                                        ),
                                                      ),
                                                    ),
                                                    style:
                                                        GoogleFonts.poppins()),
                                              ))
                                          .values
                                          .toList())),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      websites_controller
                                          .add(TextEditingController());
                                      managerProvider
                                          .manager.managedEntity.websites
                                          .add("");
                                      websites_controller.last.addListener(() {
                                        // print(websites_controller.last.text);
                                        managerProvider.manager.managedEntity
                                                .websites.last =
                                            websites_controller.last.text;
                                      });
                                    });
                                  },
                                  child: Container(
                                      width: size.width,
                                      // color: Colors.orange,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                spreadRadius: 2,
                                                blurRadius: 7,
                                                color: Colors.grey
                                                    .withOpacity(0.2))
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.only(top: 10),
                                      child:
                                          Icon(Icons.add, color: Colors.grey))),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 30),
                                  child: Text("Email",
                                      style: GoogleFonts.poppins())),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                    controller: email_controller,
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
                        managerProvider.updateMyEntity();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Text("Update Entity Profile",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))))
                ])
              : Container(child: Center(child: CircularProgressIndicator()));
        }));
  }
}
