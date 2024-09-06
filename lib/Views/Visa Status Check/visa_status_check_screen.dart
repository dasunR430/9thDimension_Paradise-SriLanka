import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Status%20Check/Widgets/visa_applicant_card.dart';

class VisaApplicationScreen extends StatelessWidget {
  const VisaApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Applications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            VisaApplicationView(
              applicantName: 'John Doe',
              visaType: 'Tourist Visa',
              status: 'Pending',
              applicationDate: '2024-09-01',
              passportNumber: 'N1234567',
            ),
            const SizedBox(height: 20),
            VisaApplicationView(
              applicantName: 'Jane Smith',
              visaType: 'Business Visa',
              status: 'Approved',
              applicationDate: '2024-08-20',
              passportNumber: 'M8765432',
            ),
            const SizedBox(height: 20),
            VisaApplicationView(
              applicantName: 'Alex Johnson',
              visaType: 'Student Visa',
              status: 'Rejected',
              applicationDate: '2024-08-15',
              passportNumber: 'P4567890',
            ),
          ],
        ),
      ),
    );
  }
}