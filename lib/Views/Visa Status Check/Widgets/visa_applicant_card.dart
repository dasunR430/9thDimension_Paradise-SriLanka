import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Utils/constants/sizes.dart';

class VisaApplicationView extends StatelessWidget {
  final String applicantName;
  final String visaType;
  final String status;
  final String applicationDate;
  final String passportNumber;

  VisaApplicationView({
    super.key,
    required this.applicantName,
    required this.visaType,
    required this.status,
    required this.applicationDate,
    required this.passportNumber,
  });

  Color _getBorderColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: _getBorderColor(status),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.all(ConstantSizes.md), // Add padding inside the border
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(ConstantSizes.sm),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: ConstantSizes.spaceBetweenItems),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Applicant Name:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      applicantName,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Visa Type: $visaType',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Passport Number: $passportNumber',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Application Date: $applicationDate',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: ConstantSizes.spaceBetweenItems),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Visa Status:',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                status,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: _getBorderColor(status),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // ElevatedButton(
          //   onPressed: () {
          //     // Add logic to check visa status
          //   },
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //   ),
          //   child: Text(
          //     'Check Status',
          //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
