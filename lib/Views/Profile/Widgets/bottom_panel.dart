import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Utils/device/device_utility.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

class BottomPanel extends StatelessWidget {
  BottomPanel({super.key});

  final List<Tab> tabs = [
    const Tab(text: "Details"),
    const Tab(text: "Visited Places"),
    const Tab(text: "My Collection"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabs: tabs,
            isScrollable: true,
            indicatorColor: Colors.blueAccent,
            labelColor: Colors.black,
            tabAlignment: TabAlignment.start,
          ),
          Container(
            color: Colors.red,
            height: HelperFunctions.screenHeight()-DeviceUtils.getAppBarHeight()-DeviceUtils.getStatusBarHeight() -80,
            child: TabBarView(children: [
              Center(
                child: Text("Details"),
              ),
              Center(
                child: Text("Visited Places"),
              ),
              Center(
                child: Text("My Collection"),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
