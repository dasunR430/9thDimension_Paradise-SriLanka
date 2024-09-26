import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/visa_applicant.dart';
import '../../Visa Form/Sections/travel_history.dart';

class VisaApplicantCard extends StatelessWidget {
  final VisaApplicant? applicant;
  final VoidCallback? onRemove;

  const VisaApplicantCard({super.key, required this.applicant, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading:
              const Icon(Icons.account_circle, size: 60, color: Colors.blue),
          title: Text(applicant?.givenNames ?? "Unknown",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(applicant?.passportNumber ?? "No Passport Number",
              style: const TextStyle(fontSize: 14)),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: onRemove,
              ),
              IconButton(
                icon: const Icon(Icons.info, color: Colors.blue),
                onPressed: () {
                  Get.to(() => SummaryScreen(applicant: applicant!));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
