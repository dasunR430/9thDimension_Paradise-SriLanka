import 'package:paradise_sri_lanka/Models/visaType.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Services/API/Exceptions/authentication_exception.dart';
import 'package:paradise_sri_lanka/Services/API/authenticate.dart';
import '../../Models/entity.dart';

class ParadiseDataBase {
  static List<VisaType> _visaTypes = [];

  static Future<List<VisaType>?> get visaTypes async {
    if (_visaTypes.isNotEmpty) {
      return _visaTypes;
    } else {
      await _getVisaTypes();
      if (_visaTypes.isNotEmpty) return _visaTypes;
    }
    return null;
  }

  static Future<http.Response?> postWithJson(String url, Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};

      //Add accessToken
      ParadiseAuthenticate.addAuthorizationHeader(headers);

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if(response.statusCode == 403 || response.statusCode == 401){
        await ParadiseAuthenticate.getAccessToken();

        ParadiseAuthenticate.addAuthorizationHeader(headers);

        response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
        if(response.statusCode == 403 || response.statusCode == 401) return null;
      }
      return response;
    } catch (e) {
      if(e is AuthenticationException){
        //User not logged in
        Get.snackbar("Error", e.message);
      }
      else{
        Get.snackbar("Error", "An error occurred. Please try again later");
      }
    }
    return null;
  }


  static Future<http.Response?> get(String url) async {
    try {
      Map<String, String> headers = {};

      //Add accessToken
      ParadiseAuthenticate.addAuthorizationHeader(headers);

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      if(response.statusCode == 403 || response.statusCode == 401){
        await ParadiseAuthenticate.getAccessToken();

        ParadiseAuthenticate.addAuthorizationHeader(headers);

        response = await http.get(
          Uri.parse(url),
          headers: headers,
        );
        if(response.statusCode == 403 || response.statusCode == 401) return null;
      }
      return response;
    } catch (e) {
      if(e is AuthenticationException){
        //User not logged in
        Get.snackbar("Error", e.message);
      }
      else{
        Get.snackbar("Error", "An error occurred. Please try again later");
      }
    }
    return null;
  }

  static Future<http.Response?> putWithJson(String url, Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};

      //Add accessToken
      ParadiseAuthenticate.addAuthorizationHeader(headers);

      http.Response response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if(response.statusCode == 403 || response.statusCode == 401){
        await ParadiseAuthenticate.getAccessToken();

        ParadiseAuthenticate.addAuthorizationHeader(headers);

        response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
        if(response.statusCode == 403 || response.statusCode == 401) return null;
      }
      return response;
    } catch (e) {
      if(e is AuthenticationException){
        //User not logged in
        Get.snackbar("Error", e.message);
      }
      else{
        Get.snackbar("Error", "An error occurred. Please try again later");
      }
    }
    return null;
  }

  static Future<http.Response?> deleteWithJson(String url, Map<String, dynamic> body) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};

      //Add accessToken
      ParadiseAuthenticate.addAuthorizationHeader(headers);

      http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );
      if(response.statusCode == 403 || response.statusCode == 401){
        await ParadiseAuthenticate.getAccessToken();

        ParadiseAuthenticate.addAuthorizationHeader(headers);

        response = await http.delete(
          Uri.parse(url),
          headers: headers,
          body: json.encode(body),
        );
        if(response.statusCode == 403 || response.statusCode == 401) return null;
      }
      return response;
    } catch (e) {
      if(e is AuthenticationException){
        //User not logged in
        Get.snackbar("Error", e.message);
      }
      else{
        Get.snackbar("Error", "An error occurred. Please try again later");
      }
    }
    return null;
  }



  static Future<void> _getVisaTypes() async {
    //TODO: Fetch data from the server
    _visaTypes = [
      VisaType.basicDetails(
        visaId: 'tourist_30',
        title: 'Tourist Visa – 30 Days',
        duration: 30,
      ),
      VisaType.basicDetails(
        visaId: 'visitor_6m',
        title: 'Tourist Visa – Standard Visitor Visa',
        duration: 60,
      ),
      VisaType.basicDetails(
        visaId: 'multi_1y',
        title: 'Tourist Visa – One Year Multiple Entry Visa',
        duration: 90,
      ),
      VisaType.basicDetails(
        visaId: 'multi_2y',
        title: 'Tourist Visa – Two Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'multi_5y',
        title: 'Tourist Visa – Five Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'multi_10y',
        title: 'Tourist Visa – Ten Years Multiple Entry Visa',
        duration: 180,
      ),
      VisaType.basicDetails(
        visaId: 'free_30',
        title: 'Tourist Visa – Free Visa',
        duration: 30,
      )
    ];
  }

  static VisaType getVisaType(String id) {
    try {
      return _visaTypes.firstWhere((element) => element.visaId == id);
    } catch (e) {
      // Return a default VisaType or throw a custom exception
      return VisaType.basicDetails(
        visaId: 'default',
        title: 'Default Visa',
        duration: 0,
      );
    }
  }

  static Future<void> saveApplicantToDatabase(
      ApplicantEntity applicantEntity) async {
    try {
      final url =
          Uri.parse('http://13.51.159.48:3000/api/data/addApplicantEntity');

      // Prepare the request body
      final body = {
        "userId": 9, // You might want to get this from user authentication
        //"visaTypeId": applicantEntity.visaTypeId,
        "visaTypeId": "tourist_30",
        //"countryId": applicantEntity.countryId,
        "countryId": "CAN",
        "purpose":
            "Tourism", // You might want to add this field to your ApplicantEntity
        "startDate": applicantEntity.startDate.toIso8601String(),
        "endDate": applicantEntity.endDate.toIso8601String(),
        "placeOfStay":
            "Hotel ABC", // Add this field to ApplicantEntity if needed
        "addressOfStay": applicantEntity.addressOfStay?.isNotEmpty == true
            ? applicantEntity.addressOfStay
            : "Not provided",
        "cityOfStay": applicantEntity.cityOfStay?.isNotEmpty == true
            ? applicantEntity.cityOfStay
            : "Not provided",
        "zipOfStay": applicantEntity.zipOfStay?.isNotEmpty == true
            ? applicantEntity.zipOfStay
            : "Not provided",
        "entityMembers": applicantEntity.entityMembers
                ?.map((member) => {
                      "applicantId": 6,
                      "relation": member.relation.isNotEmpty == true
                          ? member.relation
                          : "Not specified",
                      "applliedDate": DateTime.now().toIso8601String(),
                      "completedDate": null,
                      "status": "Pending",
                      "reasonForReeject": "",
                      "placeOfIssue": member.applicant.nationality,
                      "givenName":
                          member.applicant.givenNames.isNotEmpty == true
                              ? member.applicant.givenNames
                              : "Not provided",
                      "surname": member.applicant.surname.isNotEmpty == true
                          ? member.applicant.surname
                          : "Not provided",
                      "dateOfBirth":
                          member.applicant.dateOfBirth.toIso8601String(),
                      "placeOfBirth":
                          member.applicant.placeOfBirth.isNotEmpty == true
                              ? member.applicant.placeOfBirth
                              : "Not provided",
                      //"placeOfBirth": "CAN",
                      "martialStatus":
                          member.applicant.maritalStatus?.isNotEmpty == true
                              ? member.applicant.maritalStatus
                              : "Not specified",
                      "photoUrl":
                          member.applicant.passportPhotoURL.isNotEmpty == true
                              ? member.applicant.passportPhotoURL
                              : "Not provided",
                      "gender": member.applicant.gender.isNotEmpty == true
                          ? member.applicant.gender
                          : "Not specified",
                      "passportNo":
                          member.applicant.passportNumber.isNotEmpty == true
                              ? member.applicant.passportNumber
                              : "Not provided",
                      "passportDateOfExpiry":
                          member.applicant.passportExpiryDate.toIso8601String(),
                      "passportUrl":
                          member.applicant.passportBioPageURL.isNotEmpty == true
                              ? member.applicant.passportBioPageURL
                              : "Not provided",
                      "occupation": member.applicant.occupation ?? "test",
                      "email": member.applicant.email.isNotEmpty == true
                          ? member.applicant.email
                          : "Not provided",
                      "mobileCountryCode":
                          member.applicant.phoneNumberCountryCode.isNotEmpty ==
                                  true
                              ? member.applicant.phoneNumberCountryCode
                              : "+1",
                      "mobileNo":
                          member.applicant.phoneNumber.isNotEmpty == true
                              ? member.applicant.phoneNumber
                              : "Not provided",
                      "whatsappCountryCode": member.applicant
                                  .whatsAppNumberCountryCode.isNotEmpty ==
                              true
                          ? member.applicant.whatsAppNumberCountryCode
                          : "+1",
                      "whatsappNo":
                          member.applicant.whatsAppNumber.isNotEmpty == true
                              ? member.applicant.whatsAppNumber
                              : "Not provided",
                      "homeAddress":
                          member.applicant.homeAddress.isNotEmpty == true
                              ? member.applicant.homeAddress
                              : "Not provided",
                      "emergencyConName": member.applicant
                                  .emergencyContactPersonName.isNotEmpty ==
                              true
                          ? member.applicant.emergencyContactPersonName
                          : "Not provided",
                      "emergencyConCountryCode": member
                                  .applicant
                                  .emergencyContactPersonPhoneCountryCode
                                  .isNotEmpty ==
                              true
                          ? member
                              .applicant.emergencyContactPersonPhoneCountryCode
                          : "+1",
                      "emergencyConNo": member.applicant
                                  .emergencyContactPersonPhone.isNotEmpty ==
                              true
                          ? member.applicant.emergencyContactPersonPhone
                          : "Not provided",
                      "hasVisitedBefore":
                          member.applicant.hasVisitedBefore ?? false,
                      "lastVisitedDate":
                          member.applicant.lastVisitedDate?.toIso8601String(),
                      "accomodationUrl":
                          member.applicant.accommodationPlaceDocumentURL,
                      "returnTicketUrl": member.applicant.returnAirTicketURL,
                      "facebookURL": member.applicant.facebookURL,
                      "instagramURL": member.applicant.instagramURL,
                      "xURL": member.applicant.xURL,
                      "travelHistory": member.applicant.travelHistory
                              ?.map((history) => {
                                    "country":
                                        history.country.isNotEmpty == true
                                            ? history.country
                                            : "AUS",
                                    "entryDate":
                                        history.entryDate.toIso8601String(),
                                    "purpose":
                                        history.purpose.isNotEmpty == true
                                            ? history.purpose
                                            : "Not provided",
                                    "attachment": history.attachment,
                                  })
                              .toList() ??
                          [],
                    })
                .toList() ??
            [],
        "mainApplicant": {
          "reviewedId": applicantEntity.mainVisaApplicant?.applicantId ?? 0,
          "applliedDate": DateTime.now().toIso8601String(),
          "completedDate": null,
          "status": "Pending",
          "reasonForReeject": "",
          "givenName":
              applicantEntity.mainVisaApplicant?.givenNames.isNotEmpty == true
                  ? applicantEntity.mainVisaApplicant?.givenNames
                  : "Not provided",
          "surname":
              applicantEntity.mainVisaApplicant?.surname.isNotEmpty == true
                  ? applicantEntity.mainVisaApplicant?.surname
                  : "Not provided",
          "dateOfBirth": applicantEntity.mainVisaApplicant?.dateOfBirth
                  .toIso8601String() ??
              DateTime.now().toIso8601String(),
          "placeOfBirth":
              applicantEntity.mainVisaApplicant?.placeOfBirth.isNotEmpty == true
                  ? applicantEntity.mainVisaApplicant?.placeOfBirth
                  : "Not provided",
          //"placeOfBirth": "CAN",
          "martialStatus":
              applicantEntity.mainVisaApplicant?.maritalStatus?.isNotEmpty ==
                      true
                  ? applicantEntity.mainVisaApplicant?.maritalStatus
                  : "Not specified",
          "photoUrl":
              applicantEntity.mainVisaApplicant?.passportPhotoURL.isNotEmpty ==
                      true
                  ? applicantEntity.mainVisaApplicant?.passportPhotoURL
                  : "Not provided",
          "gender": applicantEntity.mainVisaApplicant?.gender.isNotEmpty == true
              ? applicantEntity.mainVisaApplicant?.gender
              : "Not specified",
          "passportNo":
              applicantEntity.mainVisaApplicant?.passportNumber.isNotEmpty ==
                      true
                  ? applicantEntity.mainVisaApplicant?.passportNumber
                  : "Not provided",
          "passportDateOfExpiry": applicantEntity
                  .mainVisaApplicant?.passportExpiryDate
                  .toIso8601String() ??
              DateTime.now().add(const Duration(days: 365)).toIso8601String(),
          "passportUrl": applicantEntity
                      .mainVisaApplicant?.passportBioPageURL.isNotEmpty ==
                  true
              ? applicantEntity.mainVisaApplicant?.passportBioPageURL
              : "Not provided",
          "placeOfIssue": applicantEntity.mainVisaApplicant
              ?.nationality, // Add this field to VisaApplicant if needed
          "occupation": applicantEntity.mainVisaApplicant?.occupation ?? "test",
          "email": applicantEntity.mainVisaApplicant?.email.isNotEmpty == true
              ? applicantEntity.mainVisaApplicant?.email
              : "Not provided",
          "mobileCountryCode": applicantEntity
                      .mainVisaApplicant?.phoneNumberCountryCode.isNotEmpty ==
                  true
              ? applicantEntity.mainVisaApplicant?.phoneNumberCountryCode
              : "+1",
          "mobileNo":
              applicantEntity.mainVisaApplicant?.phoneNumber.isNotEmpty == true
                  ? applicantEntity.mainVisaApplicant?.phoneNumber
                  : "Not provided",
          "whatsappCountryCode": applicantEntity.mainVisaApplicant
                      ?.whatsAppNumberCountryCode.isNotEmpty ==
                  true
              ? applicantEntity.mainVisaApplicant?.whatsAppNumberCountryCode
              : "+1",
          "whatsappNo":
              applicantEntity.mainVisaApplicant?.whatsAppNumber.isNotEmpty ==
                      true
                  ? applicantEntity.mainVisaApplicant?.whatsAppNumber
                  : "Not provided",
          "homeAddress":
              applicantEntity.mainVisaApplicant?.homeAddress.isNotEmpty == true
                  ? applicantEntity.mainVisaApplicant?.homeAddress
                  : "Not provided",
          "emergencyConName": applicantEntity.mainVisaApplicant
                      ?.emergencyContactPersonName.isNotEmpty ==
                  true
              ? applicantEntity.mainVisaApplicant?.emergencyContactPersonName
              : "Not provided",
          "emergencyConCountryCode": applicantEntity.mainVisaApplicant
                      ?.emergencyContactPersonPhoneCountryCode.isNotEmpty ==
                  true
              ? applicantEntity
                  .mainVisaApplicant?.emergencyContactPersonPhoneCountryCode
              : "+1",
          "emergencyConNo": applicantEntity.mainVisaApplicant
                      ?.emergencyContactPersonPhone.isNotEmpty ==
                  true
              ? applicantEntity.mainVisaApplicant?.emergencyContactPersonPhone
              : "Not provided",
          "hasVisitedBefore":
              applicantEntity.mainVisaApplicant?.hasVisitedBefore ?? false,
          "lastVisitedDate": applicantEntity.mainVisaApplicant?.lastVisitedDate
              ?.toIso8601String(),
          "accomodationUrl":
              applicantEntity.mainVisaApplicant?.accommodationPlaceDocumentURL,
          "returnTicketUrl":
              applicantEntity.mainVisaApplicant?.returnAirTicketURL,
          "facebookURL": applicantEntity.mainVisaApplicant?.facebookURL,
          "instagramURL": applicantEntity.mainVisaApplicant?.instagramURL,
          "xURL": applicantEntity.mainVisaApplicant?.xURL,
          "travelHistory": applicantEntity.mainVisaApplicant?.travelHistory
                  ?.map((history) => {
                        "country": history.country.isNotEmpty == true
                            ? history.country
                            : "AUS",
                        "entryDate": history.entryDate.toIso8601String(),
                        "purpose": history.purpose.isNotEmpty == true
                            ? history.purpose
                            : "Not provided",
                        "attachment": history.attachment,
                      })
                  .toList() ??
              [],
        },
      };

      // Send the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Application saved successfully.');
        // Navigate to the next screen or perform any other action after saving
        // For example:
        // Get.to(() => ConfirmationScreen());
      } else {
        throw Exception(
            'Failed to save application. Status code: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save application: $e');
    }
  }
}
