import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';

import '../../Controllers/applicants_controller.dart';
import 'Widgets/add_applicant_button.dart';
import 'Widgets/visa_applicant_card.dart';

class ApplicantsScreen extends StatelessWidget {
  const ApplicantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Applicants'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetBuilder<ApplicantController>(
            init: ApplicantController(),
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade100, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Main Applicant",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        const SizedBox(height: 10),
                        controller.applicantEntity.mainVisaApplicant != null
                            ? VisaApplicantCard(
                                applicant: controller
                                    .applicantEntity.mainVisaApplicant!,
                                onRemove: () {
                                  // Optionally, add a method to remove main applicant
                                  controller.removeMainApplicant();
                                },
                              )
                            : AddApplicantButton(
                                onPressed: () {
                                  // Add your logic here to open a dialog or navigate to add a main applicant
                                  controller.addMainApplicant();
                                },
                                label: "+ Add Main Applicant",
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade100, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Other Applicants",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                        const SizedBox(height: 10),
                        if (controller.applicantEntity.mainVisaApplicant !=
                                null &&
                            controller
                                .applicantEntity.entityMembers!.isNotEmpty)
                          // Access entityMembers to get the list of other applicants
                          ...controller.applicantEntity.entityMembers!
                              .map(
                                (applicant) => VisaApplicantCard(
                                  applicant: applicant.applicant,
                                  onRemove: () =>
                                      controller.removeApplicant(applicant),
                                ),
                              )
                              .toList(),
                        AddApplicantButton(
                          onPressed: () {
                            controller.addOtherApplicant();
                          },
                          label: "+ Add Other Applicant",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  Get.put(ApplicantController());
  Get.put(VisaApplicationController());
  runApp(GetMaterialApp(
    home: ApplicantsScreen(),
  ));
}
