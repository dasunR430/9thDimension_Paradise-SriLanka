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
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
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

  SummaryScreen(
      {super.key, required this.applicant, required this.applicantType});

  @override
  Widget build(BuildContext context) {
    final travelHistory = applicant.travelHistory ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Application Summary'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                applicantType == "Main" ? 'Main Applicant' : 'Other Applicant}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            SummaryCard(
                applicant: applicant,
                travelHistory: travelHistory,
                controller: applicantController),
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
  final ApplicantController controller;
  const SummaryCard({
    super.key,
    required this.applicant,
    required this.travelHistory,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow(
                'Name', '${applicant.givenNames} ${applicant.surname}'),
            _buildSeparator(),
            _buildInfoRow('Passport Number', applicant.passportNumber),
            _buildSeparator(),
            _buildInfoRow('Nationality', applicant.nationality),
            _buildSeparator(),
            _buildInfoRow('Gender', applicant.gender),
            _buildSeparator(),
            _buildInfoRow(
                'Date of Birth', applicant.dateOfBirth.toLocal().toString()),
            _buildSeparator(),
            _buildInfoRow('Place of Birth', applicant.placeOfBirth),
            _buildSeparator(),
            _buildInfoRow('Phone Number',
                '${applicant.phoneNumberCountryCode} ${applicant.phoneNumber}'),
            _buildSeparator(),
            _buildInfoRow('WhatsApp Number',
                '${applicant.whatsAppNumberCountryCode} ${applicant.whatsAppNumber}'),
            _buildSeparator(),
            _buildInfoRow('Email', applicant.email),
            _buildSeparator(),
            _buildInfoRow('Home Address', applicant.homeAddress),
            _buildSeparator(),
            _buildInfoRow(
                'Emergency Contact', applicant.emergencyContactPersonName),
            _buildSeparator(),
            _buildInfoRow('Emergency Contact Phone',
                '${applicant.emergencyContactPersonPhoneCountryCode} ${applicant.emergencyContactPersonPhone}'),
            _buildSeparator(),
            _buildInfoRow('Occupation', applicant.occupation ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('Marital Status', applicant.maritalStatus ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('Accommodation Place Document URL',
                applicant.accommodationPlaceDocumentURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow(
                'Return Air Ticket URL', applicant.returnAirTicketURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('Has Visited Before',
                applicant.hasVisitedBefore! ? 'Yes' : 'No'),
            _buildSeparator(),
            if (applicant.lastVisitedDate != null)
              _buildInfoRow('Last Visited Date',
                  applicant.lastVisitedDate!.toLocal().toString()),
            if (applicant.lastVisitedDate != null) _buildSeparator(),
            _buildInfoRow('Facebook URL', applicant.facebookURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('Instagram URL', applicant.instagramURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('X URL', applicant.xURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('LinkedIn URL', applicant.linkedInURL ?? 'N/A'),
            _buildSeparator(),
            _buildInfoRow('Activities', ''),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.applicantEntity.activities.map((activity) {
                return Padding(
                  padding: const EdgeInsets.only(left: 150.0, bottom: 4.0),
                  child: Text(
                    '• $activity',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
            _buildSeparator(),
            _buildInfoRow('Places', ''),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: controller.applicantEntity.places.map((place) {
                return Padding(
                  padding: const EdgeInsets.only(left: 150.0, bottom: 4.0),
                  child: Text(
                    '• $place',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 2),
        builder: (context, value, child) {
          return Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Colors.blue.shade200.withOpacity(value),
                  Colors.white,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3 * value),
                  blurRadius: 10 * value,
                  spreadRadius: 3 * value,
                ),
              ],
            ),
          );
        },
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Text(
              travelledCountry.country,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  'Purpose: ${travelledCountry.purpose}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Entry Date: ${travelledCountry.entryDate.toLocal().toString().split(' ')[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            trailing: travelledCountry.attachment != null
                ? const Icon(Icons.check_circle, color: Colors.green, size: 28)
                : const Icon(Icons.upload_file, color: Colors.grey, size: 28),
          ),
          if (travelledCountry.attachment != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildNetworkImage(
                travelledCountry.attachment!,
                'No passport bio page uploaded.',
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildNetworkImage(String url, String fallbackText) {
    return url.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              fit: BoxFit.contain,
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
                return Text(
                  'Failed to load image: $fallbackText',
                  style: const TextStyle(color: Colors.red),
                );
              },
            ),
          )
        : Text(
            fallbackText,
            style: const TextStyle(fontStyle: FontStyle.italic),
          );
  }
}

class UploadedImagesSection extends StatelessWidget {
  final VisaApplicant applicant;

  const UploadedImagesSection({super.key, required this.applicant});

  Widget _buildNetworkImage(String url, String fallbackText) {
    return url.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              url,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
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
                return Text(
                  'Failed to load image: $fallbackText',
                  style: const TextStyle(color: Colors.red),
                );
              },
            ),
          )
        : Text(
            fallbackText,
            style: const TextStyle(fontStyle: FontStyle.italic),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Passport Photo:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        _buildNetworkImage(
          applicant.passportPhotoURL,
          'No passport photo uploaded.',
        ),
        const SizedBox(height: 20),
        const Text(
          'Passport Bio Page:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
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
