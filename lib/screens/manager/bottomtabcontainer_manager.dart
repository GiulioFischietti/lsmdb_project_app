import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/manager/create_edit_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/screens/manager/analytics.dart';
import 'package:eventi_in_zona/screens/manager/home_screen.dart';
import 'package:eventi_in_zona/screens/manager/profile.dart';
import 'package:provider/provider.dart';

class BottomTabContainerManager extends StatefulWidget {
  int initialIndex = 0;
  BottomTabContainerManager({
    required this.initialIndex,
    Key? key,
  }) : super(key: key);

  @override
  _BottomTabContainerManagerState createState() =>
      _BottomTabContainerManagerState();
}

String name = "";
String image = "";

class _BottomTabContainerManagerState extends State<BottomTabContainerManager> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Scaffold(body: HomeManager()),
    // Scaffold(body: ProductsByCategory()),
    Scaffold(body: Analytics()),
    // Scaffold(body: Cart()),
    Scaffold(body: Profile()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _onItemTapped(widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          floatingActionButton: _selectedIndex == 0
              ? FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      final userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      Event event = Event({});
                      if (userProvider.manager.managedEntity.type == "club") {
                        event = Event({
                          "organizers": [
                            userProvider.manager.managedEntity.toJson()
                          ],
                          "club": userProvider.manager.managedEntity.toJson(),
                          "address": userProvider.manager.managedEntity.address,
                          "location": userProvider
                              .manager.managedEntity.location
                              .toJson(),
                        });
                      }
                      if (userProvider.manager.managedEntity.type ==
                          "organizer") {
                        event = Event({
                          "organizers": [
                            userProvider.manager.managedEntity.toJson()
                          ],
                        });
                      }
                      if (userProvider.manager.managedEntity.type == "artist") {
                        event = Event({
                          "artists": [
                            userProvider.manager.managedEntity.toJson()
                          ],
                        });
                      }
                      return CreateEvent(
                        editMode: false,
                        event: event,
                      );
                    }));
                  },
                  child: const Icon(Icons.add, color: Colors.white))
              : null,
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.grey[100],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                label: "Analytics",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outlined), label: "Profile"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ));
  }
}
