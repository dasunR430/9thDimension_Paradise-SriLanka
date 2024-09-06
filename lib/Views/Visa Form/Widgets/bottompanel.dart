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
    final sectionController = Get.put(VisaApplicationController());

    return Column(
        children: [
          Container(
            height: 1500,
            child: PageView(
              //physics: NeverScrollableScrollPhysics(),
              controller: PageController(),
              onPageChanged: (int page) {
                sectionController.currentPage.value = page;
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
