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
    bool isDark = HelperFunctions.isDarkMode(context);
    return DefaultTabController(
        length: tabs.length,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TabBar(
            tabs: tabs,
            isScrollable: true,
            indicatorColor: Colors.blueAccent,
            labelColor: isDark ? Colors.white : Colors.black,
            tabAlignment: TabAlignment.start,
          ),
          Container(
            height: HelperFunctions.screenHeight() -
                DeviceUtils.getAppBarHeight() -
                DeviceUtils.getStatusBarHeight() -
                80,
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "My Details",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "First Name",
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              Text(
                                "John",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
                Center(),
                Center()
              ],
            ),
          )
        ]));
  }
}
