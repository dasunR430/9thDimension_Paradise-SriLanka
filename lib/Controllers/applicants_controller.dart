import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Controllers/visa_application_controller.dart';
import 'package:paradise_sri_lanka/Models/entity.dart';
import 'package:paradise_sri_lanka/Models/travelled_country.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Models/entity_member.dart';
import 'package:paradise_sri_lanka/Services/API/database.dart';
import 'package:paradise_sri_lanka/Views/Applicants%20Screen/applicants_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Form/form_screen.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Portal/visa_portal_screen.dart';

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
        countryId: 'CAN',
        visaTypeId: 'tourist_30',
        startDate: DateTime.now(),
        addressOfStay: '', // Ensure this is an empty string, not null
        cityOfStay: '',
        zipOfStay: '',
        travelHistory: [],
      ).obs;
    } catch (e) {
      _applicantEntity = ApplicantEntity(
        countryId: 'CAN',
        visaTypeId: 'tourist_30',
        startDate: DateTime.now(),
        addressOfStay: '',
        cityOfStay: '',
        zipOfStay: '',
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
      applicantEntity.mainVisaApplicant = VisaApplicant(
        applicantId: 1,
        passportPhotoURL: '',
        passportBioPageURL: '',
        passportNumber: '',
        passportExpiryDate: DateTime.now(),
        surname: '',
        givenNames: '',
        dateOfBirth: DateTime.now(),
        placeOfBirth: '',
        nationality: '',
        gender: '',
        occupation: '',
        maritalStatus: '',
        phoneNumberCountryCode: '',
        phoneNumber: '',
        whatsAppNumberCountryCode: '',
        whatsAppNumber: '',
        homeAddress: '',
        email: '',
        emergencyContactPersonName: '',
        emergencyContactPersonPhoneCountryCode: '',
        emergencyContactPersonPhone: '',
        accommodationPlaceDocumentURL: '',
        returnAirTicketURL: '',
        hasVisitedBefore: null,
        lastVisitedDate: null,
        facebookURL: '',
        instagramURL: '',
        xURL: '',
        linkedInURL: '',
        travelHistory: [],
      );
      //
      Get.off(() => FormScreen("Main", "Group"));
    }
  }
  void addMainApplicantIndividual() {
    // Implement the logic to add main applicant
    if (applicantEntity.mainVisaApplicant != null) {
      Get.off(() => FormScreen("Main", "Individual"));
      //
    } else {
      applicantEntity.mainVisaApplicant = VisaApplicant(
        applicantId: 1,
        passportPhotoURL: '',
        passportBioPageURL: '',
        passportNumber: '',
        passportExpiryDate: DateTime.now(),
        surname: '',
        givenNames: '',
        dateOfBirth: DateTime.now(),
        placeOfBirth: '',
        nationality: '',
        gender: '',
        occupation: '',
        maritalStatus: '',
        phoneNumberCountryCode: '',
        phoneNumber: '',
        whatsAppNumberCountryCode: '',
        whatsAppNumber: '',
        homeAddress: '',
        email: '',
        emergencyContactPersonName: '',
        emergencyContactPersonPhoneCountryCode: '',
        emergencyContactPersonPhone: '',
        accommodationPlaceDocumentURL: '',
        returnAirTicketURL: '',
        hasVisitedBefore: null,
        lastVisitedDate: null,
        facebookURL: '',
        instagramURL: '',
        xURL: '',
        linkedInURL: '',
        travelHistory: [],
      );
      //
      Get.off(() => FormScreen("Main", "Individual"));
    }
  }

  // Method to remove main applicant
  void removeMainApplicant() {
    _applicantEntity.update((val) {
      val?.mainVisaApplicant = null;
    });
    Get.to(() => const ApplicantsScreen());
  }

  // Method to update other applicants
  void addOtherApplicant() {
    if (applicantEntity.mainVisaApplicant != null) {
      applicantEntity.addEntityMember(VisaApplicant(
        applicantId: 1,
        passportPhotoURL: '',
        passportBioPageURL: '',
        passportNumber: '',
        passportExpiryDate: DateTime.now(),
        surname: '',
        givenNames: '',
        dateOfBirth: DateTime.now(),
        placeOfBirth: '',
        nationality: '',
        gender: '',
        occupation: '',
        maritalStatus: '',
        phoneNumberCountryCode: '',
        phoneNumber: '',
        whatsAppNumberCountryCode: '',
        whatsAppNumber: '',
        homeAddress: '',
        email: '',
        emergencyContactPersonName: '',
        emergencyContactPersonPhoneCountryCode: '',
        emergencyContactPersonPhone: '',
        accommodationPlaceDocumentURL: '',
        returnAirTicketURL: '',
        hasVisitedBefore: null,
        lastVisitedDate: null,
        facebookURL: '',
        instagramURL: '',
        xURL: '',
        linkedInURL: '',
        travelHistory: [],
      ));
      Get.off(() => FormScreen("Other", "Group"));
    } else {
      Get.snackbar("Invalid Route",
          "Main applicant should be added way before adding other applicants");
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
    required List<String> activities,
    required List<String> places,
  }) {
    _applicantEntity.update((val) {
      val?.countryId = countryId;
      val?.visaTypeId = visaTypeId;
      val?.startDate = startDate;
      val?.activities = activities;
      val?.places = places;
      val?.endDate = startDate.add(
          Duration(days: ParadiseDataBase.getVisaType(visaTypeId).duration));
      val?.activities = activities;
      val?.places = places;
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
  void finalizeApplication(
      VisaApplicant applicant, VisaApplicationController controller) async {
    if (_visaSelectionType == "Group") {
      if (_applicantType == "Main") {
        // Update the main applicant in ApplicantController
        updateMainApplicant(applicant);

        Get.off(() => const ApplicantsScreen());
      } else {
        _applicantEntity.update((val) {
          val?.entityMembers!.lastOrNull?.applicant.update(applicant);
        });
        _applicantEntity.update((val) {
          val?.entityMembers!.lastOrNull?.relation =
              controller.relationshipController.value.text;
        });
        Get.off(() => const ApplicantsScreen());
      }
    } else {
      updateMainApplicant(applicant);

      await saveApplicantToDatabase();
      await processRecomendationModel();
      Get.off(() => const VisaPortalScreen());
    }

    // You can implement saving to a database or any other persistence layer here
    // For example:
    // ParadiseDataBase.saveApplicant(_applicantEntity.value.toMap());
  }

  Future<void> saveApplicantToDatabase() async {
    try {
      await ParadiseDataBase.saveApplicantToDatabase(applicantEntity);
      //Get.snackbar('Success', 'Applicant data saved to database successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save applicant data: $e');
    }
  }

  Future<void> processRecomendationModel() async {
    try {
      await ParadiseDataBase.processRecomendationModel(
          applicantEntity.activities, applicantEntity.places);
      //Get.snackbar('Success', 'Applicant data saved to database successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save applicant data: $e');
    }
  }

  // Test data for main applicant
  void testAddMainApplicant() {
    updateMainApplicant(VisaApplicant(
      applicantId: 1234567890,
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
