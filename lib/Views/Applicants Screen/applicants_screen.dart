import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/entity.dart';

import '../../Controllers/applicants_controller.dart';
import 'Widgets/add_applicant_button.dart';
import 'Widgets/visa_applicant_card.dart';

class ApplicantsScreen extends StatelessWidget {
  ApplicantsScreen(this.entity, this.isGroup, {super.key}){
    Get.lazyPut(()=>ApplicantController(entity));
    controller = ApplicantController.instance;
  }

  final ApplicantEntity entity;
  final bool isGroup;
  late final ApplicantController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Applicants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ApplicantController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade100, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Main Applicant", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                      const SizedBox(height: 10),
                      controller.applicantEntity.mainVisaApplicant != null
                          ? VisaApplicantCard(
                        applicant: controller.applicantEntity.mainVisaApplicant,
                        onRemove: () {
                        },
                      )
                          : AddApplicantButton(
                        onPressed: () {
                          controller.addMainApplicant();
                        },
                        label: "+ Add Main Applicant",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                isGroup ? Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade100, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Other Applicants", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                      const SizedBox(height: 10),
                      if (controller.applicantEntity.mainVisaApplicant != null)
                        ...?controller.applicantEntity.entityMembers?.map(
                              (entityMember) => VisaApplicantCard(
                            applicant: entityMember.applicant,
                            onRemove: () => controller.removeApplicant(entityMember),
                          ),
                        )
                      else
                        AddApplicantButton(
                          onPressed: () {
                            controller.addOtherApplicant();
                          },
                          label: "+ Add another Applicant",
                        ),
                    ],
                  ),
                ): const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
