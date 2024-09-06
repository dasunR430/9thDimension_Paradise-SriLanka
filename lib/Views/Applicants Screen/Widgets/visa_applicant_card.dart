import 'package:flutter/material.dart';

import '../../../Models/visa_applicant.dart';

class VisaApplicantCard extends StatelessWidget {
  final VisaApplicant? applicant;
  final VoidCallback? onRemove;

  VisaApplicantCard({required this.applicant, this.onRemove});

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
          leading: Icon(Icons.account_circle, size: 60, color: Colors.blue),
          title: Text(applicant?.givenNames ?? "Unknown", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          subtitle: Text(applicant?.passportNumber ?? "No Passport Number", style: TextStyle(fontSize: 14)),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}