import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Views/Gallery/gallery_screen.dart';
import 'package:paradise_sri_lanka/Views/Home/home_screen.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  void onDestinationChanged(int index) {
    selectedIndex.value = index;
  }

  List<Widget> screens = [
    HomeScreen(),
    const GalleryPage(),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Events", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text("Coming Soon"),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Trips", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text("Coming Soon"),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bookings", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          Text("Coming Soon"),
        ],
      ),
    ),
  ];

  List<String> titles = [
    "Home",
    "gallery",
    "Events",
    "Trips",
    "Bookings",
  ];
}