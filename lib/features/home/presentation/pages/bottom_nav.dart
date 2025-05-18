import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamha/constants/images.dart';
import 'package:lamha/features/home/presentation/pages/home_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
 final List<Widget> pages= [HomeView(), HomeView(), HomeView(), HomeView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: <Widget>[
          Image.asset(Assets.imagesHome, width: 35, height: 35),
          Image.asset(Assets.imagesScoreRemovebgPreview, width: 35, height: 35),
          Icon(Icons.person, size: 30),
          Icon(Icons.group_sharp, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.blueAccent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page],
    );
  }
}
