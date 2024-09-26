import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/image_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import '../Widgets/image_upload_widget.dart';

class PassportAndPhotoPage extends StatelessWidget {
  final ImageUploadController passportBioPageController =
      ImageUploadController();
  final ImageUploadController passportPhotoController = ImageUploadController();
  final VisaApplicationController sectionController =
      VisaApplicationController.instance;

  PassportAndPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
