import 'package:flutter/material.dart';
import 'carbonmap.dart';
import 'garbageCollection.dart';

class AwarenessPage extends StatefulWidget {
  @override
  _AwarenessPageState createState() => _AwarenessPageState();
}

class _AwarenessPageState extends State<AwarenessPage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _page = 0;
    _pageController = PageController();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int index) {
    setState(() {
      this._page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF013220),
      body: PageView(
        children: [
          FootPrintMap(),
          GarbageCollectionMap(),
        ],
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF013220),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.data_usage,
                color: Color(0xFF99ddff),
              ),
              title: Text(
                " Carbon Emission Stats",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF99ddff),
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
                color: Color(0xFF99ddff),
              ),
              title: Text(
                " Garbage Collection Spots",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF99ddff),
                ),
              ),
            ),
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        ),
      ),
    );
  }
}

class MapData {
  static var mapURL =
      "https://api.maptiler.com/maps/hybrid/{z}/{x}/{y}.jpg?key=nwtiEdWxMbPaEwFX4fiG";
  static double mapZoom = 14.3;

  static double latitude = 15.2865981;
  static double longitude = 73.9689665;
}

class ServerData {
  static String serverLoc = "http://192.168.1.33/Hackocracy";
  static String carbonDataURL =
      "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.json";
}
