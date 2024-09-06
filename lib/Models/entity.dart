import 'package:paradise_sri_lanka/Models/visa_applicant.dart';

class ApplicantEntity {
  String? entityId;
  VisaApplicant? mainVisaApplicant;
  List<VisaApplicant> applicants;
  String countryId;
  String visaSubCategory;
  DateTime arrivalDate;
  DateTime? departureDate;
  String? accommodationPlaceDocumentURL;
  String? addressOfStay;
  String? cityOfStay;
  String? zipOfStay;

  ApplicantEntity({
    this.entityId,
    this.mainVisaApplicant,
    required this.applicants,
    required this.countryId,
    required this.visaSubCategory,
    required this.arrivalDate,
    this.departureDate,
    this.accommodationPlaceDocumentURL,
    this.addressOfStay,
    this.cityOfStay,
    this.zipOfStay,
  });

  // Convert an ApplicantEntity object to a map (for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'entityId': entityId,
      'mainVisaApplicant': mainVisaApplicant?.toMap(),
      'applicants': applicants.map((applicant) => applicant.toMap()).toList(),
      'countryId': countryId,
      'visaSubCategory': visaSubCategory,
      'arrivalDate': arrivalDate.toIso8601String(),
      'departureDate': departureDate?.toIso8601String(),
      'accommodationPlaceDocumentURL': accommodationPlaceDocumentURL,
      'addressOfStay': addressOfStay,
      'cityOfStay': cityOfStay,
      'zipOfStay': zipOfStay,
    };
  }

  // Create an ApplicantEntity object from a map (for retrieving from a database)
  factory ApplicantEntity.fromMap(Map<String, dynamic> map) {
    return ApplicantEntity(
      entityId: map['entityId'],
      mainVisaApplicant: VisaApplicant.fromMap(map['mainVisaApplicant']),
      applicants: List<VisaApplicant>.from(
        map['applicants']?.map((applicant) => VisaApplicant.fromMap(applicant)),
      ),
      countryId: map['countryId'],
      visaSubCategory: map['visaSubCategory'],
      arrivalDate: DateTime.parse(map['arrivalDate']),
      departureDate: DateTime.parse(map['departureDate']),
      accommodationPlaceDocumentURL: map['accommodationPlaceDocumentURL'],
      addressOfStay: map['addressOfStay'],
      cityOfStay: map['cityOfStay'],
      zipOfStay: map['zipOfStay'],
    );
  }
}
