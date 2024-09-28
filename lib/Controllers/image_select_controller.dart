import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Controllers/applicants_controller.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
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
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageF = File(pickedFile.path);
      imageFile.value = imageF; // Update the image file immediately
      sectionController.faceImage.value.setImageFile(imageF);

      // Determine if the applicant is main or other
      bool isMainApplicant = applicantsController.applicantType == "Main";

      if (isMainApplicant) {
        applicantsController.updateMainApplicant(
          applicantsController.applicantEntity.mainVisaApplicant!.copyWith(
                passportPhotoURL: imageF.path,
              )
        );
      } else {

        final currentApplicant = applicantsController
            .applicantEntity.entityMembers?.lastOrNull?.applicant;
        if (currentApplicant != null) {
          VisaApplicant updatedApplicant = currentApplicant.copyWith(
            passportPhotoURL: imageFile.value!.path,
          );
          currentApplicant.update(updatedApplicant);
        } else {

          _showError('current applicant found');
        }
        }

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

    // Determine if the applicant is main or other
    bool isMainApplicant = applicantsController.applicantType == "Main";

    if (isMainApplicant) {
      final currentApplicant =
          applicantsController.applicantEntity.mainVisaApplicant;
      if (currentApplicant != null) {
        applicantsController.updateMainApplicant(
          currentApplicant.copyWith(passportPhotoURL: null),
        );
      }
    } else {
      // For other applicants, update the current applicant in the entity members list
      final currentApplicant = applicantsController
          .applicantEntity.entityMembers?.lastOrNull?.applicant;
      if (currentApplicant != null) {
        VisaApplicant updatedApplicant =
            currentApplicant.copyWith(passportPhotoURL: null);
        currentApplicant.update(updatedApplicant);
      }
    }
  }
}
