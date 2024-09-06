import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/image_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import '../Widgets/image_upload_widget.dart';

class PassportAndPhotoScreen extends StatelessWidget {

  ImageUploadController passportBioPageController = ImageUploadController();
  ImageUploadController passportPhotoController = ImageUploadController();
  VisaApplicationController sectionController = VisaApplicationController.instance;

  PassportAndPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Passport & Photo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // Passport Upload Widget
            ImageUploadWidget(
              isRequired: true,
              instructionText: 'Upload a photo of your Passport Bio Page',
              controller: passportBioPageController,
              questionText: 'Passport Bio Page',
            ),

            const SizedBox(height: 40),

            ImageUploadWidget(
              isRequired: true,
              instructionText: 'Upload a passport-type photo',
              controller: passportPhotoController,
              questionText: 'Passport-type photo',
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (sectionController.currentPage.value > 0)
                    ElevatedButton(
                      onPressed: sectionController.previousPage,
                      child: const Text('Back'),
                    ),
                  if (sectionController.currentPage.value < 3)
                    ElevatedButton(
                      onPressed: sectionController.nextPage,
                      child: const Text('Next'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
