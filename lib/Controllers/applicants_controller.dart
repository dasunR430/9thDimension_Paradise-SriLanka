import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';

import '../Models/entity.dart';

class ApplicantController extends GetxController {
  // Initialize ApplicantEntity with hard-coded test data
  final ApplicantEntity _applicantEntity = ApplicantEntity(
    countryId: 'SL',
    visaSubCategory: 'Tourist',
    arrivalDate: DateTime.now(),
    departureDate: DateTime.now().add(Duration(days: 7)),
    mainVisaApplicant: null, // Main applicant not added yet
    applicants: [],
  );

  ApplicantEntity get applicantEntity => _applicantEntity;

  // Add main applicant
  void addMainApplicant(VisaApplicant applicant) {
    _applicantEntity.mainVisaApplicant = applicant;
    update(); // Update the UI
  }

  // Add other applicant
  void addOtherApplicant(VisaApplicant applicant) {
    if (_applicantEntity.mainVisaApplicant == null) {
      // Main applicant must be added first
      return;
    }
    _applicantEntity.applicants?.add(applicant);
    update(); // Update the UI
  }

  // Remove an applicant
  void removeApplicant(VisaApplicant applicant) {
    if (_applicantEntity.applicants != null) {
      _applicantEntity.applicants!.remove(applicant);
      update(); // Update the UI
    }
  }

  // Test data for main applicant
  void testAddMainApplicant() {
    addMainApplicant(VisaApplicant(
      passportBioPageURL: 'https://example.com/bio.jpg',
      passportPhotoURL: 'https://example.com/photo.jpg',
      passportNumber: 'A1234567',
      passportExpiryDate: DateTime(2030, 12, 31),
      surname: 'Doe',
      givenNames: 'John',
      dateOfBirth: DateTime(1985, 5, 15),
      placeOfBirth: 'New York',
      nationality: 'American',
      gender: 'Male',
      phoneNumberCountryCode: '+1',
      phoneNumber: '1234567890',
      whatsAppNumberCountryCode: '+1',
      whatsAppNumber: '0987654321',
      homeAddress: '123 Elm Street',
      email: 'john.doe@example.com',
      emergencyContactPersonName: 'Jane Doe',
      emergencyContactPersonPhoneCountryCode: '+1',
      emergencyContactPersonPhone: '1122334455',
    ));
  }

  // Test data for other applicant
  void testAddOtherApplicant() {
    addOtherApplicant(VisaApplicant(
      passportBioPageURL: 'https://example.com/bio2.jpg',
      passportPhotoURL: 'https://example.com/photo2.jpg',
      passportNumber: 'B7654321',
      passportExpiryDate: DateTime(2032, 11, 30),
      surname: 'Smith',
      givenNames: 'Alice',
      dateOfBirth: DateTime(1990, 8, 22),
      placeOfBirth: 'Los Angeles',
      nationality: 'American',
      gender: 'Female',
      phoneNumberCountryCode: '+1',
      phoneNumber: '2345678901',
      whatsAppNumberCountryCode: '+1',
      whatsAppNumber: '1098765432',
      homeAddress: '456 Maple Avenue',
      email: 'alice.smith@example.com',
      emergencyContactPersonName: 'Bob Smith',
      emergencyContactPersonPhoneCountryCode: '+1',
      emergencyContactPersonPhone: '2233445566',
    ));
  }

  // Test data for removing an applicant
  void testRemoveApplicant() {
    if (_applicantEntity.applicants != null && _applicantEntity.applicants!.isNotEmpty) {
      removeApplicant(_applicantEntity.applicants!.first);
    }
  }
}
