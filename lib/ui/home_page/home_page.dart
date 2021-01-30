import '../generation_page/generation_page.dart';
import '../intensity_page/intensity_page.dart';
import '../reminder_page/reminder_page.dart';
import '../settings_page/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    IntensityPage(),
    GenerationPage(),
    ReminderPage(),
    SettingsPage(),
  ];

  void _onBottomNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onBottomNavBarTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Intesity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart),
              label: 'Generation',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Reminders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
