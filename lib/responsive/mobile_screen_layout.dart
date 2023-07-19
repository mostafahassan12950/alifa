// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../constants/constant.dart';
import '../screens/search/Search_pets.dart';
import '../screens/add_POST/add.dart';
import '../screens/home.dart';
import '../screens/pets&solid.dart';
import '../screens/settings.dart';

class mobile_screen_layout extends StatefulWidget {
  const mobile_screen_layout({Key? key}) : super(key: key);

  @override
  State<mobile_screen_layout> createState() => _HMState();
}

class _HMState extends State<mobile_screen_layout> {
  @override
  Widget build(BuildContext context) {
    final PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        Home(),
         Search(),
        Add(),
        MY(),
        settings( ),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          activeColorPrimary: Color.fromARGB(255, 15, 15, 17),
          inactiveColorPrimary: Color.fromARGB(255, 249, 249, 252),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          activeColorPrimary: Color.fromARGB(255, 15, 15, 17),
          inactiveColorPrimary: Color.fromARGB(255, 249, 249, 252),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.add, color: color8),
          activeColorPrimary: Color.fromARGB(251, 214, 134, 1),
          inactiveColorPrimary: Color.fromARGB(255, 249, 249, 252),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.person),
          activeColorPrimary: Color.fromARGB(255, 15, 15, 17),
          inactiveColorPrimary: Color.fromARGB(255, 249, 249, 252),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          activeColorPrimary: Color.fromARGB(255, 15, 15, 17),
          inactiveColorPrimary: Color.fromARGB(255, 249, 249, 252),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: color8, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Color.fromARGB(251, 214, 134, 1),
      ),
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style16, // Choose the nav bar style with this property.
    );
  }
}
