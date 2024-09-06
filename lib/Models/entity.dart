import 'package:paradise_sri_lanka/Models/visaType.dart';
import 'package:paradise_sri_lanka/Models/entity_member.dart';
import 'package:paradise_sri_lanka/Models/visa_applicant.dart';
import 'package:paradise_sri_lanka/Services/API/database.dart';

class ApplicantEntity {
  String? entityId;
  VisaApplicant? mainVisaApplicant;

  List<EntityMember>? entityMembers = [];

  String countryId;
  String visaTypeId;
  DateTime startDate;
  late DateTime endDate;
  String? accommodationPlaceDocumentURL;
  String? addressOfStay;
  String? cityOfStay;
  String? zipOfStay;

  ApplicantEntity({
    this.entityId,
    this.mainVisaApplicant,
    required this.countryId,
    required this.visaTypeId,
    required this.startDate,
    this.accommodationPlaceDocumentURL,
    this.addressOfStay,
    this.cityOfStay,
    this.zipOfStay,
  }){
    endDate = startDate.add(Duration(days: ParadiseDataBase.getVisaType(visaTypeId).duration));
  }

  // Convert an ApplicantEntity object to a map (for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'entityId': entityId,
      'mainVisaApplicant': mainVisaApplicant?.toMap(),
      'entityMembers': entityMembers?.map((entityMember) => entityMember.toMap()).toList(),
      'countryId': countryId,
      'visaId': visaTypeId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'accommodationPlaceDocumentURL': accommodationPlaceDocumentURL,
      'addressOfStay': addressOfStay,
      'cityOfStay': cityOfStay,
      'zipOfStay': zipOfStay,
    };
  }

  // Create an ApplicantEntity object from a map (for retrieving from a database)
  ApplicantEntity.fromMap(Map<String, dynamic> map)
      : countryId = map['countryId'],
        startDate = DateTime.parse(map['startDate']),
        visaTypeId = map['visaId'] {

    entityId = map['entityId'];

    mainVisaApplicant = map['mainVisaApplicant'] != null
        ? VisaApplicant.fromMap(map['mainVisaApplicant'])
        : null;

    entityMembers = map['entityMembers'] != null
        ? List<EntityMember>.from(
      map['entityMembers'].map((applicant) => EntityMember.fromMap(applicant)),
    )
        : null;

    endDate = DateTime.parse(map['endDate']);
    accommodationPlaceDocumentURL = map['accommodationPlaceDocumentURL'];
    addressOfStay = map['addressOfStay'];
    cityOfStay = map['cityOfStay'];
    zipOfStay = map['zipOfStay'];
  }


}
