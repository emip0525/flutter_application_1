// Student ID: 2415051011 - Miftah Fadilatus Sakhila

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/course_screen.dart';
import 'package:flutter_application_1/screens/favorites_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedTab = 0;

  final List<Widget> _pages = const [
    CourseScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          if (screenWidth >= 600)
            NavigationRail(
              selectedIndex: _selectedTab,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              indicatorColor: Colors.teal.shade100,
              selectedIconTheme: IconThemeData(color: Colors.teal.shade800),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.class_outlined),
                  selectedIcon: Icon(Icons.class_),
                  label: Text('Katalog'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_outline),
                  selectedIcon: Icon(Icons.bookmark),
                  label: Text('Favorit'),
                ),
              ],
            ),
          if (screenWidth >= 600) const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _pages[_selectedTab]),
        ],
      ),
      bottomNavigationBar: screenWidth < 600
          ? BottomNavigationBar(
              currentIndex: _selectedTab,
              selectedItemColor: Colors.teal.shade800,
              unselectedItemColor: Colors.grey.shade600,
              onTap: (int index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.class_outlined),
                  activeIcon: Icon(Icons.class_),
                  label: 'Katalog',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark_outline),
                  activeIcon: Icon(Icons.bookmark),
                  label: 'Favorit',
                ),
              ],
            )
          : null,
    );
  }
}