// Start of Selection
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/ImageEditingController.dart';
import 'package:paradise_sri_lanka/Controllers/travel_country_controller.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'applicants_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';

class VisaApplicationController extends GetxController {
  final ApplicantController applicantsController =
      Get.put(ApplicantController());
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  var currentPage = 0.obs;

  static VisaApplicationController instance = Get.find();

  // Controllers for text fields
  final surnameController = TextEditingController().obs;
  final otherNamesController = TextEditingController().obs;
  final birthdayController = TextEditingController().obs;
  final placeOfBirthController = TextEditingController().obs;
  final nationalityController = TextEditingController().obs;
  final genderController = TextEditingController().obs;
  final passportNumberController = TextEditingController().obs;
  final passportExpiryDateController = TextEditingController().obs;
  final occupationController = TextEditingController().obs;
  final maritalStatusController = TextEditingController().obs;
  final emergencyContactPersonNameController = TextEditingController().obs;
  final emergencyContactPersonPhoneCountryCodeController =
      TextEditingController().obs;
  final emergencyContactPersonPhoneController = TextEditingController().obs;
  final accommodationPlaceDocumentURLController = TextEditingController().obs;
  final returnAirTicketURLController = TextEditingController().obs;
  final hasVisitedBeforeController = TextEditingController().obs;
  final facebookURLController = TextEditingController().obs;
  final instagramURLController = TextEditingController().obs;
  final xURLController = TextEditingController().obs;
  final linkedInURLController = TextEditingController().obs;
  final phoneNumberCountryCodeController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final whatsAppNumberCountryCodeController = TextEditingController().obs;
  final whatsAppNumberController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final homeAddressController = TextEditingController().obs;
  final lastVisitedDate = TextEditingController().obs;

  final faceImage = ImageEditingController().obs;
  final passportImage = ImageEditingController().obs;

  final RxDouble uploadProgress = 0.0.obs;

  Future<String> uploadFile(String filePath, String email) async {
    String fileName = basename(filePath);
    String url = 'http://13.51.159.48:9001/upload';

    dio.FormData formData = dio.FormData.fromMap({
      "file": await dio.MultipartFile.fromFile(filePath, filename: fileName),
      "email": email,
    });

    try {
      dio.Dio dioInstance = dio.Dio();
      var response = await dioInstance.post(
        url,
        data: formData,
        options: dio.Options(
          sendTimeout: const Duration(milliseconds: 30000),
          receiveTimeout: const Duration(milliseconds: 30000),
        ),
        onSendProgress: (int sent, int total) {
          uploadProgress.value = sent / total;
        },
      );

      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        throw Exception(
            'Server error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      rethrow;
    } finally {
      uploadProgress.value = 0.0;
    }
  }

  String _getFullImageUrl(String partialUrl) {
    if (partialUrl.startsWith('http://') || partialUrl.startsWith('https://')) {
      return partialUrl;
    }
    return 'http://13.51.159.48:9001${Uri.encodeFull(partialUrl)}';
  }

  Future<VisaApplicant> createVisaApplicant() async {
    final TravelledCountryController travelledCountryController = Get.find();

    String passportBioPageURL = '';
    String passportPhotoURL = '';
    String accommodationPlaceDocumentURL = '';
    String returnAirTicketURL = '';

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      if (passportImage.value.imageFile != null) {
        passportBioPageURL = _getFullImageUrl(await uploadFile(
            passportImage.value.imageFile!.path, emailController.value.text));
      }
      if (faceImage.value.imageFile != null) {
        passportPhotoURL = _getFullImageUrl(await uploadFile(
            faceImage.value.imageFile!.path, emailController.value.text));
      }
      if (accommodationPlaceDocumentURLController.value.text.isNotEmpty) {
        accommodationPlaceDocumentURL = _getFullImageUrl(await uploadFile(
            accommodationPlaceDocumentURLController.value.text,
            emailController.value.text));
      }
      if (returnAirTicketURLController.value.text.isNotEmpty) {
        returnAirTicketURL = _getFullImageUrl(await uploadFile(
            returnAirTicketURLController.value.text,
            emailController.value.text));
      }

      for (var travelEntry in travelledCountryController.travelledCountryList) {
        if (travelEntry.attachment != null) {
          String uploadedImageURL = _getFullImageUrl(await uploadFile(
              travelEntry.attachment!, emailController.value.text));
          travelEntry.attachment = uploadedImageURL;
        }
      }

      final applicant = VisaApplicant(
        passportBioPageURL: passportBioPageURL,
        passportPhotoURL: passportPhotoURL,
        passportNumber: passportNumberController.value.text,
        passportExpiryDate:
            DateTime.parse(passportExpiryDateController.value.text),
        surname: surnameController.value.text,
        givenNames: otherNamesController.value.text,
        dateOfBirth: DateTime.parse(birthdayController.value.text),
        placeOfBirth: placeOfBirthController.value.text,
        nationality: nationalityController.value.text,
        gender: genderController.value.text,
        phoneNumberCountryCode: phoneNumberCountryCodeController.value.text,
        phoneNumber: phoneNumberController.value.text,
        whatsAppNumberCountryCode:
            whatsAppNumberCountryCodeController.value.text,
        whatsAppNumber: whatsAppNumberController.value.text,
        homeAddress: homeAddressController.value.text,
        email: emailController.value.text,
        emergencyContactPersonName:
            emergencyContactPersonNameController.value.text,
        emergencyContactPersonPhoneCountryCode:
            emergencyContactPersonPhoneCountryCodeController.value.text,
        emergencyContactPersonPhone:
            emergencyContactPersonPhoneController.value.text,
        accommodationPlaceDocumentURL: accommodationPlaceDocumentURL,
        returnAirTicketURL: returnAirTicketURL,
        hasVisitedBefore:
            hasVisitedBeforeController.value.text.toLowerCase() == 'yes',
        lastVisitedDate: lastVisitedDate.value.text.isNotEmpty
            ? DateTime.parse(lastVisitedDate.value.text)
            : null,
        facebookURL: facebookURLController.value.text,
        instagramURL: instagramURLController.value.text,
        xURL: xURLController.value.text,
        linkedInURL: linkedInURLController.value.text,
        travelHistory: travelledCountryController.travelledCountryList,
      );

      return applicant;
    } catch (e) {
      Get.snackbar(
        'Upload Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      Get.back(); // Close the loading dialog
    }
  }

  void next() {
    if (currentPage.value < 4) {
      currentPage.value++;
      pageController.animateToPage(currentPage.value,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void nextPage() {
    if (currentPage.value == 0) {
      if (faceImage.value.imageFile != null &&
          passportImage.value.imageFile != null) {
        next();
      } else {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        ).show();
      }
    } else if (currentPage.value == 1) {
      if (surnameController.value.text.isEmpty ||
          otherNamesController.value.text.isEmpty ||
          birthdayController.value.text.isEmpty ||
          placeOfBirthController.value.text.isEmpty ||
          genderController.value.text.isEmpty ||
          nationalityController.value.text.isEmpty ||
          passportNumberController.value.text.isEmpty ||
          passportExpiryDateController.value.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        ).show();
      } else {
        next();
      }
    } else if (currentPage.value == 2) {
      if (emailController.value.text.isEmpty ||
          homeAddressController.value.text.isEmpty ||
          emergencyContactPersonNameController.value.text.isEmpty ||
          emergencyContactPersonPhoneController.value.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        ).show();
      } else {
        next();
      }
    } else if (currentPage.value == 3) {
      if (returnAirTicketURLController.value.text.isEmpty ||
          accommodationPlaceDocumentURLController.value.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        ).show();
      } else {
        next();
      }
    } else if (currentPage.value == 4) {
      {
        TravelledCountryController travelController =
            Get.find<TravelledCountryController>();
        if (travelController.travelledCountryList.isEmpty) {
          Get.snackbar("Empty Travel History",
              "මගෙන් මැරුම් නොකා ගිය තැනක් දාපන් ඔතෙන්ට");
          return;
        }
        ApplicantController applicantController =
            Get.find<ApplicantController>();
        currentPage.value = 0;
        createVisaApplicant().then((applicant) {
          applicantController.finalizeApplication(applicant);
        }).catchError((error) {
          // Handle the error (e.g., show an error message to the user)
        });
        // Reset all controllers to their initial state
        /*surnameController.value.clear();
        otherNamesController.value.clear();
        birthdayController.value.clear();
        placeOfBirthController.value.clear();
        nationalityController.value.clear();
        genderController.value.clear();
        passportNumberController.value.clear();
        passportExpiryDateController.value.clear();
        occupationController.value.clear();
        maritalStatusController.value.clear();
        emergencyContactPersonNameController.value.clear();
        emergencyContactPersonPhoneController.value.clear();
        accommodationPlaceDocumentURLController.value.clear();
        returnAirTicketURLController.value.clear();
        hasVisitedBeforeController.value.clear();
        facebookURLController.value.clear();
        instagramURLController.value.clear();
        xURLController.value.clear();
        linkedInURLController.value.clear();
        phoneNumberController.value.clear();
        whatsAppNumberController.value.clear();
        emailController.value.clear();
        homeAddressController.value.clear();
        lastVisitedDate.value.clear();

        // Reset the TravelledCountryController
        Get.find<TravelledCountryController>().travelledCountryList.clear();

        // Get image controllers
        final passportImageController = Get.find<ImageUploadController>();
        final profileImageController = Get.find<ImageSelectController>();
        // Reset image controllers
        passportImageController.resetImage();
        profileImageController.resetImage();

        // Reset the current page to the initial page
        currentPage.value = 0;
        pageController.jumpToPage(0);*/
      }
    } else {
      currentPage.value = 0;
      pageController.jumpToPage(0);
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(currentPage.value,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void saveTextData({
    required String surname,
    required String otherNames,
    required String birthday,
    required String placeOfBirth,
    required String nationality,
    required String gender,
    required String passportNumber,
    required String passportExpiryDate,
    required String occupation,
    required String maritalStatus,
    required String emergencyContactPersonName,
    required String emergencyContactPersonPhoneCountryCode,
    required String emergencyContactPersonPhone,
    required String accommodationPlaceDocumentURL,
    required String returnAirTicketURL,
    required String hasVisitedBefore,
    required String facebookURL,
    required String instagramURL,
    required String xURL,
    required String linkedInURL,
    required String phoneNumberCountryCode,
    required String phoneNumber,
    required String whatsAppNumberCountryCode,
    required String whatsAppNumber,
    required String email,
    required String homeAddress,
    required String lastVisitedDate,
  }) {
    surnameController.value.text = surname;
    otherNamesController.value.text = otherNames;
    birthdayController.value.text = birthday;
    placeOfBirthController.value.text = placeOfBirth;
    nationalityController.value.text = nationality;
    genderController.value.text = gender;
    passportNumberController.value.text = passportNumber;
    passportExpiryDateController.value.text = passportExpiryDate;
    occupationController.value.text = occupation;
    maritalStatusController.value.text = maritalStatus;
    emergencyContactPersonNameController.value.text =
        emergencyContactPersonName;
    emergencyContactPersonPhoneCountryCodeController.value.text =
        emergencyContactPersonPhoneCountryCode;
    emergencyContactPersonPhoneController.value.text =
        emergencyContactPersonPhone;
    accommodationPlaceDocumentURLController.value.text =
        accommodationPlaceDocumentURL;
    returnAirTicketURLController.value.text = returnAirTicketURL;
    hasVisitedBeforeController.value.text = hasVisitedBefore;
    facebookURLController.value.text = facebookURL;
    instagramURLController.value.text = instagramURL;
    xURLController.value.text = xURL;
    linkedInURLController.value.text = linkedInURL;
    phoneNumberCountryCodeController.value.text = phoneNumberCountryCode;
    phoneNumberController.value.text = phoneNumber;
    whatsAppNumberCountryCodeController.value.text = whatsAppNumberCountryCode;
    whatsAppNumberController.value.text = whatsAppNumber;
    emailController.value.text = email;
    homeAddressController.value.text = homeAddress;
    this.lastVisitedDate.value.text = lastVisitedDate;
  }

  String getStatus(int step) {
    if (currentPage.value >= step) {
      return 'completed';
    } else if (currentPage.value == step - 1) {
      return 'in-progress';
    } else {
      return 'pending';
    }
  }
}
