import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/home_controller.dart';

import 'Widgets/hero_section.dart';
import 'Widgets/passes_widget.dart';
import 'Widgets/tools_widget.dart';
import 'Widgets/trending_widget.dart';
import 'Widgets/visa_widget.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeroSection(),
            TrendingWidget(),
            VisaWidget(),
            PassesWidget(),
            ToolsWidget(),
          ],
        ),
      ),

    );
  }
}