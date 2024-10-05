import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'CircularIndicator.dart';
import 'custome_dotted_line.dart';

class SectionIndicator extends StatelessWidget {
  final VisaApplicationController controller = Get.find();

  SectionIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularIndicator(
                    status: controller.getStatus(0).obs, number: 1),
                const CustomDottedLine(),
                CircularIndicator(
                    status: controller.getStatus(1).obs, number: 2),
                const CustomDottedLine(),
                CircularIndicator(
                    status: controller.getStatus(2).obs, number: 3),
                const CustomDottedLine(),
                CircularIndicator(
                    status: controller.getStatus(3).obs, number: 4),
                const CustomDottedLine(),
                CircularIndicator(
                    status: controller.getStatus(4).obs, number: 5),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
