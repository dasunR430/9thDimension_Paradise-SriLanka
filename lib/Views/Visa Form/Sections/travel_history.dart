import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/travel_country_controller.dart';
import '../../../Controllers/visa_application_controller.dart';
import '../../../Models/travelled_country.dart';
import '../../../Models/visa_applicant.dart';
import '../Widgets/travel_history_card.dart';
import '../../../Controllers/applicants_controller.dart';

class TravelHistoryScreen extends StatelessWidget {
  final TravelledCountryController travelController =
      Get.put(TravelledCountryController());
  final VisaApplicationController controller;
  final ApplicantController applicantController =
      Get.find<ApplicantController>();
  final String applicantType;
  final String visaSelectionType;

  TravelHistoryScreen({
    super.key,
    required this.controller,
    required this.applicantType,
    required this.visaSelectionType,
  });

  void setup() {
    applicantController.setApplicantType(applicantType);
    applicantController.setVisaSelectionType(visaSelectionType);
  }

  @override
  Widget build(BuildContext context) {
    setup();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 15),
            const Text(
              '5. Travel History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Upload supporting document (e.g., passport, visa, etc.)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Supported formats: JPG, PNG, PDF',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            TextButton(
              onPressed: () {
                travelController.addTravelledCountry(
                  TravelledCountry(
                    country: '',
                    entryDate: DateTime.now(),
                    purpose: '',
                  ),
                );
              },
              child: const Text(
                '+ Add Travel Info',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Obx(() {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: travelController.travelledCountryList.length,
                itemBuilder: (context, index) {
                  final travelledCountry =
                      travelController.travelledCountryList[index];
                  return TravelledCountryCard(
                    travelledCountry: travelledCountry,
                    onRemove: () =>
                        travelController.removeTravelledCountry(index),
                    onEdit: (updatedCountry) => travelController
                        .updateTravelledCountry(index, updatedCountry),
                    onUploadFile: (file) {
                      travelController.travelledCountryList[index].attachment =
                          file.path;
                    },
                    onCountryChanged: (String? newValue) {
                      if (newValue != null) {
                        travelController.travelledCountryList[index].country =
                            newValue;
                      }
                    },
                    onPurposeChanged: (String? newValue) {
                      if (newValue != null) {
                        travelController.travelledCountryList[index].purpose =
                            newValue;
                      }
                    },
                  );
                },
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.previousPage,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Finish'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final ApplicantController applicantController =
      Get.find<ApplicantController>();
  final VisaApplicant applicant;
  final String applicantType;

  SummaryScreen({super.key, required this.applicant, required this.applicantType});

  @override
  Widget build(BuildContext context) {
    final travelHistory = applicant.travelHistory ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Summary'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(applicantType=="Main" ? 'Main Applicant':'Other Applicant}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SummaryCard(applicant: applicant, travelHistory: travelHistory),
            const SizedBox(height: 20),
            const Text('Travel History',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            if (travelHistory.isNotEmpty)
              ...travelHistory
                  .map((travel) => TravelHistoryCard(travelledCountry: travel)),
            const SizedBox(height: 20),
            const Text('Uploaded Documents',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            UploadedImagesSection(applicant: applicant),
          ],
        ),
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final VisaApplicant applicant;
  final List<TravelledCountry> travelHistory;

  const SummaryCard({
    super.key,
    required this.applicant,
    required this.travelHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${applicant.givenNames} ${applicant.surname}',
                style: const TextStyle(fontSize: 16)),
            Text('Passport Number: ${applicant.passportNumber}',
                style: const TextStyle(fontSize: 16)),
            Text('Nationality: ${applicant.nationality}',
                style: const TextStyle(fontSize: 16)),
            Text('Gender: ${applicant.gender}',
                style: const TextStyle(fontSize: 16)),
            Text('Date of Birth: ${applicant.dateOfBirth.toLocal()}',
                style: const TextStyle(fontSize: 16)),
            Text('Place of Birth: ${applicant.placeOfBirth}',
                style: const TextStyle(fontSize: 16)),
            Text(
                'Phone Number: ${applicant.phoneNumberCountryCode} ${applicant.phoneNumber}',
                style: const TextStyle(fontSize: 16)),
            Text(
                'WhatsApp Number: ${applicant.whatsAppNumberCountryCode} ${applicant.whatsAppNumber}',
                style: const TextStyle(fontSize: 16)),
            Text('Email: ${applicant.email}',
                style: const TextStyle(fontSize: 16)),
            Text('Home Address: ${applicant.homeAddress}',
                style: const TextStyle(fontSize: 16)),
            Text('Emergency Contact: ${applicant.emergencyContactPersonName}',
                style: const TextStyle(fontSize: 16)),
            Text(
                'Emergency Contact Phone: ${applicant.emergencyContactPersonPhoneCountryCode} ${applicant.emergencyContactPersonPhone}',
                style: const TextStyle(fontSize: 16)),
            Text('Occupation: ${applicant.occupation}',
                style: const TextStyle(fontSize: 16)),
            Text('Marital Status: ${applicant.maritalStatus}',
                style: const TextStyle(fontSize: 16)),
            Text(
                'Accommodation Place Document URL: ${applicant.accommodationPlaceDocumentURL}',
                style: const TextStyle(fontSize: 16)),
            Text('Return Air Ticket URL: ${applicant.returnAirTicketURL}',
                style: const TextStyle(fontSize: 16)),
            Text(
                'Has Visited Before: ${applicant.hasVisitedBefore! ? 'Yes' : 'No'}',
                style: const TextStyle(fontSize: 16)),
            if (applicant.lastVisitedDate != null)
              Text('Last Visited Date: ${applicant.lastVisitedDate!.toLocal()}',
                  style: const TextStyle(fontSize: 16)),
            Text('Facebook URL: ${applicant.facebookURL}',
                style: const TextStyle(fontSize: 16)),
            Text('Instagram URL: ${applicant.instagramURL}',
                style: const TextStyle(fontSize: 16)),
            Text('X URL: ${applicant.xURL}',
                style: const TextStyle(fontSize: 16)),
            Text('LinkedIn URL: ${applicant.linkedInURL}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class TravelHistoryCard extends StatelessWidget {
  final TravelledCountry travelledCountry;

  const TravelHistoryCard({super.key, required this.travelledCountry});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            title: Text(travelledCountry.country),
            subtitle: Text(
                'Purpose: ${travelledCountry.purpose}\nEntry Date: ${travelledCountry.entryDate.toLocal()}'),
            trailing: travelledCountry.attachment != null
                ? const Icon(Icons.check, color: Colors.green)
                : const Icon(Icons.upload, color: Colors.grey),
          ),
          if (travelledCountry.attachment != null)
            _buildNetworkImage(
              travelledCountry.attachment!,
              'No passport bio page uploaded.',
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNetworkImage(String url, String fallbackText) {
    return url.isNotEmpty
        ? Image.network(
            url,
            height: 150,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return Text('Failed to load image: $fallbackText');
            },
          )
        : Text(fallbackText);
  }
}

class UploadedImagesSection extends StatelessWidget {
  final VisaApplicant applicant;

  const UploadedImagesSection({super.key, required this.applicant});

  Widget _buildNetworkImage(String url, String fallbackText) {
    return url.isNotEmpty
        ? Image.network(
            url,
            height: 150,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return Text('Failed to load image: $fallbackText');
            },
          )
        : Text(fallbackText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Passport Photo:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildNetworkImage(
          applicant.passportPhotoURL,
          'No passport photo uploaded.',
        ),
        const SizedBox(height: 20),
        const Text('Passport Bio Page:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        _buildNetworkImage(
          applicant.passportBioPageURL,
          'No passport bio page uploaded.',
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
