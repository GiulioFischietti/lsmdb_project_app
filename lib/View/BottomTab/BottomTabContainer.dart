import 'package:project_app/View/BottomTab/Animatedlist.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Notifications.dart';
import 'Search.dart';
// ignore_for_file: file_names

class BottomTabContainer extends StatefulWidget {
  const BottomTabContainer({Key key}) : super(key: key);

  @override
  _BottomTabContainerState createState() => _BottomTabContainerState();
}

/// This is the private State class that goes with BottomTabContainer.
class _BottomTabContainerState extends State<BottomTabContainer> {
  int _selectedIndex = 0;
  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Search(),
    Notifications()
    // AnimatedListSample(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      if (_selectedIndex > 0) {
        setState(() {
          _selectedIndex = 0;
        });
      } else {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }, child:
        Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Scaffold(
        // backgroundColor: Color(0xFF222222),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: languageProvider.text.needfy.search,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: languageProvider.text.profileText.notifications),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey[300],
          selectedItemColor: Color(0xFFf9b701),
          onTap: _onItemTapped,
        ),
      );
    }));
  }
}
