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

  // New Fields for Images
  String? faceImagePath;

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
    this.faceImagePath, // Initialize the new field
  });

  // CopyWith method to facilitate updates
  VisaApplicant copyWith({
    String? passportBioPageURL,
    String? passportPhotoURL,
    String? passportNumber,
    DateTime? passportExpiryDate,
    String? surname,
    String? givenNames,
    DateTime? dateOfBirth,
    String? placeOfBirth,
    String? nationality,
    String? gender,
    String? occupation,
    String? maritalStatus,
    String? phoneNumberCountryCode,
    String? phoneNumber,
    String? whatsAppNumberCountryCode,
    String? whatsAppNumber,
    String? homeAddress,
    String? email,
    String? emergencyContactPersonName,
    String? emergencyContactPersonPhoneCountryCode,
    String? emergencyContactPersonPhone,
    String? accommodationPlaceDocumentURL,
    String? returnAirTicketURL,
    bool? hasVisitedBefore,
    DateTime? lastVisitedDate,
    String? facebookURL,
    String? instagramURL,
    String? xURL,
    String? linkedInURL,
    List<TravelledCountry>? travelHistory,
    String? faceImagePath,
  }) {
    return VisaApplicant(
      passportBioPageURL: passportBioPageURL ?? this.passportBioPageURL,
      passportPhotoURL: passportPhotoURL ?? this.passportPhotoURL,
      passportNumber: passportNumber ?? this.passportNumber,
      passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
      surname: surname ?? this.surname,
      givenNames: givenNames ?? this.givenNames,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      occupation: occupation ?? this.occupation,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      phoneNumberCountryCode:
          phoneNumberCountryCode ?? this.phoneNumberCountryCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsAppNumberCountryCode:
          whatsAppNumberCountryCode ?? this.whatsAppNumberCountryCode,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
      homeAddress: homeAddress ?? this.homeAddress,
      email: email ?? this.email,
      emergencyContactPersonName:
          emergencyContactPersonName ?? this.emergencyContactPersonName,
      emergencyContactPersonPhoneCountryCode:
          emergencyContactPersonPhoneCountryCode ??
              this.emergencyContactPersonPhoneCountryCode,
      emergencyContactPersonPhone:
          emergencyContactPersonPhone ?? this.emergencyContactPersonPhone,
      accommodationPlaceDocumentURL:
          accommodationPlaceDocumentURL ?? this.accommodationPlaceDocumentURL,
      returnAirTicketURL: returnAirTicketURL ?? this.returnAirTicketURL,
      hasVisitedBefore: hasVisitedBefore ?? this.hasVisitedBefore,
      lastVisitedDate: lastVisitedDate ?? this.lastVisitedDate,
      facebookURL: facebookURL ?? this.facebookURL,
      instagramURL: instagramURL ?? this.instagramURL,
      xURL: xURL ?? this.xURL,
      linkedInURL: linkedInURL ?? this.linkedInURL,
      travelHistory: travelHistory ?? this.travelHistory,
      faceImagePath: faceImagePath ?? this.faceImagePath,
    );
  }

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
      'emergencyContactPersonPhoneCountryCode':
          emergencyContactPersonPhoneCountryCode,
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
      'faceImagePath': faceImagePath, // Include the new field
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
      emergencyContactPersonPhoneCountryCode:
          map['emergencyContactPersonPhoneCountryCode'],
      emergencyContactPersonPhone: map['emergencyContactPersonPhone'],
      accommodationPlaceDocumentURL: map['accommodationPlaceDocumentURL'],
      returnAirTicketURL: map['returnAirTicketURL'],
      hasVisitedBefore: map['hasVisitedBefore'],
      lastVisitedDate: map['lastVisitedDate'] != null
          ? DateTime.parse(map['lastVisitedDate'])
          : null,
      facebookURL: map['facebookURL'],
      instagramURL: map['instagramURL'],
      xURL: map['xURL'],
      linkedInURL: map['linkedInURL'],
      travelHistory: map['travelHistory'] != null
          ? List<TravelledCountry>.from(map['travelHistory']
              .map((item) => TravelledCountry.fromMap(item)))
          : null,
      faceImagePath: map['faceImagePath'],
    );
  }

  // Initialize a VisaApplicant object with default values
  VisaApplicant.initialize()
      : passportBioPageURL = '',
        passportPhotoURL = '',
        passportNumber = '',
        passportExpiryDate = DateTime.now(),
        surname = '',
        givenNames = '',
        dateOfBirth = DateTime.now(),
        placeOfBirth = '',
        nationality = '',
        gender = '',
        phoneNumberCountryCode = '',
        phoneNumber = '',
        whatsAppNumberCountryCode = '',
        whatsAppNumber = '',
        homeAddress = '',
        email = '',
        emergencyContactPersonName = '',
        emergencyContactPersonPhoneCountryCode = '',
        emergencyContactPersonPhone = '';

  // Update a VisaApplicant object with new values
  void update(VisaApplicant updatedApplicant) {
    passportBioPageURL = updatedApplicant.passportBioPageURL;
    passportPhotoURL = updatedApplicant.passportPhotoURL;
    passportNumber = updatedApplicant.passportNumber;
    passportExpiryDate = updatedApplicant.passportExpiryDate;
    surname = updatedApplicant.surname;
    givenNames = updatedApplicant.givenNames;
    dateOfBirth = updatedApplicant.dateOfBirth;
    placeOfBirth = updatedApplicant.placeOfBirth;
    nationality = updatedApplicant.nationality;
    gender = updatedApplicant.gender;
    occupation = updatedApplicant.occupation;
    maritalStatus = updatedApplicant.maritalStatus;
    phoneNumberCountryCode = updatedApplicant.phoneNumberCountryCode;
    phoneNumber = updatedApplicant.phoneNumber;
    whatsAppNumberCountryCode = updatedApplicant.whatsAppNumberCountryCode;
    whatsAppNumber = updatedApplicant.whatsAppNumber;
    homeAddress = updatedApplicant.homeAddress;
    email = updatedApplicant.email;
    emergencyContactPersonName = updatedApplicant.emergencyContactPersonName;
    emergencyContactPersonPhoneCountryCode =
        updatedApplicant.emergencyContactPersonPhoneCountryCode;
    emergencyContactPersonPhone = updatedApplicant.emergencyContactPersonPhone;
    accommodationPlaceDocumentURL =
        updatedApplicant.accommodationPlaceDocumentURL;
    returnAirTicketURL = updatedApplicant.returnAirTicketURL;
    hasVisitedBefore = updatedApplicant.hasVisitedBefore;
    lastVisitedDate = updatedApplicant.lastVisitedDate;
    facebookURL = updatedApplicant.facebookURL;
    instagramURL = updatedApplicant.instagramURL;
    xURL = updatedApplicant.xURL;
    linkedInURL = updatedApplicant.linkedInURL;
    travelHistory = updatedApplicant.travelHistory;
    faceImagePath = updatedApplicant.faceImagePath;
  }

  // Delete a VisaApplicant object by resetting its values
  void delete() {
    passportBioPageURL = '';
    passportPhotoURL = '';
    passportNumber = '';
    passportExpiryDate = DateTime.now();
    surname = '';
    givenNames = '';
    dateOfBirth = DateTime.now();
    placeOfBirth = '';
    nationality = '';
    gender = '';
    occupation = null;
    maritalStatus = null;
    phoneNumberCountryCode = '';
    phoneNumber = '';
    whatsAppNumberCountryCode = '';
    whatsAppNumber = '';
    homeAddress = '';
    email = '';
    emergencyContactPersonName = '';
    emergencyContactPersonPhoneCountryCode = '';
    emergencyContactPersonPhone = '';
    accommodationPlaceDocumentURL = null;
    returnAirTicketURL = null;
    hasVisitedBefore = null;
    lastVisitedDate = null;
    facebookURL = null;
    instagramURL = null;
    xURL = null;
    linkedInURL = null;
    travelHistory = null;
    faceImagePath = null;
  }
}
