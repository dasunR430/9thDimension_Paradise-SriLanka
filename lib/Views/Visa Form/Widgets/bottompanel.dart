import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

import '../Sections/passport_and_photo_page.dart';
import '../Sections/personal_details_page.dart';
import '../Sections/supporting_information_page.dart';
import '../Sections/contact_details_page.dart';
import '../Sections/travel_history.dart';

class BottomPanel extends StatelessWidget {
  final VisaApplicationController controller;
  final String applicantType;
  final String visaSelectionType;

  const BottomPanel(
      {super.key,
      required this.controller,
      required this.applicantType,
      required this.visaSelectionType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height -
              100, // Adjust height dynamically
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.pageController,
            onPageChanged: (int page) {
              controller.currentPage.value = page;
            },
            children: [
              PassportAndPhotoScreen(
                controller: controller,
                applicantType: applicantType,
                visaSelectionType: visaSelectionType,
              ),
              PersonalDetailsScreen(controller: controller),
              ContactDetailsScreen(controller: controller),
              SupportingDocumentsPage(controller: controller),
              TravelHistoryScreen(
                  controller: controller,
                  applicantType: applicantType,
                  visaSelectionType: visaSelectionType),
            ],
          ),
        ),
      ],
    );
  }
}
