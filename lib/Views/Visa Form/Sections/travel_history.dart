import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/travel_country_controller.dart';
import '../../../Controllers/visa_application_controller.dart';
import '../../../Models/travelled_country.dart';
import '../../Applicants Screen/applicants_screen.dart';
import '../Widgets/travel_history_card.dart';

class TravelHistoryScreen extends StatelessWidget {
  final TravelledCountryController controller = Get.put(TravelledCountryController());
  VisaApplicationController sectionController = VisaApplicationController.instance;

  TravelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15,),
            const Text(
              '5. Travel History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Upload supporting document (e.g., passport, visa, etc.)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Supported formats: JPG, PNG, PDF',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            TextButton(
              onPressed: () {
                controller.addTravelledCountry(
                  TravelledCountry(
                    country: '',
                    entryDate: DateTime.now(),
                    purpose: '',
                  ),
                );
              },
              child: const Text(
                '+ Add Travel Info',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(() {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,  // This prevents infinite height issues
                itemCount: controller.travelledCountryList.length,
                itemBuilder: (context, index) {
                  final travelledCountry = controller.travelledCountryList[index];
                  return TravelledCountryCard(
                    travelledCountry: travelledCountry,
                    onRemove: () => controller.removeTravelledCountry(index),
                    onUploadFile: (file) {
                      controller.travelledCountryList[index].attachment = file;
                    },
                  );
                },
              );
            }),
            const SizedBox(height: 20), // Add space before the button
            ElevatedButton(
              onPressed: () {
                //print(sectionController.birthdayController.text);
                sectionController.createVisaApplicant();
                Get.snackbar('Success', 'Visa Applicant added');
                Get.back();
                // Perform the "finish" action
                // You can either submit the data or navigate to the next page
                // For example, if you want to submit:
                // if (controller.travelledCountryList.isEmpty) {
                //   Get.snackbar('Error', 'Please add at least one travel history.');
                // } else {
                //   // Proceed to the next action or submit
                //   // For example, navigate to another page or submit the data
                //   Get.snackbar('Success', 'Travel history saved successfully!');
                // }

              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14), // Button height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Finish'),
            ),
            const SizedBox(height: 20), // Add space at the bottom
          ],
        ),
      ),
    );
  }
}
