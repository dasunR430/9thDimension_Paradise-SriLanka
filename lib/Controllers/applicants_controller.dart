import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Models/entity.dart';
import 'package:paradise_sri_lanka/Models/travelled_country.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Models/entity_member.dart';
import 'package:paradise_sri_lanka/Services/API/database.dart';
import 'package:paradise_sri_lanka/Views/Applicants%20Screen/applicants_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';

class ApplicantController extends GetxController {
  late final Rx<ApplicantEntity> _applicantEntity;
  String _applicantType = "";
  String _visaSelectionType = "";

  String get applicantType => _applicantType;
  String get visaSelectionType => _visaSelectionType;

  void setApplicantType(String t) {
    _applicantType = t;
  }

  void setVisaSelectionType(String t) {
    _visaSelectionType = t;
  }

  ApplicantController() {
    _initializeApplicantEntity();
  }

  void _initializeApplicantEntity() {
    try {
      _applicantEntity = ApplicantEntity(
        countryId: 'SL',
        visaTypeId: 'TOURIST',
        startDate: DateTime.now(),
        travelHistory: [],
      ).obs;
    } catch (e) {
      _applicantEntity = ApplicantEntity(
        countryId: 'SL',
        visaTypeId: 'TOURIST',
        startDate: DateTime.now(),
        travelHistory: [],
      ).obs;
    }
  }

  ApplicantEntity get applicantEntity => _applicantEntity.value;

  // Method to update main applicant details
  void updateMainApplicant(VisaApplicant applicant) {
    _applicantEntity.update((val) {
      val?.mainVisaApplicant = applicant;
    });
  }

  // Method to add main applicant
  void addMainApplicant() {
    // Implement the logic to add main applicant
    if (applicantEntity.mainVisaApplicant != null) {
      //
    } else {
      //
      Get.off(() => FormScreen("Main", "Group"));

    }
  }

  // Method to remove main applicant
  void removeMainApplicant() {
    _applicantEntity.update((val) {
      val?.mainVisaApplicant = null;
    });
    Get.to(()=>ApplicantsScreen());
  }

  // Method to update other applicants
  void addOtherApplicant() {
    if (applicantEntity.mainVisaApplicant != null) {
      Get.off(() => FormScreen("Other", "Group"));
    }else{
      Get.snackbar("Invalid Route", "Main applicant should be added way before adding other applicants");
    }
  }

  void removeApplicant(EntityMember applicant) {
    _applicantEntity.update((val) {
      val?.entityMembers?.remove(applicant);
    });
  }

  // Method to set Visa Type and Country
  void setVisaDetails({
    required String countryId,
    required String visaTypeId,
    required DateTime startDate,
  }) {
    _applicantEntity.update((val) {
      val?.countryId = countryId;
      val?.visaTypeId = visaTypeId;
      val?.startDate = startDate;
      val?.endDate = startDate.add(
          Duration(days: ParadiseDataBase.getVisaType(visaTypeId).duration));
    });
  }

  void addTravelHistory(TravelledCountry country) {
    _applicantEntity.update((val) {
      val?.travelHistory.add(country);
    });
  }

  void removeTravelHistory(int index) {
    _applicantEntity.update((val) {
      val?.travelHistory.removeAt(index);
    });
  }

  // Method to update Accommodation Details
  void updateAccommodationDetails({
    String? accommodationPlaceDocumentURL,
    String? addressOfStay,
    String? cityOfStay,
    String? zipOfStay,
  }) {
    _applicantEntity.update((val) {
      val?.accommodationPlaceDocumentURL = accommodationPlaceDocumentURL;
      val?.addressOfStay = addressOfStay;
      val?.cityOfStay = cityOfStay;
      val?.zipOfStay = zipOfStay;
    });
  }

  // Method to finalize and save applicant data
  void finalizeApplication(VisaApplicant applicant) {
    if (_applicantType == "Main") {
      // Update the main applicant in ApplicantController
      updateMainApplicant(applicant);

      Get.snackbar('Success', 'Visa Applicant data saved successfully.');

      if (_visaSelectionType == "Individual") {
        //Go to submit
      } else {
        Get.off(() => const ApplicantsScreen());
      }
    } else {
      _applicantEntity.update((val) {
        val?.addEntityMember(applicant);
      });
      Get.off(() => const ApplicantsScreen());
    }

    // You can implement saving to a database or any other persistence layer here
    // For example:
    // ParadiseDataBase.saveApplicant(_applicantEntity.value.toMap());
  }

  // Test data for main applicant
  void testAddMainApplicant() {
    updateMainApplicant(VisaApplicant(
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
      occupation: 'Engineer',
      maritalStatus: 'Single',
      accommodationPlaceDocumentURL: 'https://example.com/accommodation.pdf',
      returnAirTicketURL: 'https://example.com/ticket.pdf',
      hasVisitedBefore: false,
      lastVisitedDate: null,
      facebookURL: 'https://facebook.com/johndoe',
      instagramURL: 'https://instagram.com/johndoe',
      xURL: 'https://x.com/johndoe',
      linkedInURL: 'https://linkedin.com/in/johndoe',
      travelHistory: [],
      faceImagePath: 'path/to/face/image.jpg',
    ));
  }

  // Test data for other applicant
  void testAddOtherApplicant() {
    addOtherApplicant();
  }

  // Test data for removing an applicant
  void testRemoveApplicant() {
    if (_applicantEntity.value.entityMembers != null &&
        _applicantEntity.value.entityMembers!.isNotEmpty) {
      removeApplicant(_applicantEntity.value.entityMembers!.first);
    }
  }
}
