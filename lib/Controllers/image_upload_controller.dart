import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:paradise_sri_lanka/Controllers/image_select_controller.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'visa_application_controller.dart';
import 'applicants_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../Models/visa_applicant.dart';

class ImageUploadController extends GetxController {
  var imageFile = Rxn<File>();
  Uint8List? extractedFaceBytes;
  Map<String, dynamic>? passportData;
  var isLoading = false.obs;

  final ApplicantController applicantsController =
      Get.find<ApplicantController>();

  Future<File> uint8ListToFile(Uint8List bytes, String fileName) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/$fileName');
    return await file.writeAsBytes(bytes);
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  String formatDateOfBirth(String? dateOfBirth) {
    if (dateOfBirth == null || dateOfBirth.length != 6) {
      return "";
    }

    try {
      String yearPart = dateOfBirth.substring(0, 2);
      String monthPart = dateOfBirth.substring(2, 4);
      String dayPart = dateOfBirth.substring(4, 6);

      int year = int.parse(yearPart);
      if (year <= 24) {
        year += 2000;
      } else {
        year += 1900;
      }

      int month = int.parse(monthPart);
      int day = int.parse(dayPart);
      if (month < 1 || month > 12 || day < 1 || day > 31) {
        return "";
      }

      return "$year-$monthPart-$dayPart";
    } catch (e) {
      return "";
    }
  }

  void _updateControllers(VisaApplicationController sectionController) {
    if (passportData != null) {
      sectionController.surnameController.value.text =
          passportData!['surname'] ?? '';
      sectionController.otherNamesController.value.text =
          passportData!['given_names'] ?? '';
      sectionController.birthdayController.value.text =
          formatDateOfBirth(passportData!['date_of_birth'] ?? '');
      // sectionController.placeOfBirthController.value.text =
      //     passportData!['place_of_birth'] ?? '';
      String gen = passportData!['gender'] ?? '';
      sectionController.genderController.value.text =
          (gen == "M" || gen == "F") ? gen : "";
      sectionController.nationalityController.value.text =
          passportData!['nationality'] ?? '';
      sectionController.passportNumberController.value.text =
          passportData!['passport_number'] ?? '';
      sectionController.passportExpiryDateController.value.text =
          formatDateOfBirth(passportData!['passport_expiry_date'] ?? '');
      // Occupation and Marital Status might not be available in passport data

      // Update the ApplicantController with image URLs if applicable
      if (imageFile.value != null) {
        // Assuming you have a method to upload the file and get a URL
        // For demonstration, we'll set the local path
        bool isMainApplicant = applicantsController.applicantType == "Main";
        if (isMainApplicant) {
          applicantsController.updateMainApplicant(
            applicantsController.applicantEntity.mainVisaApplicant!.copyWith(
                  passportPhotoURL: imageFile.value!.path,
                  passportBioPageURL:
                      passportData!['passport_biopage_url'] )

          );
        } else {
          final currentApplicant = applicantsController
              .applicantEntity.entityMembers?.lastOrNull?.applicant;
          if (currentApplicant != null) {
            VisaApplicant updatedApplicant = currentApplicant.copyWith(
              passportPhotoURL: imageFile.value!.path,
              passportBioPageURL: passportData!['passport_biopage_url'] ?? '',
            );
            currentApplicant.update(updatedApplicant);
          } else {

            _showError('current applicant found');
          }
        }
      }
    }
  }

  Future<void> _sendImageToServer(
      File imageFile, VisaApplicationController sectionController) async {
    const url = 'http://13.51.159.48:9000/detect-passport';

    try {
      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({
        "file": await dio.MultipartFile.fromFile(imageFile.path,
            filename: "PassPortBioPage.jpg"),
      });

      dio.Dio dioInstance = dio.Dio();
      var response = await dioInstance.post(
        url,
        data: formData,
        options: dio.Options(
          sendTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
          responseType: dio.ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        String contentType = response.headers.value('content-type') ?? '';
        if (contentType.contains('image/jpeg')) {
          extractedFaceBytes = Uint8List.fromList(response.data);
          String passportInfoStr =
              response.headers.value('passport_info') ?? '{}';
          passportData = json.decode(passportInfoStr.replaceAll("'", '"'));
        } else if (contentType.contains('application/json')) {
          Map<String, dynamic> jsonResponse =
              json.decode(utf8.decode(response.data));
          passportData = jsonResponse['passport_info'];
          extractedFaceBytes = null;
        }
        _updateControllers(sectionController);
      } else {
        _showError(
            'Server error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      _showError('Error sending image to server: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickAndUploadImage(VisaApplicationController sectionController,
      ImageSelectController passportPhotoController) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageF = File(pickedFile.path);
      imageFile.value = imageF; // Update the image file immediately

      sectionController.passportImage.value.setImageFile(imageF);
      await _sendImageToServer(imageF, sectionController);

      if (extractedFaceBytes != null) {
        File faceFile =
            await uint8ListToFile(extractedFaceBytes!, 'extracted_face.png');
        sectionController.faceImage.value.setImageFile(faceFile);
        sectionController.faceImage.value.setImageBytes(extractedFaceBytes);

        // Determine if the applicant is main or other
        bool isMainApplicant = applicantsController.applicantType == "Main";

        if (isMainApplicant) {
          applicantsController.updateMainApplicant(
            applicantsController.applicantEntity.mainVisaApplicant!.copyWith(
                  passportPhotoURL: faceFile.path,
                  passportBioPageURL: imageF.path,
                )
          );
          //applicantsController.applicantEntity.entityMembers?.lastOrNull.relation = con;
        } else {
          final currentApplicant = applicantsController
              .applicantEntity.entityMembers?.lastOrNull?.applicant;
          if (currentApplicant != null) {
            VisaApplicant updatedApplicant = currentApplicant.copyWith(
              passportPhotoURL: imageFile.value!.path,
              passportBioPageURL: passportData!['passport_biopage_url'] ?? '',
            );
            currentApplicant.update(updatedApplicant);
          } else {

            _showError('current applicant found');
          }

        }

        passportPhotoController.imageFile.value =
            faceFile; // Update the face image file
      }
    } else {
      _showError('No image selected');
    }
  }

  void resetImage() {
    imageFile.value = null;
    extractedFaceBytes = null;
    passportData = null;
    isLoading.value = false;

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
          currentApplicant.copyWith(
            passportPhotoURL: null,
            passportBioPageURL: null,
          ),
        );
      }
    } else {
      // For other applicants, update the current applicant in the entity members list
      final currentApplicant = applicantsController
          .applicantEntity.entityMembers?.lastOrNull?.applicant;
      if (currentApplicant != null) {
        VisaApplicant updatedApplicant = currentApplicant.copyWith(
          passportPhotoURL: null,
          passportBioPageURL: null,
        );
        currentApplicant.update(updatedApplicant);
      }
    }
  }
}
