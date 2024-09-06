import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'CircularIndicator.dart';
import 'custome_dotted_line.dart';

class SectionIndicator extends StatelessWidget {
  final VisaApplicationController sectionController = Get.put(VisaApplicationController());

  SectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIndicator(status: sectionController.getStatus(1), number: 1),
                const CustomDottedLine(),
                CircularIndicator(status: sectionController.getStatus(2), number: 2),
                const CustomDottedLine(),
                CircularIndicator(status: sectionController.getStatus(3), number: 3),
                const CustomDottedLine(),
                CircularIndicator(status: sectionController.getStatus(4), number: 4),
                const CustomDottedLine(),
                CircularIndicator(status: sectionController.getStatus(5), number: 5),
              ],
            ),
            const SizedBox(height: 20),
          ],
    );
  }
}


