import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:engineering_hub/pages/screens/home.dart';
import 'package:engineering_hub/pages/screens/message.dart';
import 'package:engineering_hub/pages/screens/notes.dart';
import 'package:flutter/material.dart';

class BottomNavigationMenu extends StatefulWidget {
  const BottomNavigationMenu({super.key});

  @override
  State<BottomNavigationMenu> createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  List<IconData> iconsList = [Icons.group, Icons.article_rounded, Icons.home];
  List<Widget> page = const [MessagePage(), NotesPage(), HomePage()];
  int activePage = 0;
  EasyAppController appCtrl = EasyAppController(
    intialBody: EasyBody(
      child: const MessagePage(),
      title: const Text('Message Page'),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
      body: page[activePage],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        height: 65,
        iconSize: 40,
        elevation: 50,
        scaleFactor: 1,
        icons: iconsList,
        leftCornerRadius: 15,
        rightCornerRadius: 15,
        activeIndex: activePage,
        gapLocation: GapLocation.none,
        splashSpeedInMilliseconds: 400,
        splashColor: Theme.of(context).iconTheme.color,
        activeColor: Theme.of(context).iconTheme.color,
        backgroundColor: Theme.of(context).primaryColor,
        onTap: (index) => setState(() => activePage = index),
        inactiveColor: Theme.of(context).hoverColor.withOpacity(0.15),
      ),
    );
  }
}
