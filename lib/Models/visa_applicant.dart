import 'package:paradise_sri_lanka/Models/travelled_country.dart';

class VisaApplicant {
  String? applicantId;
  String passportBioPageURL;
  String passportPhotoURL;
  String passportNumber;
  DateTime passportExpiryDate;
  String surname;
  String givenNames;
  DateTime dateOfBirth;
  String placeOfBirth;
  String nationality;
  String gender;
  String? occupation;
  String? maritalStatus;
  String phoneNumberCountryCode;
  String phoneNumber;
  String whatsAppNumberCountryCode;
  String whatsAppNumber;
  String homeAddress;
  String email;
  String emergencyContactPersonName;
  String emergencyContactPersonPhoneCountryCode;
  String emergencyContactPersonPhone;
  String? accommodationPlaceDocumentURL;
  String? returnAirTicketURL;
  bool? hasVisitedBefore;
  DateTime? lastVisitedDate;
  String? facebookURL;
  String? instagramURL;
  String? xURL;
  String? linkedInURL;
  List<TravelledCountry>? travelHistory;

  VisaApplicant({
    required this.passportBioPageURL,
    required this.passportPhotoURL,
    required this.passportNumber,
    required this.passportExpiryDate,
    required this.surname,
    required this.givenNames,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.nationality,
    required this.gender,
    this.occupation,
    this.maritalStatus,
    required this.phoneNumberCountryCode,
    required this.phoneNumber,
    required this.whatsAppNumberCountryCode,
    required this.whatsAppNumber,
    required this.homeAddress,
    required this.email,
    required this.emergencyContactPersonName,
    required this.emergencyContactPersonPhoneCountryCode,
    required this.emergencyContactPersonPhone,
    this.accommodationPlaceDocumentURL,
    this.returnAirTicketURL,
    this.hasVisitedBefore,
    this.lastVisitedDate,
    this.facebookURL,
    this.instagramURL,
    this.xURL,
    this.linkedInURL,
    this.travelHistory,
  });

  // Convert a VisaApplicant object to a map (for saving to a database)
  Map<String, dynamic> toMap() {
    return {
      'passportBioPageURL': passportBioPageURL,
      'passportPhotoURL': passportPhotoURL,
      'passportNumber': passportNumber,
      'passportExpiryDate': passportExpiryDate.toIso8601String(),
      'surname': surname,
      'givenNames': givenNames,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'placeOfBirth': placeOfBirth,
      'nationality': nationality,
      'gender': gender,
      'occupation': occupation,
      'maritalStatus': maritalStatus,
      'phoneNumberCountryCode': phoneNumberCountryCode,
      'phoneNumber': phoneNumber,
      'whatsAppNumberCountryCode': whatsAppNumberCountryCode,
      'whatsAppNumber': whatsAppNumber,
      'homeAddress': homeAddress,
      'email': email,
      'emergencyContactPersonName': emergencyContactPersonName,
      'emergencyContactPersonPhoneCountryCode': emergencyContactPersonPhoneCountryCode,
      'emergencyContactPersonPhone': emergencyContactPersonPhone,
      'accommodationPlaceDocumentURL': accommodationPlaceDocumentURL,
      'returnAirTicketURL': returnAirTicketURL,
      'hasVisitedBefore': hasVisitedBefore,
      'lastVisitedDate': lastVisitedDate?.toIso8601String(),
      'facebookURL': facebookURL,
      'instagramURL': instagramURL,
      'xURL': xURL,
      'linkedInURL': linkedInURL,
      'travelHistory': travelHistory?.map((travel) => travel.toMap()).toList(),
    };
  }

  // Create a VisaApplicant object from a map (for retrieving from a database)
  factory VisaApplicant.fromMap(Map<String, dynamic> map) {
    return VisaApplicant(
      passportBioPageURL: map['passportBioPageURL'],
      passportPhotoURL: map['passportPhotoURL'],
      passportNumber: map['passportNumber'],
      passportExpiryDate: DateTime.parse(map['passportExpiryDate']),
      surname: map['surname'],
      givenNames: map['givenNames'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      placeOfBirth: map['placeOfBirth'],
      nationality: map['nationality'],
      gender: map['gender'],
      occupation: map['occupation'],
      maritalStatus: map['maritalStatus'],
      phoneNumberCountryCode: map['phoneNumberCountryCode'],
      phoneNumber: map['phoneNumber'],
      whatsAppNumberCountryCode: map['whatsAppNumberCountryCode'],
      whatsAppNumber: map['whatsAppNumber'],
      homeAddress: map['homeAddress'],
      email: map['email'],
      emergencyContactPersonName: map['emergencyContactPersonName'],
      emergencyContactPersonPhoneCountryCode: map['emergencyContactPersonPhoneCountryCode'],
      emergencyContactPersonPhone: map['emergencyContactPersonPhone'],
      accommodationPlaceDocumentURL: map['accommodationPlaceDocumentURL'],
      returnAirTicketURL: map['returnAirTicketURL'],
      hasVisitedBefore: map['hasVisitedBefore'],
      lastVisitedDate: DateTime.parse(map['lastVisitedDate']),
      facebookURL: map['facebookURL'],
      instagramURL: map['instagramURL'],
      xURL: map['xURL'],
      linkedInURL: map['linkedInURL'],
      travelHistory: List<TravelledCountry>.from(
        map['travelHistory']?.map((item) => TravelledCountry.fromMap(item)),
      ),
    );
  }
}


