import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Portal/visa_portal_screen.dart';

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
                                  // Refresh the screen after removing the main applicant
                                  controller.update();
                                },
                                applicantType: "Main",
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
                                  onRemove: () {
                                    controller.removeApplicant(applicant);
                                    controller.update();
                                  },
                                  applicantType: "Other",
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
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Add your logic here to save the data into the database
                        if (controller.applicantEntity.mainVisaApplicant ==
                            null) {
                          // Show an error message if the main applicant is not set
                          Get.snackbar('Error',
                              'Main applicant is required before submitting.');
                          return;
                        }

                        if (controller.applicantEntity.entityMembers == null ||
                            controller.applicantEntity.entityMembers!.isEmpty) {
                          // Show an error message if there are no other applicants
                          Get.snackbar('Error',
                              'At least one other applicant is required before submitting.');
                          return;
                        }

                        await controller.saveApplicantToDatabase();
                        await controller.processRecomendationModel();
                        Get.to(() => VisaPortalScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
  runApp(GetMaterialApp(
    home: ApplicantsScreen(),
  ));
}
