import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Models/travelled_country.dart';
import 'package:intl/intl.dart'; // For date formatting

class VisaApplicationController extends GetxController {
  var currentPage = 0.obs;

  static VisaApplicationController instance = Get.find();

  // Controllers for text fields
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController otherNamesController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passportNumberController = TextEditingController();
  final TextEditingController passportExpiryDateController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController martialStatusController = TextEditingController();
  final TextEditingController phoneNumberCountryCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController whatsAppNumberCountryCodeController = TextEditingController();
  final TextEditingController whatsAppNumberController = TextEditingController();
  final TextEditingController homeAddressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emergencyContactPersonNameController = TextEditingController();
  final TextEditingController emergencyContactPersonPhoneCountryCodeController = TextEditingController();
  final TextEditingController emergencyContactPersonPhoneController = TextEditingController();
  final TextEditingController accommodationPlaceDocumentURLController = TextEditingController();
  final TextEditingController returnAirTicketURLController = TextEditingController();
  final TextEditingController hasVisitedBeforeController = TextEditingController();
  final TextEditingController lastVisitedDateController = TextEditingController();
  final TextEditingController facebookURLController = TextEditingController();
  final TextEditingController instagramURLController = TextEditingController();
  final TextEditingController xURLController = TextEditingController();
  final TextEditingController linkedInURLController = TextEditingController();

  List<TravelledCountry> travelHistory = [];

  void nextPage() {
    if (currentPage < 3) {
      currentPage.value++;
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage.value--;
    }
  }

  String getStatus(int sectionNum) {
    if ((currentPage.value + 1) == sectionNum) {
      return 'current';
    } else if ((currentPage.value + 1) > sectionNum) {
      return 'done';
    } else {
      return 'next';
    }
  }

  // Helper method to validate if a string can be parsed into a DateTime object
  bool _isValidDate(String dateString) {
    if (dateString.isEmpty) {
      return false;
    }
    // Use RegExp to match the required date format: yyyy-MM-dd
    final RegExp dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegex.hasMatch(dateString);
  }

// Helper method to parse dates safely after validation
  DateTime? _parseDate(String dateString) {
    if (!_isValidDate(dateString)) {
      print('Invalid date format: $dateString. Expected format: yyyy-MM-dd');
      return null;
    }
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(dateString);
    } catch (e) {
      print('Date parsing error: $e');
      return null; // Return null if the date cannot be parsed
    }
  }

  void createVisaApplicant() {
    // Validate date fields before parsing
    DateTime? passportExpiryDate = _parseDate(
        passportExpiryDateController.text);
    DateTime? dateOfBirth = _parseDate(birthdayController.text);
    DateTime? lastVisitedDate = _parseDate(lastVisitedDateController.text);

    // Ensure required dates are valid before proceeding
    if (passportExpiryDate == null || dateOfBirth == null ||
        lastVisitedDate == null) {
      // Handle error, show message to user or fallback to default values
      print(
          'Invalid date(s) provided. Please correct the format (yyyy-MM-dd).');
      return;
    }

    // Proceed with the creation of VisaApplicant if all dates are valid
    VisaApplicant applicant = VisaApplicant(
      passportBioPageURL: '',
      passportPhotoURL: '',
      passportNumber: passportNumberController.text,
      passportExpiryDate: passportExpiryDate,
      surname: surnameController.text,
      givenNames: otherNamesController.text,
      dateOfBirth: dateOfBirth,
      placeOfBirth: placeOfBirthController.text,
      nationality: nationalityController.text,
      gender: genderController.text,
      occupation: occupationController.text,
      maritalStatus: martialStatusController.text,
      phoneNumberCountryCode: phoneNumberCountryCodeController.text,
      phoneNumber: phoneNumberController.text,
      whatsAppNumberCountryCode: whatsAppNumberCountryCodeController.text,
      whatsAppNumber: whatsAppNumberController.text,
      homeAddress: homeAddressController.text,
      email: emailController.text,
      emergencyContactPersonName: emergencyContactPersonNameController.text,
      emergencyContactPersonPhoneCountryCode: emergencyContactPersonPhoneCountryCodeController
          .text,
      emergencyContactPersonPhone: emergencyContactPersonPhoneController.text,
      accommodationPlaceDocumentURL: accommodationPlaceDocumentURLController
          .text,
      returnAirTicketURL: returnAirTicketURLController.text,
      hasVisitedBefore: hasVisitedBeforeController.text.toLowerCase() == 'yes',
      lastVisitedDate: lastVisitedDate,
      facebookURL: facebookURLController.text,
      instagramURL: instagramURLController.text,
      xURL: xURLController.text,
      linkedInURL: linkedInURLController.text,
      travelHistory: travelHistory,
    );

    Get.back(result: applicant);
  }
}