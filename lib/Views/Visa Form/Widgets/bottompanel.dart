import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

import '../Sections/passport_and_photo_page.dart';
import '../Sections/personal_details_page.dart';
import '../Sections/supporting_information_page.dart';
import '../Sections/contact_details_page.dart';
import '../Sections/travel_history.dart';

class BottomPanel extends StatelessWidget {
  const BottomPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final VisaApplicationController controller = VisaApplicationController.instance;

    return Column(
        children: [
          SizedBox(
            height: 1500,
            child: PageView(
              //physics: NeverScrollableScrollPhysics(),
              controller: controller.pageController,
              onPageChanged: (int page) {
                controller.onPageChange(page);
              },
              children: [
                PassportAndPhotoScreen(),
                PersonalDetailsScreen(),
                ContactDetailsScreen(),
                SupportingDocumentsPage(),
                TravelHistoryScreen()
              ],
            ),
          ),
        ],
      );
    }
}
