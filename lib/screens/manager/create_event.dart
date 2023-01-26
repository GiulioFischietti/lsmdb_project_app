import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class CreateEvent extends StatefulWidget {
  CreateEvent({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();
}

String nameInitialValue = "";
String shortDescriptionInitialValue = "";
String descriptionInitialValue = "";
String alcoholInitialValue = "";
String volumeInitialValue = "";
String priceInitialValue = "";
String stockInitialValue = "";

class _CreateEventState extends State<CreateEvent> {
  XFile? _image;
  late Event event;
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

  String dropdownValue = "Any";
  TextEditingController name_controller =
      TextEditingController(text: nameInitialValue);
  TextEditingController short_description_controller =
      TextEditingController(text: shortDescriptionInitialValue);
  TextEditingController description_controller =
      TextEditingController(text: descriptionInitialValue);
  TextEditingController price_controller =
      TextEditingController(text: priceInitialValue);
  TextEditingController volume_controller =
      TextEditingController(text: volumeInitialValue);
  TextEditingController alcohol_controller =
      TextEditingController(text: alcoholInitialValue);
  TextEditingController stock_controller =
      TextEditingController(text: stockInitialValue);
  TextEditingController brand_controller =
      TextEditingController(text: stockInitialValue);

  bool popup = false;
  bool notifications = true;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.manager.managedEntity.type == "club") {
      event = Event({
        "organizers": [userProvider.manager.managedEntity.toJson()],
        "club": userProvider.manager.managedEntity.toJson(),
        "address": userProvider.manager.managedEntity.address,
        "location": userProvider.manager.managedEntity.location.toJson(),
      });
    }
    if (userProvider.manager.managedEntity.type == "organizer") {
      event = Event({
        "organizers": [userProvider.manager.managedEntity.toJson()],
      });
    }
    if (userProvider.manager.managedEntity.type == "artist") {
      event = Event({
        "artists": [userProvider.manager.managedEntity.toJson()],
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> selectedGenres = [];

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
          title: Text("Create Event",
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
                                    image: NetworkImage(event.image),
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
                            onChanged: (value) => event.name = value,
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
                          margin: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text("Genres", style: GoogleFonts.poppins())),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 0),
                          child: Wrap(
                              children: List.from(event.genres
                                  .map((e) => InkWell(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.orange),
                                          margin: const EdgeInsets.only(
                                              right: 10, top: 10),
                                          padding: const EdgeInsets.only(
                                              top: 2.5,
                                              bottom: 2.5,
                                              left: 5,
                                              right: 5),
                                          child: Text(
                                            e,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white),
                                          ))))
                                  .toList()
                                ..add(InkWell(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0)),
                                          ),
                                          backgroundColor: Colors.white,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter setStateModal) {
                                              return Container(
                                                  height: 240,
                                                  alignment: Alignment.center,
                                                  child: Column(children: [
                                                    Container(
                                                        margin: const EdgeInsets
                                                            .all(20),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: DropdownButton<
                                                            String>(
                                                          value: dropdownValue,
                                                          icon: const Icon(Icons
                                                              .arrow_downward),
                                                          elevation: 16,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black),
                                                          onChanged:
                                                              (String? value) {
                                                            // This is called when the user selects an item.
                                                            setState(() {
                                                              dropdownValue =
                                                                  value!;
                                                            });
                                                            setStateModal(() {
                                                              dropdownValue =
                                                                  value!;
                                                            });
                                                          },
                                                          items: genres.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        )),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (!event.genres
                                                                .contains(
                                                                    dropdownValue)) {
                                                              event.genres.add(
                                                                  dropdownValue);
                                                            }
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                          dropdownValue = "Any";
                                                        },
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .orange,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Text(
                                                              "Confirm",
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )))
                                                  ]));
                                            });
                                          });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 7,
                                                  spreadRadius: 2,
                                                  color: Colors.orange
                                                      .withOpacity(0.2))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        margin: const EdgeInsets.only(
                                            right: 10, top: 10),
                                        padding: const EdgeInsets.only(
                                            top: 2.5,
                                            bottom: 2.5,
                                            left: 5,
                                            right: 5),
                                        child: Text(
                                          "Add genre",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.orange),
                                        ))))))),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("Description",
                              style: GoogleFonts.poppins())),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                            onChanged: (value) => event.description = value,
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
                          child: Text("Start", style: GoogleFonts.poppins())),
                      InkWell(
                          onTap: () async {
                            var selectedDate = await showDatePicker(
                              cancelText: 'Annulla',
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (selectedDate != null) {
                              var selectedHour = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (selectedHour != null) {
                                setState(() {
                                  event.start = DateTime(
                                      selectedDate!.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedHour.hour,
                                      selectedHour.minute);
                                  event.end =
                                      event.start.add(const Duration(hours: 4));
                                });
                              } else {
                                selectedDate = DateTime.now();
                              }
                            }
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${event.start.day} ${months[event.start.month]} at ${event.start.hour}:${event.start.minute >= 10 ? event.start.minute : "0${event.start.minute}"}',
                                style: GoogleFonts.poppins(),
                              ))),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 30),
                          child: Text("End", style: GoogleFonts.poppins())),
                      InkWell(
                          onTap: () async {
                            var selectedDate = await showDatePicker(
                              cancelText: 'Annulla',
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (selectedDate != null) {
                              var selectedHour = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              if (selectedHour != null) {
                                setState(() {
                                  event.end = DateTime(
                                      selectedDate!.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedHour.hour,
                                      selectedHour.minute);
                                });
                              } else {
                                selectedDate = DateTime.now();
                              }
                            }
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${event.end.day} ${months[event.end.month]} at ${event.end.hour}:${event.end.minute >= 10 ? event.end.minute : "0${event.end.minute}"}',
                                style: GoogleFonts.poppins(),
                              )))
                    ])),
          ])),
          InkWell(
              onTap: () async {
                final managerProvider =
                    Provider.of<UserProvider>(context, listen: false);
                managerProvider.createEvent(event);
                final eventProvider =
                    Provider.of<EventProvider>(context, listen: false);
                eventProvider.getEventsByEntity(
                    managerProvider.manager.managedEntity.id);
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.bottomCenter,
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Text("Create Event",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold))))
        ]));
  }
}
