import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Controllers/applicants_controller.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:path/path.dart';
import 'visa_application_controller.dart';

class ImageSelectController extends GetxController {
  var imageFile = Rxn<File>();
  final ApplicantController applicantsController =
      Get.find<ApplicantController>();

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> pickImage(VisaApplicationController sectionController) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageF = File(pickedFile.path);
      imageFile.value = imageF; // Update the image file immediately
      sectionController.faceImage.value.setImageFile(imageF);

      sectionController.faceImage.value.setImageFile(imageF);
      applicantsController.updateMainApplicant(
        applicantsController.applicantEntity.mainVisaApplicant?.copyWith(
              passportPhotoURL: imageF.path,
            ) ??
            VisaApplicant(
              passportPhotoURL: imageF.path,
              passportBioPageURL: '',
              // Initialize other required fields
              passportNumber: '',
              passportExpiryDate: DateTime.now(),
              surname: '',
              givenNames: '',
              dateOfBirth: DateTime.now(),
              placeOfBirth: '',
              nationality: '',
              gender: '',
              phoneNumberCountryCode: '',
              phoneNumber: '',
              whatsAppNumberCountryCode: '',
              whatsAppNumber: '',
              homeAddress: '',
              email: '',
              emergencyContactPersonName: '',
              emergencyContactPersonPhoneCountryCode: '',
              emergencyContactPersonPhone: '',
            ),
      );
    } else {
      _showError('No image selected');
    }
  }

  void resetImage() {
    imageFile.value = null;

    // Reset the image in the VisaApplicationController
    final sectionController = Get.find<VisaApplicationController>();
    sectionController.passportImage.value.setImageFile(null);
    sectionController.passportImage.value.setImageBytes(null);
    sectionController.faceImage.value.setImageFile(null);
    sectionController.faceImage.value.setImageBytes(null);
  }
}
