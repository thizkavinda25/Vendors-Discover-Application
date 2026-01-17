import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vendors_discover/screens/bookmarks.dart';
import 'package:vendors_discover/screens/favorites_screen.dart';
import 'package:vendors_discover/screens/home_scree.dart';
import 'package:vendors_discover/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final items = [
    Icon(Icons.home, size: 30),
    Icon(Icons.favorite, size: 30),
    Icon(Icons.bookmark, size: 30),
    Icon(Icons.person, size: 30),
  ];
  final screens = [
    HomeScree(),
    FavoritesScreen(),
    Bookmarks(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: Theme(
        data: ThemeData().copyWith(
          iconTheme: IconThemeData(color: Colors.white),
        ),
        child: SafeArea(
          top: false,
          child: CurvedNavigationBar(
            index: index,
            items: items,
            height: 60,
            animationDuration: Duration(milliseconds: 200),
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.pink,
            color: Colors.black,
            onTap: (index) => setState(() {
              this.index = index;
            }),
          ),
        ),
      ),
    );
  }
}
