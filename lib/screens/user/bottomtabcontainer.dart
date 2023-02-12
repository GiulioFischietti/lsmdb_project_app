import 'package:eventi_in_zona/screens/user/discover.dart';
import 'package:eventi_in_zona/screens/user/friends.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/screens/user/profile.dart';

import 'Home.dart';

class BottomTabContainer extends StatefulWidget {
  int initialIndex = 0;
  BottomTabContainer({
    required this.initialIndex,
    Key? key,
  }) : super(key: key);

  @override
  _BottomTabContainerState createState() => _BottomTabContainerState();
}

String name = "";
String image = "";

class _BottomTabContainerState extends State<BottomTabContainer> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    // Scaffold(body: NearActivities()),
    Scaffold(body: Home()),
    Scaffold(body: TopRated()),
    Scaffold(body: Friends()),
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
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            unselectedItemColor: Colors.black,
            backgroundColor: Colors.grey[100],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_events), label: "Top Rated"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_add_alt_outlined), label: "Friends"),
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
