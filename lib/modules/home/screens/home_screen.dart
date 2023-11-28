import 'package:flutter/material.dart';
import 'pages/courses_page.dart';
import 'pages/home_page.dart';
import 'pages/money_page.dart';
import 'pages/notification_page.dart';
import 'pages/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> homeScreenPages = <Widget>[
    HomePage(),
    CoursesPage(),
    MoneyChangerPage(),
    NotificationPage(),
    ProfilePage(),
  ];

  static List<SalomonBottomBarItem> navBottomItem = <SalomonBottomBarItem>[
    SalomonBottomBarItem(
      icon: const Icon(Icons.home_rounded),
      title: const Text('Home'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.book_rounded),
      title: const Text('Courses'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.monetization_on_rounded),
      title: const Text('Money Changer'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.notifications_rounded),
      title: const Text('Notifications'),
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.person_rounded),
      title: const Text('Profile'),
    ),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenPages.elementAt(_selectedIndex),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) => onTapNav(index),
        items: navBottomItem,
      ),
    );
  }
}
