import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/entity_member.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Models/travelled_country.dart';
import 'package:intl/intl.dart'; // For date formatting

class VisaApplicationController extends GetxController {
  var currentPage = 0.obs;
  int _cPage = 0;

  final PageController pageController = PageController(initialPage: 0);

  VisaApplicationController(this.isMainApplicant);

  static VisaApplicationController instance = Get.find();

  final bool isMainApplicant;

  // Controllers for text fields
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController otherNamesController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
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
    if (_cPage < 4) {
      _cPage++;
      pageController.animateToPage(_cPage,
          duration: Durations.short3, curve: Curves.linear);
      setIndicator();
    }
  }

  void previousPage() {
    if (_cPage > 0) {
      _cPage--;
      pageController.animateToPage(_cPage,
          duration: Durations.short3, curve: Curves.linear);
      setIndicator();
    }
  }

  void onPageChange(int page) {
    _cPage = page;
    setIndicator();
  }

  void setIndicator() {
    currentPage.value = _cPage;
  }

  String getStatus (int sectionNum) {
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
    String? validationError = validateVisaApplicant();
    if(validationError != null){
      Get.snackbar("Error", validationError);
      return;
    }
    DateTime? passportExpiryDate = _parseDate(
        passportExpiryDateController.text);
    DateTime? dateOfBirth = _parseDate(birthdayController.text);
    DateTime? lastVisitedDate = _parseDate(lastVisitedDateController.text);


    if (passportExpiryDate == null || dateOfBirth == null ||
        lastVisitedDate == null) {
      // Handle error, show message to user or fallback to default values
      print(
          'Invalid date(s) provided. Please correct the format (yyyy-MM-dd).');
      return;
    }



    // Proceed with the creation of VisaApplicant if all dates are valid
    VisaApplicant applicant = VisaApplicant(
      //TODO: URLS need to be updated
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
    if(isMainApplicant){
      Get.back(result: applicant);
    } else {
      EntityMember entityMember = EntityMember(applicant: applicant, relation: relationshipController.text);
      Get.back(result: entityMember);
    }
  }

  String? validateVisaApplicant() {
    if (passportNumberController.text.isEmpty) {
      return 'Passport number is required.';
    }
    if (passportExpiryDateController.text.isEmpty) {
      return 'Passport expiry date is required.';
    }
    if (surnameController.text.isEmpty) {
      return 'Surname is required.';
    }
    if (otherNamesController.text.isEmpty) {
      return 'Given names are required.';
    }
    if (birthdayController.text.isEmpty) {
      return 'Date of birth is required.';
    }
    if (placeOfBirthController.text.isEmpty) {
      return 'Place of birth is required.';
    }
    if (nationalityController.text.isEmpty) {
      return 'Nationality is required.';
    }
    if (genderController.text.isEmpty) {
      return 'Gender is required.';
    }
    if (occupationController.text.isEmpty) {
      return 'Occupation is required.';
    }
    if (emailController.text.isEmpty) {
      return 'Email is required.';
    }
    if (phoneNumberCountryCodeController.text.isEmpty) {
      return 'Phone number country code is required.';
    }
    if (phoneNumberController.text.isEmpty) {
      return 'Phone number is required.';
    }
    if (whatsAppNumberCountryCodeController.text.isEmpty) {
      return 'WhatsApp country code is required.';
    }
    if (whatsAppNumberController.text.isEmpty) {
      return 'WhatsApp number is required.';
    }
    if (homeAddressController.text.isEmpty) {
      return 'Home address is required.';
    }
    if (emergencyContactPersonNameController.text.isEmpty) {
      return 'Emergency contact person name is required.';
    }
    if (emergencyContactPersonPhoneCountryCodeController.text.isEmpty) {
      return 'Emergency contact phone country code is required.';
    }
    if (emergencyContactPersonPhoneController.text.isEmpty) {
      return 'Emergency contact phone number is required.';
    }
    if (hasVisitedBeforeController.text.isEmpty) {
      return 'Has visited before is required.';
    }

    return null;
  }



}