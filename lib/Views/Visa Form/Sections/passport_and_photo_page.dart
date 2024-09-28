import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/error_display_controller.dart';
import 'package:paradise_sri_lanka/Controllers/image_select_controller.dart';
import 'package:paradise_sri_lanka/Controllers/image_upload_controller.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/Widgets/image_select_widget.dart';
import '../Widgets/image_upload_widget.dart';
import '../Widgets/upload_progress_overlay.dart';
import '../../../Controllers/applicants_controller.dart';

class PassportAndPhotoScreen extends StatefulWidget {
  final VisaApplicationController controller;
  final String applicantType;
  final String visaSelectionType;
  const PassportAndPhotoScreen({
    super.key,
    required this.controller,
    required this.applicantType,
    required this.visaSelectionType,
  });

  @override
  _PassportAndPhotoScreenState createState() => _PassportAndPhotoScreenState();
}

class _PassportAndPhotoScreenState extends State<PassportAndPhotoScreen> {
  late final VisaApplicationController sectionController;
  late final ImageUploadController passportBioPageController;
  late final ImageSelectController passportPhotoController;
  final ErrorController errorController = ErrorController();
  final ApplicantController applicantController =
      Get.find<ApplicantController>();

  @override
  void initState() {
    super.initState();
    sectionController = Get.find<VisaApplicationController>();
    passportBioPageController = Get.find<ImageUploadController>();
    passportPhotoController = Get.find<ImageSelectController>();
  }

  void setup() {
    applicantController.setApplicantType(widget.applicantType);
    applicantController.setVisaSelectionType(widget.visaSelectionType);
  }

  @override
  Widget build(BuildContext context) {
    setup();
    return Stack(
      children: [
        SingleChildScrollView(
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
                  type: 'PassportBioPage',
                  section: sectionController,
                  passportPhotoController: passportPhotoController,
                ),

                const SizedBox(height: 40),

                ImageSelectWidget(
                  isRequired: true,
                  instructionText: 'Upload a passport-type photo',
                  controller: passportPhotoController,
                  questionText: 'Passport-type photo',
                  type: 'PassportPhoto',
                  section: sectionController,
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
        ),
        UploadProgressOverlay(controller: sectionController),
      ],
    );
  }
}
