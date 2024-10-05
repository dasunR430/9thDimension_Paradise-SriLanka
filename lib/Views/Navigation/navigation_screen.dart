import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:paradise_sri_lanka/Controllers/navigation_controller.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:paradise_sri_lanka/Views/Gallery/gallery_screen.dart';

import 'Widgets/custom_app_bar.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});

  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.onDestinationChanged,
          elevation: 0,
          backgroundColor: isDark
              ? Colors.white.withOpacity(0.01)
              : Colors.black.withOpacity(0.02),
          indicatorColor: Colors.blue.withOpacity(0.7),
          destinations: const [
            NavigationDestination(
                icon: Icon(Iconsax.home), label: "Home"),
            NavigationDestination(
                icon: Icon(Iconsax.gallery), label: "Gallery"),
            NavigationDestination(
                icon: Icon(Iconsax.calendar), label: "Events"),
            NavigationDestination(
                icon: Icon(Iconsax.map_1), label: "Trips"),
            NavigationDestination(
                icon: Icon(Iconsax.book), label: "Bookings"),
          ],
        ),
      ),
    );
  }
}
